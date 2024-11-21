/***************************************************************************//**
 * @file app.c
 * @brief Callbacks implementation and application specific code.
 *******************************************************************************
 * # License
 * <b>Copyright 2021 Silicon Laboratories Inc. www.silabs.com</b>
 *******************************************************************************
 *
 * The licensor of this software is Silicon Laboratories Inc. Your use of this
 * software is governed by the terms of Silicon Labs Master Software License
 * Agreement (MSLA) available at
 * www.silabs.com/about-us/legal/master-software-license-agreement. This
 * software is distributed to you in Source Code format and is governed by the
 * sections of the MSLA applicable to Source Code.
 *
 ******************************************************************************/

#include "app/framework/include/af.h"
#ifdef SL_COMPONENT_CATALOG_PRESENT
#include "sl_component_catalog.h"
#endif

#ifdef SL_CATALOG_ZIGBEE_NETWORK_TEST_PRESENT
#include "network_test_config.h"
#endif //SL_CATALOG_ZIGBEE_NETWORK_TEST_PRESENT

#if (LARGE_NETWORK_TESTING == 0)

#include "btl_interface.h"
#include "network-steering.h"
#include "stack/include/zigbee-device-stack.h"
#include "app/framework/plugin/basic/basic.h"

#if defined(SL_CATALOG_LED0_PRESENT)
#include "sl_led.h"
#include "sl_simple_led_instances.h"

#define led_turn_on(led) sl_led_turn_on(led)
#define led_turn_off(led) sl_led_turn_off(led)
#define led_toggle(led) sl_led_toggle(led)
#define COMMISSIONING_STATUS_LED (&sl_led_led0)
#else // !SL_CATALOG_LED0_PRESENT
#define led_turn_on(led)
#define led_turn_off(led)
#define led_toggle(led)
#endif // SL_CATALOG_LED0_PRESENT

#if defined(SL_CATALOG_SIMPLE_BUTTON_PRESENT)
#include "sl_simple_button.h"
#include "sl_simple_button_instances.h"
#include "stack/include/source-route.h"

#define BUTTON_LONG_PRESS_TIME_MS 5000
#define PERMIT_JOIN_TIMEOUT_SEC 180

static bool button_long_press = false;
static sl_zigbee_af_event_t button_event;
static bool source_route_discovery_off = false;
#endif // SL_CATALOG_SIMPLE_BUTTON_PRESENT

#define NWK_STEERING_COOLDOWN_MS 10000

static sl_zigbee_af_event_t commissioning_event;

//---------------
// Event handlers

static void commissioning_event_handler(sl_zigbee_af_event_t *event)
{
  led_turn_on(COMMISSIONING_STATUS_LED);

  if (sl_zigbee_af_network_state() != SL_ZIGBEE_JOINED_NETWORK) {
    sl_status_t status = sl_zigbee_af_network_steering_start();
    sl_zigbee_app_debug_println("Join network start: 0x%X", status);
  }
}

#if defined(SL_CATALOG_SIMPLE_BUTTON_PRESENT)
static void button_event_handler(sl_zigbee_af_event_t *event)
{
  sl_zigbee_network_status_t state = sl_zigbee_af_network_state();

  if (state == SL_ZIGBEE_JOINED_NETWORK) {
    if (button_long_press) {
      sl_zigbee_app_debug_println("Btn long press: nwk up: leave network");
      sl_zigbee_leave_network(SL_ZIGBEE_LEAVE_NWK_WITH_NO_OPTION);
    } else {
      if (source_route_discovery_off) {
        source_route_discovery_off = false;
        sl_zigbee_app_debug_println("Btn press: nwk up: enable src route disc");
        sl_zigbee_set_source_route_discovery_mode(SL_ZIGBEE_SOURCE_ROUTE_DISCOVERY_ON);
      } else {
        source_route_discovery_off = true;
        sl_zigbee_app_debug_println("Btn press: nwk up: disable src route disc");
        sl_zigbee_set_source_route_discovery_mode(SL_ZIGBEE_SOURCE_ROUTE_DISCOVERY_OFF);
      }
    }
  } else if (state == SL_ZIGBEE_NO_NETWORK) {
    if (button_long_press) {
      bootloader_rebootAndInstall();
    } else {
      if (!sl_zigbee_af_event_is_scheduled(&commissioning_event)) {
        sl_zigbee_app_debug_println("Btn press: nwk down: start nwk steering");
        sl_zigbee_af_event_set_active(&commissioning_event);
      }
    }
  }
}
#endif // SL_CATALOG_SIMPLE_BUTTON_PRESENT

//----------------------
// Implemented Callbacks

