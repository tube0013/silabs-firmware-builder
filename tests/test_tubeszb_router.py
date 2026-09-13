import subprocess
import tempfile
from pathlib import Path

# Compile the real callbacks against a small host-side SDK stub.
# This exercises behavior but does not replace an SLC/firmware build.
temporary = tempfile.TemporaryDirectory(prefix="tubeszb-router-test-")
root = Path(temporary.name)
headers = [
    "app/framework/include/af.h",
    "sl_component_catalog.h",
    "btl_interface.h",
    "network-steering.h",
    "stack/include/zigbee-device-stack.h",
    "app/framework/plugin/basic/basic.h",
    "sl_led.h",
    "sl_simple_led_instances.h",
    "sl_simple_button.h",
    "sl_simple_button_instances.h",
    "stack/include/source-route.h",
]
for h in headers:
    p = root / h
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text("")
common = r"""
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#define SL_COMPONENT_CATALOG_PRESENT 1
#define SL_CATALOG_LED0_PRESENT 1
#define SL_CATALOG_SIMPLE_BUTTON_PRESENT 1
#define SL_STATUS_OK 0
#define SL_STATUS_NETWORK_DOWN 1
#define SL_STATUS_NETWORK_UP 2
#define SL_ZIGBEE_NO_NETWORK 0
#define SL_ZIGBEE_JOINED_NETWORK 1
#define SL_ZIGBEE_LEAVE_NWK_WITH_NO_OPTION 0
#define SL_ZIGBEE_SOURCE_ROUTE_DISCOVERY_ON 1
#define SL_ZIGBEE_SOURCE_ROUTE_DISCOVERY_OFF 0
#define SL_SIMPLE_BUTTON_PRESSED 1
#define SL_SIMPLE_BUTTON_RELEASED 0
#define sl_zigbee_app_debug_println(...) ((void)0)
typedef int sl_status_t, sl_zigbee_network_status_t, sl_button_state_t, sl_button_t;
typedef struct Event { bool active; int delay; void (*handler)(struct Event*); } sl_zigbee_af_event_t;
static int network,led,starts,start_result,leaves,reboots,announcements,route_mode;
static uint16_t ticks;
static int button_state,sl_led_led0,sl_button_btn1;
static void sl_led_turn_on(int *p){(void)p;led=1;}
static void sl_led_turn_off(int *p){(void)p;led=0;}
static int sl_zigbee_af_network_state(void){return network;}
static int sl_zigbee_af_network_steering_start(void){starts++;return start_result;}
static void sl_zigbee_af_event_set_inactive(sl_zigbee_af_event_t *e){e->active=false;e->delay=0;}
static void sl_zigbee_af_event_set_active(sl_zigbee_af_event_t *e){e->active=true;e->delay=0;}
static void sl_zigbee_af_event_set_delay_ms(sl_zigbee_af_event_t *e,int ms){e->active=true;e->delay=ms;}
static bool sl_zigbee_af_event_is_scheduled(sl_zigbee_af_event_t *e){return e->active;}
static void sl_zigbee_af_event_init(sl_zigbee_af_event_t *e,void(*f)(sl_zigbee_af_event_t*)){e->active=false;e->delay=0;e->handler=f;}
#define sl_zigbee_af_isr_event_init sl_zigbee_af_event_init
static void sl_zigbee_leave_network(int v){(void)v;leaves++;}
static void sl_zigbee_set_source_route_discovery_mode(int v){route_mode=v;}
static void bootloader_rebootAndInstall(void){reboots++;}
static void sl_zigbee_send_device_announcement(void){announcements++;}
static int sl_button_get_state(const sl_button_t*p){(void)p;return button_state;}
static uint16_t halCommonGetInt16uMillisecondTick(void){return ticks;}
"""
tests = r"""
static void press(uint16_t start,uint16_t end){ticks=start;button_state=1;sl_button_on_change(&sl_button_btn1);ticks=end;button_state=0;sl_button_on_change(&sl_button_btn1);button_event.handler(&button_event);}
int main(void){
 network=SL_ZIGBEE_NO_NETWORK;tubeszb_router_init(0);assert(commissioning_event.active);
 commissioning_event.handler(&commissioning_event);assert(starts==1 && led==1 && !commissioning_event.active);
 sl_zigbee_af_network_steering_complete_cb(3,0,0,0);assert(!led && commissioning_event.delay==10000);
 network=SL_ZIGBEE_JOINED_NETWORK;tubeszb_router_stack_status_cb(SL_STATUS_NETWORK_UP);assert(led && !commissioning_event.active && announcements==1);
 tubeszb_router_init(0);assert(led && !commissioning_event.active);
 press(100,200);assert(route_mode==SL_ZIGBEE_SOURCE_ROUTE_DISCOVERY_OFF);
 press(300,400);assert(route_mode==SL_ZIGBEE_SOURCE_ROUTE_DISCOVERY_ON);
 press(65000,5500);assert(leaves==1); /* Long press crossing the 16-bit timer wrap. */
 network=SL_ZIGBEE_NO_NETWORK;tubeszb_router_stack_status_cb(SL_STATUS_NETWORK_DOWN);assert(!led && commissioning_event.delay==10000);
 press(100,200);assert(!commissioning_event.active);
 press(300,400);assert(commissioning_event.active);
 start_result=3;commissioning_event.handler(&commissioning_event);assert(!led && commissioning_event.delay==10000);
 press(100,6000);assert(reboots==1);
 sl_button_t other=0;button_event.active=false;sl_button_on_change(&other);assert(!button_event.active);
 puts("Router LED, join/retry, restored network, and button tests passed");
}
"""
src = (
    Path(__file__).resolve().parents[1]
    / "src/zigbee_router/extension/tubeszb_router_extension/src/tubeszb_router_callbacks.c"
)
test = root / "test.c"
test.write_text(common + '\n#include "' + str(src) + '"\n' + tests)
out = root / "test"
subprocess.run(
    [
        "cc",
        "-std=c11",
        "-Wall",
        "-Wextra",
        "-Werror",
        "-I",
        str(root),
        str(test),
        "-o",
        str(out),
    ],
    check=True,
)
subprocess.run([str(out)], check=True)
temporary.cleanup()
