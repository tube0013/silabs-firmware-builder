// TubesZB MG24 UART/OTA bootloaders share this explicit slot configuration.
// End (exclusive) 0x08174000; existing router NVM starts at 0x08176000.
#ifndef BTL_STORAGE_SLOT_CONFIG_H
#define BTL_STORAGE_SLOT_CONFIG_H

#define SLOT_CUSTOM_CONFIG 1
#define SLOT_OVERLAP_ENABLE 0
#define SLOT0_ENABLE 1
#define SLOT0_START 0x080C0000UL
#define SLOT0_SIZE 0x000B4000UL
#define SLOT1_ENABLE 0
#define SLOT1_START 0
#define SLOT1_SIZE 0
#define SLOT2_ENABLE 0
#define SLOT2_START 0
#define SLOT2_SIZE 0

#define BTL_STORAGE_NUM_SLOTS 1
#define BTL_STORAGE_SLOTS { { SLOT0_START, SLOT0_SIZE } }
#define BTL_STORAGE_BOOTLOAD_LIST_LENGTH 1

#endif
