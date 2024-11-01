/***************************************************************************//**
 * @file
 * @brief Top level application functions
 *******************************************************************************
 * # License
 * <b>Copyright 2020 Silicon Laboratories Inc. www.silabs.com</b>
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
#include <stdlib.h>

#include <em_msc.h>
#include <em_chip.h>

#include <btl_interface.h>

void bootloader_rebootAndInstall(void)
{
  // Set reset reason to bootloader entry
  BootloaderResetCause_t* resetCause = (BootloaderResetCause_t*) (SRAM_BASE);
  resetCause->reason = BOOTLOADER_RESET_REASON_BADAPP;
  resetCause->signature = BOOTLOADER_RESET_SIGNATURE_INVALID;
#if defined(RMU_PRESENT)
  // Clear resetcause
  RMU->CMD = RMU_CMD_RCCLR;
  // Trigger a software system reset
  RMU->CTRL = (RMU->CTRL & ~_RMU_CTRL_SYSRMODE_MASK) | RMU_CTRL_SYSRMODE_FULL;
#endif
  NVIC_SystemReset();
}

/***************************************************************************//**
 * Initialize application.
 ******************************************************************************/
void app_init(void)
{
  // This will set the program counter (startOfAppSpace + 4) to 0xFFFFFFFF, which
  // breaks the bootloader early with `BOOTLOADER_RESET_REASON_BADAPP`.
  MSC_Init();
  MSC_ErasePage((uint32_t*)BTL_APPLICATION_BASE);
  MSC_Deinit();

  bootloader_rebootAndInstall();
}

/***************************************************************************//**
 * App ticking function.
 ******************************************************************************/
void app_process_action(void)
{
}
