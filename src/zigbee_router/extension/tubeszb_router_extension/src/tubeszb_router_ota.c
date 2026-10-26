// TubesZB UART recovery for the combined UART/storage Gecko bootloader.
// Uses the reset-signalling ABI documented in the SDK's btl_reset_info.h.
#include "tubeszb_router_ota.h"
#include "btl_interface.h"
#include "em_device.h"

extern uint32_t __ResetReasonStart__;

void tubeszb_router_reboot_to_uart(void)
{
  volatile BootloaderResetCause_t *cause =
    (volatile BootloaderResetCause_t *)&__ResetReasonStart__;
  cause->reason = BOOTLOADER_RESET_REASON_FORCE;
  cause->signature = BOOTLOADER_RESET_SIGNATURE_VALID;
#if defined(RMU_PRESENT)
  RMU->CMD = RMU_CMD_RCCLR;
  RMU->CTRL = (RMU->CTRL & ~_RMU_CTRL_SYSRMODE_MASK) | RMU_CTRL_SYSRMODE_FULL;
#endif
  NVIC_SystemReset();
}
