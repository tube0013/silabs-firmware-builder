# Define minimal required version of CMake.
cmake_minimum_required(VERSION "3.25")

# Project definition
project(
	bootloader-uart-xmodem_MGM240PB32VNN
	VERSION 1.0
	LANGUAGES C CXX ASM
)

# Include the definition of the slc_bootloader-uart-xmodem_MGM240PB32VNN target,
# which contains the content of the SLC project
include(bootloader-uart-xmodem_MGM240PB32VNN.cmake)

add_executable(bootloader-uart-xmodem_MGM240PB32VNN
    # Add additional sources here
)

target_include_directories(bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    # Add additional include paths here
)

target_compile_definitions(bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    # Add additional macros here
)

target_compile_options(bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    # Set additional compiler flags here
)

target_link_options(bootloader-uart-xmodem_MGM240PB32VNN PUBLIC
    # Set additional linker flags here
)

# Link with the content defined in the SLC project
target_link_libraries(bootloader-uart-xmodem_MGM240PB32VNN PRIVATE
    slc_bootloader-uart-xmodem_MGM240PB32VNN
)

# Include managed project content if available
include(bootloader-uart-xmodem_MGM240PB32VNN_project.cmake OPTIONAL RESULT_VARIABLE managed_project)
if(managed_project)
    message(STATUS "Using managed project content from ${managed_project}")
endif()

# Force the gcc linker command
set_target_properties(bootloader-uart-xmodem_MGM240PB32VNN PROPERTIES LINKER_LANGUAGE C)

# Create .bin, .hex and .s37 artifacts after building the project
add_custom_command(TARGET bootloader-uart-xmodem_MGM240PB32VNN
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O srec "$<TARGET_FILE:bootloader-uart-xmodem_MGM240PB32VNN>" "$<TARGET_FILE_DIR:bootloader-uart-xmodem_MGM240PB32VNN>/$<TARGET_FILE_BASE_NAME:bootloader-uart-xmodem_MGM240PB32VNN>.s37"
    COMMAND ${CMAKE_OBJCOPY} -O ihex "$<TARGET_FILE:bootloader-uart-xmodem_MGM240PB32VNN>" "$<TARGET_FILE_DIR:bootloader-uart-xmodem_MGM240PB32VNN>/$<TARGET_FILE_BASE_NAME:bootloader-uart-xmodem_MGM240PB32VNN>.hex"
    COMMAND ${CMAKE_OBJCOPY} -O binary "$<TARGET_FILE:bootloader-uart-xmodem_MGM240PB32VNN>" "$<TARGET_FILE_DIR:bootloader-uart-xmodem_MGM240PB32VNN>/$<TARGET_FILE_BASE_NAME:bootloader-uart-xmodem_MGM240PB32VNN>.bin" 
)

# Run post-build pipeline to perform additional post-processing
if(post_build_command)
add_custom_command(TARGET bootloader-uart-xmodem_MGM240PB32VNN
    POST_BUILD
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/..
    COMMAND ${post_build_command}
)
endif()