set(SDK_PATH "/home/byron/SimplicityStudio/SDKs/gecko_sdk")
set(COPIED_SDK_PATH "gecko_sdk_4.4.4")

add_library(slc_bootloader-uart-xmodem_MGM240PB32VNN OBJECT
    "${SDK_PATH}/platform/bootloader/communication/xmodem-parser/btl_xmodem.c"
    "${SDK_PATH}/platform/bootloader/communication/xmodem-uart/btl_comm_xmodem.c"
    "${SDK_PATH}/platform/bootloader/communication/xmodem-uart/btl_comm_xmodem_common.c"
    "${SDK_PATH}/platform/bootloader/core/btl_bootload.c"
    "${SDK_PATH}/platform/bootloader/core/btl_core.c"
    "${SDK_PATH}/platform/bootloader/core/btl_main.c"
    "${SDK_PATH}/platform/bootloader/core/btl_parse.c"
    "${SDK_PATH}/platform/bootloader/core/btl_reset.c"
    "${SDK_PATH}/platform/bootloader/core/flash/btl_internal_flash.c"
    "${SDK_PATH}/platform/bootloader/debug/btl_debug.c"
    "${SDK_PATH}/platform/bootloader/debug/btl_debug_swo.c"
    "${SDK_PATH}/platform/bootloader/driver/btl_driver_delay.c"
    "${SDK_PATH}/platform/bootloader/driver/btl_driver_uart.c"
    "${SDK_PATH}/platform/bootloader/driver/btl_driver_util.c"
    "${SDK_PATH}/platform/bootloader/gpio/gpio-activation/btl_gpio_activation.c"
    "${SDK_PATH}/platform/bootloader/parser/gbl/btl_gbl_custom_tags.c"
    "${SDK_PATH}/platform/bootloader/parser/gbl/btl_gbl_format.c"
    "${SDK_PATH}/platform/bootloader/parser/gbl/btl_gbl_parser.c"
    "${SDK_PATH}/platform/bootloader/security/btl_crc16.c"
    "${SDK_PATH}/platform/bootloader/security/btl_crc32.c"
    "${SDK_PATH}/platform/bootloader/security/btl_security_aes.c"
    "${SDK_PATH}/platform/bootloader/security/btl_security_ecdsa.c"
    "${SDK_PATH}/platform/bootloader/security/btl_security_sha256.c"
    "${SDK_PATH}/platform/bootloader/security/btl_security_tokens.c"
    "${SDK_PATH}/platform/bootloader/security/ecc/ecc.c"
    "${SDK_PATH}/platform/bootloader/security/sha/btl_sha256.c"
    "${SDK_PATH}/platform/bootloader/security/sha/crypto_sha.c"
    "${SDK_PATH}/platform/bootloader/security/sha/cryptoacc_sha.c"
    "${SDK_PATH}/platform/bootloader/security/sha/se_sha.c"
    "${SDK_PATH}/platform/common/src/sl_assert.c"
    "${SDK_PATH}/platform/common/src/sl_syscalls.c"
    "${SDK_PATH}/platform/common/toolchain/src/sl_memory.c"
    "${SDK_PATH}/platform/Device/SiliconLabs/MGM24/Source/startup_mgm24.c"
    "${SDK_PATH}/platform/Device/SiliconLabs/MGM24/Source/system_mgm24.c"
    "${SDK_PATH}/platform/emlib/src/em_acmp.c"
    "${SDK_PATH}/platform/emlib/src/em_burtc.c"
    "${SDK_PATH}/platform/emlib/src/em_cmu.c"
    "${SDK_PATH}/platform/emlib/src/em_core.c"
    "${SDK_PATH}/platform/emlib/src/em_dbg.c"
    "${SDK_PATH}/platform/emlib/src/em_emu.c"
    "${SDK_PATH}/platform/emlib/src/em_eusart.c"
    "${SDK_PATH}/platform/emlib/src/em_gpcrc.c"
    "${SDK_PATH}/platform/emlib/src/em_gpio.c"
    "${SDK_PATH}/platform/emlib/src/em_i2c.c"
    "${SDK_PATH}/platform/emlib/src/em_iadc.c"
    "${SDK_PATH}/platform/emlib/src/em_ldma.c"
    "${SDK_PATH}/platform/emlib/src/em_letimer.c"
    "${SDK_PATH}/platform/emlib/src/em_msc.c"
    "${SDK_PATH}/platform/emlib/src/em_opamp.c"
    "${SDK_PATH}/platform/emlib/src/em_pcnt.c"
    "${SDK_PATH}/platform/emlib/src/em_prs.c"
    "${SDK_PATH}/platform/emlib/src/em_rmu.c"
    "${SDK_PATH}/platform/emlib/src/em_se.c"
    "${SDK_PATH}/platform/emlib/src/em_system.c"
    "${SDK_PATH}/platform/emlib/src/em_timer.c"
    "${SDK_PATH}/platform/emlib/src/em_usart.c"
    "${SDK_PATH}/platform/emlib/src/em_vdac.c"
    "${SDK_PATH}/platform/emlib/src/em_wdog.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_hash.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_signature.c"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src/sl_se_manager_util.c"
    "${SDK_PATH}/platform/security/sl_component/sl_mbedtls_support/src/se_aes.c"
    "${SDK_PATH}/platform/security/sl_component/sl_mbedtls_support/src/sl_mbedtls.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.c"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.c"
    "${SDK_PATH}/platform/service/udelay/src/sl_udelay.c"
    "${SDK_PATH}/platform/service/udelay/src/sl_udelay_armv6m_gcc.S"
    "${SDK_PATH}/util/silicon_labs/silabs_core/memory_manager/sl_malloc.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/aes.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/constant_time.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/platform.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/platform_util.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/psa_crypto_client.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/psa_util.c"
    "${SDK_PATH}/util/third_party/mbedtls/library/threading.c"
    "${SDK_PATH}/util/third_party/trusted-firmware-m/lib/fih/src/fih.c"
    "${SDK_PATH}/util/third_party/trusted-firmware-m/platform/ext/target/siliconlabs/hse/sli_se.c"
)

target_include_directories(slc_bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
   "../config"
   "../autogen"
    "${SDK_PATH}/platform/Device/SiliconLabs/MGM24/Include"
    "${SDK_PATH}/platform/bootloader"
    "${SDK_PATH}/platform/bootloader/debug"
    "${SDK_PATH}/platform/bootloader/gpio/gpio-activation"
    "${SDK_PATH}/platform/bootloader/parser"
    "${SDK_PATH}/platform/bootloader/api"
    "${SDK_PATH}/platform/bootloader/security"
    "${SDK_PATH}/platform/bootloader/driver"
    "${SDK_PATH}/platform/bootloader/communication"
    "${SDK_PATH}/platform/bootloader/communication/xmodem-parser"
    "${SDK_PATH}/platform/CMSIS/Core/Include"
    "${SDK_PATH}/platform/emlib/inc"
    "${SDK_PATH}/platform/common/inc"
    "${SDK_PATH}/platform/security/sl_component/sl_mbedtls_support/config"
    "${SDK_PATH}/platform/security/sl_component/sl_mbedtls_support/config/preset"
    "${SDK_PATH}/platform/security/sl_component/sl_mbedtls_support/inc"
    "${SDK_PATH}/util/third_party/mbedtls/include"
    "${SDK_PATH}/util/third_party/mbedtls/library"
    "${SDK_PATH}/platform/security/sl_component/sl_psa_driver/inc"
    "${SDK_PATH}/platform/security/sl_component/se_manager/inc"
    "${SDK_PATH}/platform/security/sl_component/se_manager/src"
    "${SDK_PATH}/util/silicon_labs/silabs_core/memory_manager"
    "${SDK_PATH}/util/third_party/trusted-firmware-m/lib/fih/inc"
    "${SDK_PATH}/util/third_party/trusted-firmware-m/platform/include"
    "${SDK_PATH}/platform/common/toolchain/inc"
    "${SDK_PATH}/platform/service/udelay/inc"
)

