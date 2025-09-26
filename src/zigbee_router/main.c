/***************************************************************************//**
 * @file main.c
 * @brief main() function.
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

#ifdef SL_COMPONENT_CATALOG_PRESENT
#include "sl_component_catalog.h"
#endif
#include "sl_main_init.h"
#if defined(SL_CATALOG_POWER_MANAGER_PRESENT)
#include "sl_power_manager.h"
#endif
#if defined(SL_CATALOG_KERNEL_PRESENT)
#include "sl_main_kernel.h"
#else
#include "sl_main_process_action.h"
#endif // SL_CATALOG_KERNEL_PRESENT

#ifdef SL_ZIGBEE_TEST
#define main nodeMain
#endif

void app_init(void)
{
}

void app_process_action(void)
{
}

#if defined(__ICCARM__)
#pragma diag_suppress=Pe111
#endif // defined(__ICCARM__)
int main(void)
{
  // Initialize Silicon Labs device, system, service(s) and protocol stack(s).
  // Note that if the kernel is present, the start task will complete initialization.
  sl_main_init();

#if defined(SL_CATALOG_KERNEL_PRESENT)
  // Start the kernel. The start task will execute and run the application hooks.
  sl_main_kernel_start();
#else // SL_CATALOG_KERNEL_PRESENT
  // Initialize the application when no kernel is present.
  app_init();

  while (1) {
    // Silicon Labs components process action routine must be called from the super loop.
    sl_main_process_action();

    // Application process.
    app_process_action();

#if defined(SL_CATALOG_POWER_MANAGER_PRESENT)
    // Let the CPU go to sleep if the system allows it.
    sl_power_manager_sleep();
#endif // SL_CATALOG_POWER_MANAGER_PRESENT
  }
#endif // SL_CATALOG_KERNEL_PRESENT

  return 0;
}