/** @brief Stack Status
 *
 * This function is called by the application framework from the stack status
 * handler.  This callbacks provides applications an opportunity to be notified
 * of changes to the stack status and take appropriate action. The framework
 * will always process the stack status after the callback returns.
 */
void sl_zigbee_af_stack_status_cb(sl_status_t status)
{
  if (status == SL_STATUS_NETWORK_DOWN) {
    led_turn_off(COMMISSIONING_STATUS_LED);
    sl_zigbee_af_event_set_delay_ms(&commissioning_event, NWK_STEERING_COOLDOWN_MS);
  } else if (status == SL_STATUS_NETWORK_UP) {
    // make some noise on start for reconnect
    // (otherwise perceived as offline until pinged)
    sl_zigbee_send_device_announcement();
    led_turn_on(COMMISSIONING_STATUS_LED);
  }
}

/** @brief Init
 * Application init function
 */
void sl_zigbee_af_main_init_cb(void)
{
  sl_zigbee_af_event_init(&commissioning_event, commissioning_event_handler);

  #if defined(SL_CATALOG_SIMPLE_BUTTON_PRESENT)
  sl_zigbee_af_isr_event_init(&button_event, button_event_handler);
  #endif // SL_CATALOG_SIMPLE_BUTTON_PRESENT

  sl_zigbee_af_event_set_active(&commissioning_event);
}

/** @brief Complete network steering.
 *
 * This callback is fired when the Network Steering plugin is complete.
 *
 * @param status On success this will be set to SL_STATUS_OK to indicate a
 * network was joined successfully. On failure this will be the status code of
 * the last join or scan attempt.
 *
 * @param totalBeacons The total number of 802.15.4 beacons that were heard,
 * including beacons from different devices with the same PAN ID.
 *
 * @param joinAttempts The number of join attempts that were made to get onto
 * an open Zigbee network.
 *
 * @param finalState The finishing state of the network steering process. From
 * this, one is able to tell on which channel mask and with which key the
 * process was complete.
 */
void sl_zigbee_af_network_steering_complete_cb(sl_status_t status,
                                               uint8_t totalBeacons,
                                               uint8_t joinAttempts,
                                               uint8_t finalState)
{
  sl_zigbee_app_debug_println("Join network complete: 0x%X", status);

  if (status != SL_STATUS_OK) {
    led_turn_off(COMMISSIONING_STATUS_LED);
    sl_zigbee_af_event_set_delay_ms(&commissioning_event, NWK_STEERING_COOLDOWN_MS);
  }
}

/** @brief Reset To Factory Defaults
 *
 * This function is called by the Basic server plugin when a request to reset
 * to factory defaults is received. The plugin will reset attributes managed by
 * the framework to their default values. The application should perform any
 * other necessary reset-related operations in this callback, including
 * resetting any externally-stored attributes.
 *
 * @param endpoint   Ver.: always
 */
void sl_zigbee_af_basic_reset_to_factory_defaults_cb(uint8_t endpoint)
{
  bootloader_rebootAndInstall();
}

/** @brief
 *
 * Application framework equivalent of ::sl_zigbee_radio_needs_calibrating_handler
 */
void sl_zigbee_af_radio_needs_calibrating_cb(void)
{
  #ifndef EZSP_HOST
  sl_mac_calibrate_current_channel();
  #endif
}

#if defined(SL_CATALOG_SIMPLE_BUTTON_PRESENT)
/***************************************************************************//**
 * A callback called in interrupt context whenever a button changes its state.
 *
 * @remark Can be implemented by the application if required. This function
 * can contain the functionality to be executed in response to changes of state
 * in each of the buttons, or callbacks to appropriate functionality.
 *
 * @note The button state should not be updated in this function, it is updated
 * by specific button driver prior to arriving here
 *
   @param[out] handle             Pointer to button instance
 ******************************************************************************/
void sl_button_on_change(const sl_button_t *handle)
{
  static uint16_t button_press_time;
  uint16_t current_time = 0;
  sl_button_state_t button_state = sl_button_get_state(handle);

  if (button_state == SL_SIMPLE_BUTTON_PRESSED) {
    button_press_time = halCommonGetInt16uMillisecondTick();
  } else if (button_state == SL_SIMPLE_BUTTON_RELEASED) {
    current_time = halCommonGetInt16uMillisecondTick();
    button_long_press = (current_time - button_press_time) > BUTTON_LONG_PRESS_TIME_MS;

    sl_zigbee_af_event_set_active(&button_event);
  }
}
#endif // SL_CATALOG_SIMPLE_BUTTON_PRESENT

#endif //#if (LARGE_NETWORK_TESTING == 0)