target_compile_definitions(slc_bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    "MGM240PB32VNN=1"
    "SE_MANAGER_CONFIG_FILE=\"btl_aes_ctr_stream_block_cfg.h\""
    "BOOTLOADER_ENABLE=1"
    "BOOTLOADER_SECOND_STAGE=1"
    "SL_RAMFUNC_DISABLE=1"
    "__START=main"
    "__STARTUP_CLEAR_BSS=1"
    "BTL_GPIO_ACTIVATION=1"
    "BTL_UART_ENABLE=1"
    "BOOTLOADER_SUPPORT_COMMUNICATION=1"
    "SL_COMPONENT_CATALOG_PRESENT=1"
    "MBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>"
    "MBEDTLS_PSA_CRYPTO_CLIENT=1"
    "MBEDTLS_PSA_CRYPTO_CONFIG_FILE=<psa_crypto_config.h>"
    "SL_TRUSTZONE_SECURE=1"
)

target_link_libraries(slc_bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    "-Wl,--start-group"
    "gcc"
    "c"
    "m"
    "nosys"
    "-Wl,--end-group"
)
target_compile_options(slc_bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    $<$<COMPILE_LANGUAGE:C>:-mcpu=cortex-m33>
    $<$<COMPILE_LANGUAGE:C>:-mthumb>
    $<$<COMPILE_LANGUAGE:C>:-mfpu=fpv5-sp-d16>
    $<$<COMPILE_LANGUAGE:C>:-mfloat-abi=hard>
    $<$<COMPILE_LANGUAGE:C>:-Wall>
    $<$<COMPILE_LANGUAGE:C>:-Wextra>
    $<$<COMPILE_LANGUAGE:C>:-Os>
    $<$<COMPILE_LANGUAGE:C>:-fdata-sections>
    $<$<COMPILE_LANGUAGE:C>:-ffunction-sections>
    $<$<COMPILE_LANGUAGE:C>:-fomit-frame-pointer>
    "$<$<COMPILE_LANGUAGE:C>:SHELL:-imacros sl_gcc_preinclude.h>"
    $<$<COMPILE_LANGUAGE:C>:-mcmse>
    $<$<COMPILE_LANGUAGE:C>:-Wno-ignored-qualifiers>
    $<$<COMPILE_LANGUAGE:C>:-Wno-sign-compare>
    $<$<COMPILE_LANGUAGE:C>:--specs=nano.specs>
    $<$<COMPILE_LANGUAGE:C>:-g>
    $<$<COMPILE_LANGUAGE:CXX>:-mcpu=cortex-m33>
    $<$<COMPILE_LANGUAGE:CXX>:-mthumb>
    $<$<COMPILE_LANGUAGE:CXX>:-mfpu=fpv5-sp-d16>
    $<$<COMPILE_LANGUAGE:CXX>:-mfloat-abi=hard>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-Wall>
    $<$<COMPILE_LANGUAGE:CXX>:-Wextra>
    $<$<COMPILE_LANGUAGE:CXX>:-Os>
    $<$<COMPILE_LANGUAGE:CXX>:-fdata-sections>
    $<$<COMPILE_LANGUAGE:CXX>:-ffunction-sections>
    $<$<COMPILE_LANGUAGE:CXX>:-fomit-frame-pointer>
    "$<$<COMPILE_LANGUAGE:CXX>:SHELL:-imacros sl_gcc_preinclude.h>"
    $<$<COMPILE_LANGUAGE:CXX>:-mcmse>
    $<$<COMPILE_LANGUAGE:CXX>:-Wno-ignored-qualifiers>
    $<$<COMPILE_LANGUAGE:CXX>:-Wno-sign-compare>
    $<$<COMPILE_LANGUAGE:CXX>:--specs=nano.specs>
    $<$<COMPILE_LANGUAGE:CXX>:-g>
    $<$<COMPILE_LANGUAGE:ASM>:-mcpu=cortex-m33>
    $<$<COMPILE_LANGUAGE:ASM>:-mthumb>
    $<$<COMPILE_LANGUAGE:ASM>:-mfpu=fpv5-sp-d16>
    $<$<COMPILE_LANGUAGE:ASM>:-mfloat-abi=hard>
    "$<$<COMPILE_LANGUAGE:ASM>:SHELL:-imacros sl_gcc_preinclude.h>"
    "$<$<COMPILE_LANGUAGE:ASM>:SHELL:-x assembler-with-cpp>"
)

set(post_build_command ${POST_BUILD_EXE} postbuild "./bootloader-uart-xmodem_MGM240PB32VNN.slpb" --parameter build_dir:"$<TARGET_FILE_DIR:bootloader-uart-xmodem_MGM240PB32VNN>")
set_property(TARGET slc_bootloader-uart-xmodem_MGM240PB32VNN PROPERTY C_STANDARD 99)
set_property(TARGET slc_bootloader-uart-xmodem_MGM240PB32VNN PROPERTY CXX_STANDARD 11)
set_property(TARGET slc_bootloader-uart-xmodem_MGM240PB32VNN PROPERTY CXX_EXTENSIONS OFF)

target_link_options(slc_bootloader-uart-xmodem_MGM240PB32VNN INTERFACE
    -mcpu=cortex-m33
    -mthumb
    -mfpu=fpv5-sp-d16
    -mfloat-abi=hard
    -T${CMAKE_CURRENT_LIST_DIR}/../autogen/linkerfile.ld
    --specs=nano.specs
    "SHELL:-Xlinker -Map=$<TARGET_FILE_DIR:bootloader-uart-xmodem_MGM240PB32VNN>/bootloader-uart-xmodem_MGM240PB32VNN.map"
    -Wl,--gc-sections
    -Wl,--no-warn-rwx-segments
)

# BEGIN_SIMPLICITY_STUDIO_METADATA=eJztfQmTHLeZ5V9RdDg27B1VZVefJIeyQ2pSip7lFeymZ73DiQxUJqoq1Xk5j2bTDv33BZDI+8D1ZRblmBlZIrOA9x5u4APw4Z8nHz6+/4/XN/f2x/fv709enPzz88nH129+vL/962u7+dPnkxefT9brzye/nXxfxbl7/+njzes7Eu3lX54C/7tHnKReFP7w+WSzPv188h0Oncj1wj358On+59Wzzyd/+fPn8GWcRL9iJ/uORAnTF0HkYp+EOGRZ/MKyvnz5sk49H23TtRMFVppad1nuetEaO1GCCSiJHeMk+3rnkP+SeBzt8wmB/u67l7vId3HyXYgC+qMThTtvz3+jv3o+Ln9LfTvAQZR8tYtQ6wNBzxOP/ESDvbAOUYCt7dckCq1t7lFYK8ozaxtFmR8h8tdVjpJs9URTENhvf3l7dnH64afzs7++e2cVkNYQhzUkZpv5Nk2g7exmEdLFHxWxj73IRk7mPaKMlOWcekaoRqVxvPlKa5BkVI6Lt/l+zvxpEQzKwIHvbYty5YFny5sJqkFptOZvsZv56czNq0cikuPiR8/By6jqcY3WJoRJGrLETrMEo8De+pHzMGflmuIbFUmRbTfxSEc/p7YBmrFC3aHcz2wvpEMA7UMOKHFxSMacufTJcA6KjVNkO8nXOItmrHqDJIWcl1YxNA4NkyjPoj0Oh8fJj/ev7ZsoiKMQh1kKqprzWn2KsfJ2ylC2gzLkR7C5WOoZIxpR5XV6IZvjzKRtik5WYZagMN1FSbC01kHiUdWsPi+Tp8NUk8ooX+aFSyocpxxU6nvhA07ol7XvziCrgz+oYe0kTtkbkT/OoKLHIO7x9th5iOzUfbAv1uT/Gz1fK1jso4xW1ur3XohXbIRv/N4Lcef5HhH3hixpWsF6AVniOkH6aFGedPjKcM0ampFMy2M72AdnF+uJPL/zgpjI88h6ii2zrLtX/ye1qtyxygywinRajcRYTK9VCLJ6jJZA4dc0IwW6oMAOYVdfq7aMZv9t6Pi5K8x/xnIab8/PHsPJDsE8eVyR1aMUFADJi2J2uoy8Fp1AGksKWRkG8YJZV/HJicOTMyFwbTiVlrbNExQsKa4ilJWXOQvLKwil5DlBvqQ4TiclzXXcRTOu5JMTRzDDXbSovppSTmKASJzUSTyyPkoWVdpjlhMc+/6iMjmflDi8bEPBCg0F5ymZjCyqrmKUErhLE2fRplIRSsnbx2QWvaS8ilBSnrdo5pV80uLsOFq2+rVIpWQedgvXwIpQUt7Twuqe5MV5Z4s2Dk4nJw0tO0Uo+eTEOcg5LLTc6DJKCXzAX1MHLblea1JKSfTJVGJJfSWftLinLVp0atXkVBJJJmQ7L1x2GTfELScaZ16Al83YmlJO4tIjiq80ovgLjyi+yogSIM/fRk9L6mtQykmM0WG7sGGhySknMl109ON0ctIeFzVmcTopabETLjpbLfnkxCWL9tCcTlaanXr7EPlLS2zSSklNnQRlziFG7pJK26xyQvER+sIWqZzMZY0fqYLxIyUTyumjD+DqKkZZgQtbgGtGKYGLT7XUJlr54jOtXG2qtbj1Tc349uiiRWtfyScl7os7faQFWlzJp7Jbu4i8LqPUdu3Ax96n/of2Dm998mBqUz/FDsmC7Ov0jn56QAP7+Y185We1SDiQPfBau1UKtAi21abpZWVfEXKchUQ1mCZ1pXh2QTXFpBJ6QpGEO7u8mlVNm0ZWEUTblFDUa5DDzbHdGrDjTLcGEmC2LCXYFsefzEsaZq5MLDXI5l63iDkOOw0wVz4NEVmSumZuFSNcsuqw46bzdSDDVLLaoI6TSJVov/oJ8mwRZRWVYm1bRNxotzeqLosecLhQodZc0uq+xkvVuIpKoM1JnM28fUfFIFZyfja3koJBSsmcxVQxSJXOzEo2Oi1skQ695rKm1ha9KU9xiaW3SOgkiV91yTPPh05OAW0NsAiyuRkauNhHNImLnod2sY++zp9RFY2KqtmzqqKRLD9qGZm/TnEWYdNNPFRGmjGrejxqjba4aDy1ktn5KD1Mr2WoDi/McBISJSw8dDFQmRZDtobJhGvGThTgApnWp7kGKvFnycwugWhMJHFm01GCCzQEyAtn01CCCzTEKEnny4gKXaAiwSkG7+oqFRW6TJ2YoyE1wQUaDtiP4fvXSkUNL1Uic8mo0KVq51wqKnSBiqpbmUtIk0CgJY/3CYk8m5QGvkjJDLPLWsbApFI8+KPYE03X2Ui2Q0A3pxrSCbfVIxBkIU6SKHEi+OIsxbQIZFq8DXYPZEBNm2FCDoopR+FYhLuM8eBNHlTWOJMgt6piLnoR8B67V50aPNLS0ixK0H7+qt4kUp2ut3z8jA7MIp8Lep1Nw7tO18eHnHzmTUVoIaCBwNdxFNRqwYsWlczzS/olmllKSSEjB3wd2ckV5QKllzGml480xKp2fCReSHY8JUHnPoW3OqKGPDRJLSq7cYCLR1qrzAJTXJhFjykozq0vUYRb0kXkpJML7Aztwc2WhU6LsFgjbOKCI3EoLAJfRQ2Iq4mkdPGBa35dNZGKLuA6Pq5r6CDMRDnOr6smktLVrJPzi+uwAXQHThQEechne9O9QuGxhHkvEfcOFJe7noM3YTQkWw1V1gCxsBAb4dmf4Qcjab0NfhXZ8FNA2fzVOjTDAQfHoYGELliHeINrswpLYsFC6AvUNDq30OeVPkg3Of8UnWe8eXt3ezd1lPFGuN0x5vSmfXAwSL2UuU0jH2GGRCbdovqqY6F9lunTjCw490s7r6YGyaSk7B90qZjhJ5jheUBPm0Eif/ZAZ95G82Y/dOitK4V5pw3Oz2eT0iSYlBLEuY2S4PHZXFJaBOrTElGTZ75aJ08vJ92TmF3XUMwZEsQowrRYhNBqoE6s60mowmEPOHkFO81OPfKAc3NQATPUfmKbWryRSH1zbWHMSy1qDjrNjOfIbyyT39xpCzx5hTvNX3g9AaevYEXsHowZr0PuiSx3JBR1aQFOzUEFzNRhBTw1R53mZr4UwLlLVAE3v80PT18DTyugl6XB2TnoNHMUozkGswp2mp3ddgYnL1EF3AmMobFNnYguBZBAyRy9eiLTqwMdRWkRCw+g0DDswtoM3BXuNP9M7Vuydc80lEqOpOyKJTh5iTrNzW5QgnOXqGpbT14oNa+HWNUUagmh1UCVmdeDk4/49+zNrg/eDCkvUcVrCnjqIacAA8zMWgK0GdAV0MCe0EGdl8+SC23g6ZxAaYqBrqW3636FK6r9MFsenbovOmhS28nhy7/CFcwFULDLwxlafgNYMD4AGgBbCkaNfoNr+xlKQHgglIey9zjEiTdDIXTRxXYGcAkcVGxnAGce9Eo7YmeAJx/xezHMP9sw0IOXsXqAqxhxITto9ZiBfMhD7JDVA5x60DvooNUDnnrQ+eeg1QOce9gv5ZjVA55+zDnikNUDnH3Q79wA82xNvo0tY30Bl1DBSlhfwMmHPdgNWV/gqYcc1A1ZX+BnWzJjHdBVixax8IIFDTNHigfdrg3YfaD8rbXJR7yqjdid5uDPBo9MDPLPN7/s48vYwcBlSPb3M031JGd6YK7N2oucQQdmg3YwcO4h/2TK++HFQnVqQ1xgOEt9G4c5TCMrxHDzRQU7aT2BtF206aWMF8VriFAmhLYAKRsCCZdmKAMyoLQF1MBqplbBEYo6byFMw1wytQ23gAV5Rl3L+z7MFlBbQhNaLd+yKPKdA/IEp2f72dtPX/GyNmTqKnFlOmsK9ZOb/T5lLAl2gvdQ5qleSng97zFNnoCqkz6/Jhkxe8chM1/sFeenZhXVp4I/oDXoPbIbpvEGraCt1O9Np3lMn4ERPSI5eGVuIN/r11uR42AfJ3AnYGvPgo10Wv2k1O8uj4vp1p6JdERB6MX0EinQstAkGR0tEqmgL8B+EyUxJKTXhqUe1Bzq6Ac6o0IKSF8vnd5yDKi5RUWEwVwzqonEw54aZctgaKQaL4NF61w5UtTcgjKg79ojf+HGTVU2iAUSHSc4jsQGsUhigJwjaWwwi5tbgEK0x8HivTmrll16kdwD2hwnT5vMYpFnl1dHk9ngFgu93JwdTWiDWyB0f6zWvpdu7dj5NUYP+DgyO+TCWRCbezwiPwfy5qE6FLXppQZcmdUiRx50GKk3YHsNQHuHUZYnc2dZTVgdzxnRIDnZ5TEBzU+a2sfsVIPKycjAD4bYLo5x6OLQgXI+o6J/QodcKnjiEQZyXKUovkOvpNnx4gPQPoCe6lqAku4H/JUUVgLpPUNPf1+IcjqWmp0J06E2T2tFD4B2VPTEB1JPx/A4UYz+nmObHomjRXaU/mZIg5J6OM/kespH3JWPqc4SFKYxSgj0cTN+VIh6Oo5WBIMiZjQrtUZ4L/RgNmtkEl2Ylgb5tWZGR9Q97oVDYWa0tP4JHUqjwzb3/MwL2TPOx0jEiAyTkfp4qegLMZk5HTcdbSHqs+3jqS/plWdJx5McDN3TEihmL6jS5egRdbc06Kxujie9FqA+vzh6GibFaKfnAOXj3zw1h5EXAKTTcqw+aEKKdlqO1DeNK1FPyfGHtmk1Siu84xbLoAgl/ccvjFEhOuVwvG54TIdOKo7VYQ2rgNsVKPcYhVsCcucoarw5M6siqY4LtmjFWzx1eLhHsdS1jjyVJRA8f3uakqzQiprRCG4SxTBnKTVUN+iVZM895ZrSLD3HakZabuyYkq4xcHSjH1Do+l4I4/lCMwlNDUoJWGTtN6VebeHXjImyDNMj60esPR0JcqN1GTlKEcyLL5LCB8nVJdtbMvUNcHZk8W0Zcx72a4zYiyS4vI3RolVqGS7eeeG8+xYTcpv0SrJn32yZEi2/2dWbFh1J8fBLoaImvMTpl67qUQFKeV29mshM+0fK9J4Itdwvox8t95sC1ObyByIA8ukgjczvalBLwHGla4qe/ejOpGj5cztDS5gjqW7Qq6+gjqT5MPgOrEDwcuejpqRrHI4aXb0cMQlNDZorqCOpbwnQXkEdSXxHgq61UOPaYfLoOXjq1mHO3hc3v5ubwz3SzlVbBWS5IM1Hnmcfk8L87V8F7CmCu5lVdbjmuTqcwz0430kLr7D52FPz6jWx+9dOnSNz+kZyuxfGD17i0vevpq/L8tP60zXX97YJSrrVu3+DzKTe0tRYDdEWV2Zxcmvsql5TA5k5kQ6CHoPzAiMrlVBNj2lSV3ZIMHIN7X5CTS2WST1lFZ5VTpNESo3xpoW0pNEtirauFC0gqUEyqQb5ZOw2PRQubmVNlkk929AOcqPFqVBMTTGtBKX46gJkvSyW1Oea1kayMzf3YyrW1eaR0RRERrdTZCVxGklFdoK+LKSqpFJQRsr9EaXe4yJlOcQ5PfqxJbj9JUFGjgPFY1+bRzAim15BkxiKx+6Yjc8NbEo6s6ohOhWFS3Rn45STSrET19ZNw+uvQo1DZBLqFmioXaJpVYWpyY4jf94y7RJNqvKDKDMykAvlVAyTOgKXnhSaVUhNIVIyew/a4JjWEqcAl3jFclo0QkU4SSIjO7OUoIpFqIeueswM31KCahqhoixBzrxdT4tlehWDXD9yHmZV0+CY1vKwzLDW4RFpmr29NzgEWr4kXjZvzWlwSK1+FyqxIbZJfQn1peVn9gH7MTZzGS1UN8A1bT5NfdvF23y/iLpBNqE+x/fmNia0aYSKAs/M67uUnpJEqIZE3JwvM48cppNUaHrCQUHd2DmGXr/hJF/jLCrLfm7zWY9Na+dg5KluCWt5LwuQ2ZGZ0UR75TvI/O9I6mQMSrx5JtY9OZxIpCcNN8vo4UQSeuYbdodEjQ7Ag4bNRWTVVCJNzDi1jKaKSqQp93yX9J07ozdq5HW16EQuAcl/fH+hFtgkE3tTXEaSI1OCzgGRf85Ol5HUIJPSFUe+0Y6xorKSTqgN5pSdgjqlI3Xm59HklckePnMM/RLJK5JzQVS8BrQ6Wz8to6pFJ9RGC9pG7q95mtk+3iPnK59rLSR2kl9H/S6JgtnsjFL6mwqUUkAnuixyAXSEFAwoUE5BmtP1Kc6Om4oBFUopISuiIyjnrEpKny5Pnx9Bakkrp3XhBind+hoHfBaS12YUKcwS203MHgaVF9cgE+hipqhFRFVMQkXLrMddqfW4e1hm5s15BGqw4xqdZJeWUxKJ9SzUHVRMQkXM0/JCmiouoap5tiz6iga3LYY3t5dRJH1nY76Nyp6msc3KjqL9QqvuvdSq+/Dg7haRUxKJ9NBHDBYb0lpsAmV+sMwIwnkEakoX6wuu/fuUIo3zHC7s6ZJxcR24lwuJuZRRUzwpts13O3qpxfejZUwSI7wCtSFZJqWR84BnOibUVdnhE6nzyGrjYZ4Toz1lNZdAVeQtU/k5j0BNbPbMrbSaeOjZ276aeU6i9MQMHkbpaXHSzdlCekoqCU3L9FYVk4Si68UUXcsoKm+WLCKqQSapazmbQY9RVqGpMwp1hZIuKOjmx+b8dKEm0CAT6WK3ljF7vi9dZijsU4o0lneJFlHXIBPoSjwyNribq2W291psImUL2RoSKUsDfXBsETklkVjP2eXVUoo4lVjT+VKKzuX0XC40h6ipRJoW2p+Q25FgpwCRc1hmRGyxyShjW8dp7mULGYmHSGV0RtGDt2AWVnQS2jKPrtcW01bTCbTVF6KXkNZiEynzgsVkVVQCTfxlj0VENbgEqhbbwZTcs6TBbCdZpoNtksnpWqYVNsmkdKXLmOGbZFLuYXonfMmsVnS6d4EjMESFJX/SpTj+zLfeUU7+jEO09fG8Rqha4xi1km6+OU/dK8XIA3DwqJGAUQ06KUm/hlH4deZ9g9E0NNm/jdOzVKraydkiXeUjTcxJVDr7NK2Ro8PMaqrJGj7wMu9xedVtZjXVcN7idJQre4krL4Cw041Lqa3ZZNXNvlnXUid7SrcID/ZisIpI1UeCu9HCDD9l6RF6hmkFeqk4TpsTq9BLzfL93rQCuVSQiMm8BsGG4IpMTtsCJ2Yb4uRPxhbhF9mSaehT2JXhMapH2JaS2CKU1Oj9Y7kGU5FJasuS3FlsdK3Z5NQtulxQXBc8Ij9fTlzNJrUClnFL2Vslk8JJM+yudl4SfEEJXgVCB5Kiq7U77zC48JZ4ramT6wQJ9MpxP7H09rFFaJj7Uk43UBWGDQ5Dd4/lEgVZgSYSRf2YcjrpRGm/1FX246LqQQZLcfXIULLHQ+H6FckjuRWFPtoOXeYeiHBI+5fDBwuq8KE/dwWsfNCSfLGKZFuNNFlErlUr6RfjRFFO/qRS/NKX7Lu28V1gHxB1abGD7TSn8rHsSLvkIjs+Dz7L9EdF79R8aD7H2EWNs3vNqB+OhGDOKafHCX5EcfztvlZDI+HYIUbTttZMhtXQarXlWC3Gae8cVUjT+qCurVcBTB1Pt//SOj2BkRvgdeCOJ5JZ/Ii+KM+sbRRlfkSdaK1yUsFXT0Hk4sB++8vbs4vTDz+dn/313TurgWn1GWUg1qkfbwEVKXByxYXxJU/YGrqU/grvUO6T0ek7UojYb33ZRihxb5hByduSEs++kp/Jd9oPdD8H+4Dwxtvzs8cwJGGyKPKdA/LCgfikGnW/OlGwLurRmvy6TjPkkH/TC5EvLtb0/+3Ns83F2dnF5fV11QBf0iT7L1ycOokX01T9+aXV/1bUllbqybeXVpxEv2InI38++f7k7vbthze3N7f3f7Pv7j+9un1vv33/6tOb13cnL07+65+0UgXRIybF/2KH/BR/XxioMy98/cS6PNLTvPiv/64/30V54hRfyxuF1jbzbYRJS8kSupLAKLC31EGZ7eyYTez7VkjanoZ/KbwqDf60j73IRk7GLSXDgWh9qQwTQwF4XaqtdfXPOCATskIblzEQqOn+ZuBn0iuwKmZ7IS0AqvNAahoOvXAgWbQP6R3zH/zZxdTx/Wioomuqf6WlRRKa+6T7f/H55CWvDy/evmUfv3sK/DB9wb/+8PkzmW5lWfzCsr58+VJWVlJvrTS1PhSB1pgNJp9p2ymqAYtGRszio+eyv+fOuuBdpzjL43Xu3BSipNr03nEYWOwGLfQ/f2YVnQ3BdBc7Je00o17LWKj1/6b/tmigquaXKf0zyymumOQFRfzte9NKT/fd9ji0Pt6/tm/KpzRSXizlj74XPuCE9oZr32390nyAw3ZQhvxo34lMp5LtqmHzn8QB2RPY7AToeBRajevdFgE+q/O9QN9QHbvHAZ2O4X+tWlZNTGw2TtRT0Zu3d7d31g2dlNzyWakTpF5hFSf1LeFlqA5AHwLRjds4YaIanw0Hwfm5RtwgztkrJs804mb/KI3XosivWPdLJpBsbviGTg1ZnaqgSCUrumhjpNZsAwaNjJpBDAWFUyCkLZmwBHBYmbDmSmI5QQ6E5DoulChaufgmPgRagOxyGhkJewtZ0Ljwfg0AhcGKAOcpSsybdwG2SxMHqgj2sZNAVQ46MwaEsuMILMsOO7gsO+yeoKC8M6i89xBYG/eqU9QAYNRzqIOgBhCf9BiAUE9bBNXrlHDNd40hYDG93wUmErAV+HCtIECev42eoNBidNjCDelBCtWugkeoyU/shFAdY5xAVVWCVLwy6UMhkokBypxDjFwoQAxb1VKw+UFKesnKKgMABjcNhex/csgOCHJG9egiqPz64kbm5UhKMCNLOYaoDVYs4q00I/mUxxzMMQRrChNg1UYQC8Ue+R/d9ChspnESxTjJPPE42QGhplPmcseJXOEUZSAue2Rgh8Tr46m4dJcuFTeKSYiULHjQXkdGgqkDQ5lVWCMyPWmZhzz7ue278UUbqTBsrYoMaRi2FeqGJKChQmqGq9INJHIQcwad5TlZFbmNPY6GqV4uboJZzPKbEm83rgYve8pQg7N8AlE1XvF2hk5MMptQKxUej9Vu/YgaSlmnocNYRNRgzON9gpT66Doqdy6gEm/no/RQ97H0xTj2STXNozjyetimXb2LqKCgG1Ob006/RCq8bKOyiF7sWVaPhRsiKKSgh0C7QiMJrB4ZA2glgQxeHvIbx4AlIajdi/1rVe8wD+06KyRLGlJeJR+d91u/ANqSzjcnM5rAztA+VdAmADJSRIMglQo0jmGkg08WjXQoTzhT7OSJl30tBsbE2VwpCBiIrM98fmbAfH6my1z+xeavxxtjmOoonM6aKqlc1xqhcJ8rpmJq1y1GMFn0gEPzQuIwxmrKI/6qKNhx6P900lFG1WAlZVDo1y7SDoKmhvL2xkGrjtcIyHFMQFIsE7tYT7Hz7qlvo5T0rcJOvh2nvrkoHwfzN43kY6QZynJhZeRx6JWEOjVyOcDjUOsj8n1hG+SxqoOHpc49KbQ4wfxosqTeHkpxeswsNlmv7CXmMj0QnhFcgiAb2AE9xkvW5jJnGtoRpKpbK4rUsYJODGG1aYV3Dp5aKiROJ3TDNy5Oy0eTamedKGIzQC+CvcchmbKrZbK7FS7RWuEljhO0w0uZuAei6OS01EGATgzxdn8rgsRudzu8xJ52K4LM9nA7gtz2aiuOxIZgN7xOeUQxUuxYZHYF2xHEe3+t8AkKdnmolvpEsc6LzVvt4KrwUvts3SiZ2K47EEWrT1Gvj+qdhMxuVzuC3JHKVhyZfbA6Aj3eqzKq0PG6HHylRmseoRhJVWJQSUrhJazXrQh0FFEJjxUF8VFEJUoxFqjF8IQGx1YEOhYohadjgUoENhYoReBjgUocOhaohC86dZUYrFNXipAIp/Gt8IlidRJvXLSDF72nShT1YlCv4awLVInAujNBhHol2rhYQZek5V29cllXfRF1duqINr0qQNeNEv21Bnr3JVBo+Oo5T2jguRRLHvfTQG68dgSMfJDYz9KArTbMytfigfH7HopmIDig0PW521RgeHY4LsvFq1MNbCmrpQauzA6YJKzXxN1hlhNQkr2hemiMXVrH6u7adADoIba6a3h03p/CA5edEzzyQWLTXgO203nMQ1B1HvDwdecBjy2zTy4J22qIUQrWCHu49hYlOMCZNkN9pznNY3rTpDw01bzJSh/g8HFiMuBI8URB6MX0qI3YgqNDQy/OzpIU2vvS6/bIh9NNMR0ngMekr/5Bg/JnO8Fx9zNkQNWCAshqxpAPaAMvl+1HzgF7uTmDh60+Q8PSxlu7dgNBZn0qljkaoQZZ54EuLE0sP0ZVzuzqT5K7QZrghlPSQfjKEyTJa/FhWD1kozWzABtkySXBAdAvTXIEYoO3InAUo7/n2Kb7ITRroGsNhzdZ1o1BM7ccMZk9hdls8pscc6SBb0iQuhnj0MWhI3GTRIainGz2+xyADm0A3As9od1SBbrT38yC3HDWDtLP9xmMVq0CbJB1oARHo0ebhSMQ26/1gE0XmmPwvEebr3q2CWapQ20K+CLg+LPW0WbXPF9hDLDMUiIDPAYGJAUW+MJvksxaAwYHTyFFwi6G5uxaR7k0yaUueXTi8pVCLnXFZCou87d0FTBnUXeDMPpOPuHAhjNH+mGr8aPn8hCJN3YqSh4jDTcQGF9IPR3b/5AG2qIUX43di5ZHIQPd6IFceZTWw0YmSA4KsO+bF5XjGCfKOSDyz9kpDA59a9kcSbjvLI81tWCWRxlfU8pjsGOBq7P1mEMKBaTCLWLxFFjxhoddPyQHDr1LooAOL7DgdLxiyPUjJLDgzN0tvT4/BwF/FBcOsHyYEgARpqjSDNEFPX9x3ggsS8jMZPT8tDTO1D1ZBRDjMdY9GHe62HHHTmWoYJgXNN/TMIcZO74sDzF5BEYehjoMMQXZmw+rhwd3Z4xBd7EgWo4fGFf6QZ/R+mhj9nEFhEtjiGIav813O7owhpjBh2S4SSP6cLVxhoceGRUevpjCRJ5xVsejJ+LlIR7MEZx0M3ZDWAnFuN5QkGtjEL7qhcIBGakrsImjYPJgZCmwOT81z25mGsHsUENq3KzozBAidYlHmoW7uTJeNyXmgzjdkgfAGL8RrIIy5lBbBePSvKUDTNBTamKbcI+qBsQWomlePh9qjBdFDx6Issyj45UpUnagb7qMH6aVB/ICAJTpW0xKT81DYJDluXF15DjGJVXgpNqT5P4T37ooZjYL8dP0MKij78WDwjefcjcEHn7RHAhU6pSI+UvmhqCTd3D1Xtg2BJI51QT3ODUwOHihTz/jbAhePblsiGNmNxx5xtgQqvXcsClW+TSwKU71iq8hEFTPOnmCchTI97YJSr5a4yclxVF9bx9OnGwTAhS7XaJbLWIYtt015R1DFiKIlEfSPoKdIGU7xjAKyZlHlJL6rw0X2kGuna/FJN7+kiBlc2cFoTUA1LGbdnnNWtoCsen7lCByjGstduL6XuH4mW1JHLN6wq3RdhyNPjAjxPCDSN0MWEYOXJ19nEZsk0oaxKnmTKWJoGWKbwLQFaX6SNdEIBOBUfffQoAYufQ5Se3oD8YtgkCYFGP8oHUEo4peTls0+5m2NVEXpPH2pe+NH7GUAjIVQgMZF2pCL2j5GXdFrd1BMCNQkSMGCIUHYQApgTfqKkkqPvn75ty4266RJu6lC1FqW5ZkXRl4w5u6k9h5B3Z6jvxXVsoEEj0PR5H0NdXeLmTekzclKSfm3cfWoXE7q6vG09LfzGuh1UHNO/bXf6kXQxUezv5myuOGzW04xocozX6i9sx/pXL5ZrL6fzJ5gUx2izfmSe9CYuzTf6U8rl+FXjuJU9pjyR+/oe4kd8r431LG//fJ9yd3t28/vLm9ub3/m313/+nV7Xv7w6u3dycvTl7+heTO58/f8X2yHz6fbNann0/IFxw6EZ37kE+f7n9ePft88hfCSUg5JwkSogD/APHuOuXjz0N9vXPIfwlqSXPCWEkA8s/LXeQTtJq6qAatMGVIj1SHKlw68E49+ZU5a0RkgvEDz336kb2dTr+wOlpk9SR4+Q6Nzb1MggJ3HmyYhaN6cWiWrCmWFtC6maO2Its5Abz6xpX3edGL57vnKgDqrIOevU0zMicO7C01ZsxSj2gjr7Z0gPFJbrGxjSwNabdAm8IBJS4OSRcFTtY0NhiVyUur6LGan/i65QPKDuSveeLR1GW560Uvyv7cKvu1Aqvq59nfvpunz77HAV1B4QV6bT6Si7vtj/ev7ZtyzZTyQqhG5LoI+uUiU5+q1ZjtoAz50R6YwOv0HjZP99w07FIhM7jNRcjax7xpohT1AYbZqFjjTei3te/q4eq28aoVLNbIdc0P2g29Y98ZbPCdKKUVZyDsSIzi+dLR8COxGq+dCqKOALBskoo6poAtbhQQhttK96XXXn0j2V8bzZQfju23IDV5nbdjDdV10OTFDTRSxeK6LZq0aXkx7afx9vzsMSy7Mp0cuW0+QNzEMyww6pyccQJoa2EZ6ioeWi4fXoHItAoMRhlO4YQVWCC6tnmCAjBlFRqUtuKJGyhtBRqINv4qAYgyjgWiy3VcuCwrwWCUEU5+EBhGXI0Hoy9ABDN1Eo+s6xI4mT1YGLVxceAERiMHA1GGAVsGBmwZ9ctJMNIqOBB1uzRx4NpGhQairXoGCkRbhQakzYPLthIMTJlN/WCCyqsQQTQedpC1rkID0vYEKe0JThl/swxEGMeC0YUAx/4SDEZZdT8ORlsFB6KOngFyENhqq4kHoq98wg5EXAkGpuxpi+BmS01AUIXNR1lAlTaBYRTX7w/CCK3xYPSBjhk+6JjhQ44ZPuSYESDP30ZPYOIaeDD6YnTYQpoCmoAwClO4wY1jweh6hDM5cSwQXeXTnyDCSjAYZQlcN8yxoHQVrm59UH1NTBCdqZOgzDnEhfd4EJltSBiVGLrPayHCaAS0VaSAtor6SVoYaRUclDpIw2wNB6IOdvYEO3fKYSdPOezsCdZABmsfK98nBpFWgoEoKx81BlFWgkFuq5pr68LNsq8qFVQQSPRzd9O2PuKgej6g9K+tdzggPSClowGtwi2v0x+QeMe8TmDDI/ihvpJfYCiU55AU5DgQahow2oJSbKakjq8tgZ505F6ytGW0MSCkCDsBCSmSLV+lzXcbBqbHiXSTSyLrZTmJaPHI2nlN42tlckk+R+72awNnLd/5Upc7hCKle0KMSXMZATKVVHjNNVdU4ZgKkjpAIlVgshVNmDvmciocoBpkrkixq5uQlEUPOIQosxrIWFLpOMdUUYmjKchJnI1Bc6+i69OfnxnRF9GN6LVLoYpulPkm9BvI9mHexdZA05LkFhjdGUlxX0Vymt+/3FTcdikdSkinlL/QMwChme1NFJWyHxGiX/4cpXrpx0BJhQEhxSxTKgzD4qEmE8N6wiG0m2fiIb/hPE5HSg9kjobJruBqrb53PkoP+ssMmsLK/xTDUioy9jQUi2YNIxkt9zpwKgU4LWyR5UmpRj1Du7F1B8eoeORQnbyMqUkcIC/UIy5jahLHKEk1k1xF1aSmj9urdXcVdRXVpJyVG0czpiZx4UJJj7qOa5ThWtxVVKNqpkVdRdWkrroFLfZmbE0BebxPCKgefyOyLr3qnK/mlprq6Q3fKPZ0J9VsZNohmTtIjVQRQqsXWzNLmctCJ1Is01JBK7ZJU7blLlQMSGhH19CA4tj3nMLnBL/76SnaFqiWcRjNfKlKt+g21HraXhVpgBjrSbMoQXvDOttEmWdSPeIwRSqxLWcIsn0NjWK1Y8+yjqdeQLSX8exJOaWFGY1hteLqLg2Z+5L0S2TCX8Y30aC2Guykf6ZSpVci9BaBNOaqdpxjthzseOFRKika1+qosUZAjZaGXTyV4pQWCblM1KsSRZetWSm2vmFF2JJ+LCeddGBnaK9m3SyEWwTCGoEyK36CRymR2pJrQFWNYiyIj6+GgmoUKEEqbWNckNpRmckiMxRUoxgLatZJQ1UdqCN3HNSTeR7y2ahe/1G4SGHuUsz6EaqF+11TNJA00mA15FgDqEZVoYFV+oCfRWgDHEqv4gRVNkcXOB7D6RWGuNH8gKpcvFm3IY1KCqqQ+soWsWG3tBikYhDLaA6tejry5u3d7Z3qwcgb7W0ZdQ863dOIQeoVL1yRzxJjOEufRQVXJ137EPpnIxlU44FBTTENBG0t2T/KN7S0hLSjG+bIXuag3Ghu7OVPyg1rYI5Yg/NzPQ3N2Noagji3URI8PtPS0Iq91JRJtetg7leVz1Qncoc/+y6pmKsm4VDGRLH3ERpRNCwiJHbhTEiNsYqjR0m9BKkR8hiadFI7oW0+/S1Q6gpsK2Fha/HxGHp0WDk7sUl2cncxioxVJD3SwtWKGmcVR5fSkzBUdhg9XdskiU0daKjx8RiadNQthiIfj6JHyPw1qBGWUTQJub8ARc46lh4tvZKtRslj6NFFMVIeMqo4epTsDrUaYxlFkzCRMEC2+RLd8/wkcqLcoyYmParMqZUWm/ZZFRqX3YBTJawi6ZHqtEPDVqgzShkOUuwyphpjGUWPkN2xVCMso8yxheWFRrNe4RKiSAh9X6wRxWTWq8ao5HZzYBp68FTTWEbRn2Yr8slf/B+ka7xCrsbaiKhBTr2oq6e3HUsvzShNscxF83bNrSLp1l2J7YpOzdU9iFJbrRXLtIqkOQKjYJeHqi20EUuzB5e1cbVoFe1aIytU1QzWPrzJY9vM2b+nmsfdqPpLZDVeHkN/iaxGp+CvdXSJrMio5GZijFSvC+7FNVmlq1ErOVEdWaWrMsr7Rh1epavxKTjGHFmlK/Ip+LscWaWrEao4YhxfpStyqvkCHF6lq1EquFobpNNrmu2IJiYCNd4qjoGJQI1RxTPbsIlAkU/e4dqwiUBxcmIyosjcOGixad8zoHGV06bgMWzQIiHlIqzNqOQIbNQMokyaKWy+j5BqTrz6kU1sMWrchn2tznTIcDYk52WrPY1X8KU1YotRI5RzkQW8n1mszFQ3NDVNO6lv4zCXaGaFKr4ur+Jo2QKkF+VtTqNVefHGntQyuc1qtE4m8dMMZTLmgDZrHWsOM6Dm5nddBkKLJk8NNWm2YmnmIfVx7vsSOwxt3ma8OfIxiyLfOSBP8wSnbDGMZUvxjLB0plRqy+yp4899llC2c5pOqZ3gvZTtp5dg3qp6MNrHaurcMxRjqmLvOGSajPkjj/pq+jjf6nEfSW+I/XiNV1Y122v9SnKax/RxFJM3FxWuv01WgfrNVeQ42Kevg0o1ktrzXiNjrH4ay2tzU0zyNViYiCgIvZheGZVZnZqkoUMEkAT6Tuz8ZTDEotCDGD8+qTZqjWRWmUDx4CWdReWgVgObFimW81yophCrODKEKjO18VdUZnDVuhwKa2DDMqPvyyMfsuegEhuohvocJ5hBXwPVVF+AnDkENmDNW2WAQrTHAewIwapiF9tU6wFtZsjNJqy5wrPLq3k0NoDNVV5uzuZR2QA2VLmfpW3vwdo2dn6N0QOeQWMH2XgqxeY4j8jPZbx8qA42bexZRmGTpTJXqOAKcgQIZMz3GmLsHUZZnhiVSY1WnfAZIQCaj3NkWdufpnA1I6FANhmF+HkV28UxDl0cOlL+blTET5DAJIHnDMIyzrAUlXewQQU7XnyQ2X3Rk1yjg4p+wF9JMSbS3jb0xPdZwBMBMrUTJgJ2kteCD2Q2tfSUByAPyXDMKEZ/z7FND+PRwoTvXYYIQKVLOhjXk63kdVwsOUtQmMYoIdQzZvkoC3wi5sn8QYbfnW2rNTPwQk9iu0wmnwr71iD4LHOluUTr+NiYqpaD0xhQ8RMkoGPHNvf8zAvZm87gKRjhmHMEnykJfZY551IzJqLNAj/tnkl6iQ0+b5pJbyB/gUtaLntmla5V5xLdIphjgTOT7hodftIxbwImmWZLzEHKpb95Ug7KDv8VEzJLjzPBM1tC5uiJxmngkzHz+DVNBbrCm7FABhlAxc9cDKMsc5TATD3uGMkcSZilexqm+Pa2FMptTaP9BJhzH7UW7dKoEKpjni1M892nGk/yMS11oUpPbEmrNWynU3oBW2cTlvAmUSxxhlVDcgMbVLPRlG1KMNgcrQkKNA5N6Z5hEOrCH1Do+l4o4UtDU3+TAFS9+UpxSjrsMrGJjLIM01sIc1WaDj7MmF+CRymSeIZGUvUgMrxee0sm1QHO5lTe5vj9nUBsjPTmeVRetWlhgrYhF++80GCfZEJrExtUs9nOzpRiuD213kRqDrkqb4/Kt3TjMzRdyaPooLlcPdDI9g3myO4eA2y+l/Dz5HsTHXZGf8DOg/RbRxrZ3iWAVT+j7pkUm53+mVQMd/RnaJUzh+QGNvwKag7BB4XXY6XVAh2umtI9w8mq0QXOXPqbBDOtoOaQ3kKfbQU1h/IO/vHMjuAXPJNHzxG9zdCLlrN30Y9zEzuXfGKeJ80qwper4lzpcflpDcxd/1XA3i64M5HTAfrWb4jzPJRoZ60k81ZVxz76refxH3oVnixQRvOs76vg4CUufSxM/eY0v0ih17R8b5ugRK5dDhbu1B1MmgVWI2UWl2pxVkv9rmXnPlwUki6WHkf0gnELnlBGD0ZbUHZIMHKnLKFCMS0IbSFli9LX0UQwljG9UyOtRWNfpisoRaZaGgjaMpBP5jWT5+jFbacJoS1kG9pBPr7sFqqo4+tLQCm+uhCbAMRa+kD6okjm5gLHsmJBbRBTMUE0fldHVgvHAJBiJ+gLhJwSB0gSKf5HlHqP5sU2BKg/UjHzgv0lQeN+JMXjVBvEYNicvG4nMV6q36ebGrltL4gN2v0wFpQ0425pHE9bInbi2iI7dWFYKG4IyVCWafProujLKexjdhz5BsXXRdGW4wdRNm6cF+qoomsLCFx6UEpfQR3fRIJZF9gA0BcRp6Ibx2IdLQwjKThJonGbtpSSCsJICF13TFjXpZTUGEZSsgQ5Bl1IC0J/rYBcP3Ie9GU0APRFPAAMQR0QEzFmzbcBYCDiS+JlBrWjAWC8joQonCEobWEJ9T/mZ/YB+zGecOktlDUApG//TH3bxdt8by5rEMpImON7RgvxNoaRlMCbcKovJaREMJJBQDfnADO5YSwAaZPHHBRkqR9mGOgGnORrnEVlFTCyK/WgFrDrKz+0bWB+nshJNHHoZjTvvPIhZP53BHK2BiWexiy5p4WjmIpJww2AGI4CIEZz8B1SpDEMD8oqDH/mmmocU0HMggQgqMIxFZR7vkt64d34Wz/yolpYph4NyX98H6K9NZHM3UAC6HEgCs45IPLP2SmAngYSiKg48sd3dBVllVjGwiTO4ylIAz18Jzi8Ji8L6qSaM+UNSV4OjOOj4omm1dn6CUBSC8tYGC1/G7m/5mlm+3iPnK98ogahdBJ8Dum7JAr07IBS4pvwoPLp/JiBF0TQ8gfgweWnOV2w4mzGJAxQgCaDrJ2gZXNIUJlPl6fPoXWWmDBCIVsgWHNrnIKB0NaGM5WXJbabTDx7Kq+sgWQoilmizBVVMMZyABbRLsgi2j0AzKE5iKEU7Ljj59mltZQo5mIgWn4FYyyH+YaGEFQBGUvS2GDoy1HcZBiWIri9IS8H7KqG5m5hT5D6juGgnD3EUnkPslQ+PLg7cy0liqkY+qQCzHDVgjKU5QcAAwQHMZRS+n+HWq338UwFapy264mC8IAduJcQSi4hpBRPtG3z3Y5ecfH9CMCCMAJqKDUki6A0ch6wzqGbrsQOmKk0jywnHjROT/Zk1UCGkiIPoLZzEEMp8cSzwtJSYvlnhqekaBz+6ClRPP8xIsRJN2cQYkocAEEAvVIFAyDnGkbONYSc8u6EuaIGEpAooPV9Dw5K3qTLCHV5QI4i6A7F5vwUos43kExFsTvJmD04mAIMc308U4HlZRlzaQ0kQ1GJR0YHd3MFsKnWgjKVBWEXSECsAvQJM3MtJYq5mLPLKxA5HMdc0DmInHMYMZcQM4Max1QQxA4BzJ4AO5mHnAPAaNeCgpDFNnHT3MsgTLZDiBAio+jBg8q8CgtAWObRpRiMsBrLUFh9cddYVwvKVJYXwGiqcAwF8cc6zBU1gAwlwWwXAm0QUhjbSQB60SYSjCiANtdEAhGVApjDm0izeGop9XcOz5JZrenBWdOjKESCBXfipDjAzHfMUU7+jEO09bGBdakWOIYLKprvqVOfSTHyRB4XNdSPEsyRjPRrGIVfTaz+owloQn8Dx1OpTtijqUWiyyeZmNun1Gy+1sjLYVhYyWQ5H3iZ9wgsuQ0LK1nSm5uObHAvbuVtDXbaEERqDQUlzWxvrSUN6hhsgSf38q+KQujHfruwYYafshS6H5iGnycJMzQyMcU8SQHu4qbhYZJAgBMDS19DbYUEI8z0VGpDGdzp0wLPfEOlIQ5wT4UjVg+sgehroQEJ9P4B1EIqJCBhWZI7MINnDQUjDW7iDzzDf0R+DqSshppl1QvhirHMia7DxIQsRbC72nlJ8AUleBVoO0A0uf268w4aC3iAt5sGKwhRI38BuZ+D9C6yRTCYq1GOpVxlVW0iI3mi8yLFaJ5IN5WJPKG+SDnW7Hmy0Mtj5UBo0gDIHMS8AWQo2WN1nBG01PM9MoPz0Vb9Vvok8CFVuSk/Dtvez2BvFRg128p9LikMq8hLq5EJFtFt1TSqtVeztoFFnrP1jBS0uluEwaLNdoF9QNRfyU5huJ4q4HII7yKb7hFxOPVptopYvXn3t+4OvWhntkRvMxSXxGL+QfUmL/zkrM7zkZ0+iGCwc7eT3VAzrVZDvNXWYbXg9N29VCiTtVFdlGT1W9qP+NCnzgkhjNwArwOX5YfvhQ/YpTMc5NOBaTCLqsa4jaLMj6hzNitFQezjFYrj1LrDiYfT1Vnj91VOWvbqKYhcHFgNymaeveRt+wPKDtO8rzBz6H5XlNIbWkhvf3l7dmHdln2sHm6t1xyhuH8HgLOPvYj9a4WcjNu+AGBJV5uCpBPFHgBK+RgGRMYzOwcAELX65qHnQGV5C88qGsPKrBxu3t7d3lk3tGsyrPs4oIsStkLSAyhs5CYIo08xl9dw0jyOoyTjV5QXorHiBKd0ITEzm3rGiYwyUHDVew7AOdB4YRu+1rSe0ZkNm1lZ1HNZcn5hWoDTlocZ0LvTdMO+JIsi3zkgz7BX6T7/0kEKkJNEr+jbmh7r6KupEZtTnH746fzsr+/eyUa6e22//fHdj7+8/mjfvH/38+0v9s+3b16zmRQzjJIg/+vveZT9+zbzbYRJuWcJNTNjFNhb6tnVdnb79aEII0v60/v392/e//iKkL5+9+NPHb6NBszda6L+lX13T1KiB3b3xv7449ufP727sV/d3umLsqmIj/etyAGpE4rxP32wb968/vGj/dPdnWbu3L+xf/lw+97+8eb+9q8/3t++f6cP9IlIqspKvXQ+ffjwngDcvH/79tO72xsDMaSYCMqH9+9evyN4P97/+Ob9L/aHj6/vyN+lG8pPr1/dv7kbr/B+9u+NEa/c9v+zKv6Hux/tm49/+3D/npTlrYbAJsCE1qbbTFWtJD/vP366u/9/JEdpK/r0sVvAfDj9uXPnvdstDQaTChTIBAqj9GvaCUj72/cxTw/9yy1dCtZf17mzrvpklmsR+z4VbO3EeSuDyTiX4adVcH6+BPuuw76LHy9XabwINZn2Zzbaei0BB5R0170y7HT2QcovmSYvQ61piMD7B1+5NOjpVuv89GTKPG7uZIRvvDSrSCtxPn17zq5jd80qL62aUDUJKE1xsBWmoQr2TSaC2WcEKSjC8P/cOYkXZ60q8Ic4iX7FTmbRI697HFpFSGoWWvsL1M1dHjr0o01m1/S/aUsdmVUuUEFdlCFQfoWCCVFIxhWb9MrHSHkUeJm9S8ggYMcR8w5/BBEhPWfk4PhYxU/4kyzzFi540tZwgjL8FsVsLF4+3Y5N3ae5bAhqDsnPny/A/fQ0wv5v/7bpTldn4CdL1NAL9+ka+f4Rsr6iZwfsjikgxi4KM89pz4sKe/9yhZDg4oWZVFNGgB4wG7JQEqzpi7Xlfn9bx0iw3qx0FZAvPyjOTQ01ZIc82HZU8G/zk3cnxquAfPmBT49X7uZqERGDU2QihX5fke8/SE+XexR1xyNUUwcd6yFXaeb+INtNTuDHsYKYOB7vNAtB0j0nsKSh8XO1C6NV8fUogkYmFExW87fl6lLZ2dndEWf1n+zLstk0rxqtfOkPhav/5N+OlDezKVLJn9HF++q9cf1VzZk5tajkyfiCbbWjv63q35bNoMWEqeTW9BJ7tSt/P1quLS5Qqf1NL5FXOxpgxQKsqgALN8vlJark4LdhOgPM7280QaM2zfGQ32pShu0oI8HGjZv6Nk1DRcyq17PprchiCjvpD/TXNfvjElpKQ5Nd/N0OUNxW9X853ufvVm9R/MMf/vj+0/2HT/f2q9uPf7L+8McPH9//x+ub+3c/vn39pzWLLKG52Hxfe6RmcANzV67Lju3ZUdyeSQT74OziNN6enz2G3V1dxYbdyyAvHbrxMV7LV4ETdA0Qwjj/SVYY3j6MEuyu/p4j39t5OEk1QFKCsmL3tRNVDYJ6JozfPU2l1JiJ5HVxioUVf+qdnxXF4mbr4iiLy7wosM2x9T7M143ulT6Q1i23BmAndBFozZ6kjLIDTnySnP8pYpn4g+emJ8LvApympOxWPg732eGH04WrCF3aq1SSZvj/qSa/z2rioWSNv8SsYx/r1G9f0wX5+9Keo5Q3GmW6cj20Z6c0E5JQ8ssHdPrszDSRNIH0Az8jUdbbx8v1xXrTTfFEBF7RkeuycyjI/5Ti5HecN9XQfojSDHhs/x20znkm0eo55X+/Wu2dkdW3XHSST9Sstkq+PBGcfYDDDDax44sf5fQ+kb9UcKsvXnZYsSXislMiPnsXjHWqcI6XOLmPEhfHOHRx6HzV23z8dlIUkq7B7S215LcO9eYiw23LBOt3UDR12HKk8d2dj/aKY8ssHYJR1ktOKJspXzDdLy2+hGZ/++7lX54Cn+IWzkkJ8mZ9ytSTOhNRn67k06f7n1fPPp/8pQAol+DVec/cWQeRm5P+M8VZHq9v2BH7D0WwD6RF/cTyavjKnt06Cr9mh1UJNCGJcZJ9vXPIf3+gruP5ur+Zto5XPhn81I+LfXHuZq1qC+RTadtwhxtITFLCSv0uw/Gf//BHepMAkbaV/InqLX8kfy4O2P/hj1zzn0YuKw4o40fzP3+3ope3SLIyZkkp/AS6XvKihGZfyIc/FR9IobbELVTQMxWxNZ9iF+9Q7md3OMvYWZFvXnDu8Eyeo/l0rmdzA+dQP9RuaWsnccrj607iaLan5v3hdmU9+f7k7vbthze3N7f3f7Pv7j+9un1vf/j4/sPrj/e3r+9OXpz8U665fz558ZmE/fz5JEWPmLSNyHn4K0o86oo1pZ9f0H/RAPT/SC8deySU+/Am4jcz+Q8vyj/ssfMQ2an7YF+Q1dRF+fn78g/0+tL7uB+vbYjkH38r/kVin7wq6uXvQ+9vpHwKanrWMCXF8V//pFS8tAkMLe3vq1rHLlLRlPFbj/S+RnEZrfbSSEJHibf3yDKzCs6+8sZEPmy+ZwgZGeTI354/e/7s/Pnl6dVv3yuR07tR9D5ccRdKg/ji4vr09Or07FqDmN61tuu71toarjbPN+eXF9dnGhp4OzHI+s3F5vT56cXF5lKDnt1d10746vL5s6ur6/NniszsCnJR7lyAfvJX18+enZ1tzlUrwMA1JR32zdX59fXl9fWVauE3+Pl2iZGMzTlpf9fXz3Ua4PjlRD0pl8+vL883z1VrBZVCx47Kj6auguuz56Q1bM436kXC+n3bC38t7CE2PZWI6YkhbTWba9JDnV9cnqmWzMDdNJ3MODt99vzy+eb0Srp7KHdWP96/tm/Ku9CpZlGQinBG+ghl8uY9bJsMp8iPdOvjxfXm+mqzeXahrsHr9BE2/0lXydXF1dn55al0XzWhJEtQmLI3ykw0ba6fP9+cnV+cnetIYlUUImOunl9eXz0/k+9Euypqh+jmai6uTi+uLjfXp6piOkcRtCrI5elmc3r+XJW6twZQrwlXz8/PLp89v+g3VWZwGyBvuPfRSevp+TUds6S7BgWLgrqcq2fnZCg/f/78t/8++e3/A7LHh4U==END_SIMPLICITY_STUDIO_METADATA
