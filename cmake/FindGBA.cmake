#
# QTCreator Homebrew Project
# Author: Javier J. Salmeron Garcia
# E-mail: javsalgar@gmail.com
#
# FindGBA
#
# This module detects the Devkitpro compiler, and sets the corresponding compiler
# for GBA Roms
#
# The following variables are set:
#
# DEVKITPRO DEVKITARM: Path to the Devkitarm folder in the system. This is done by using the
# environment bash variable DEVKITARM or DEVKITPRO. These variables are set when installing
# devkitpro
#
# A function is added for compiling GBA Roms
#
# add_gba_rom : This function receives the rom name and the source files. 
#

set(CMAKE_SYSTEM_NAME Generic)
set(cmake_system_processor arm)
set(cmake_crosscompiling 1)
set(DEVKITARM $ENV{DEVKITARM})
set(DEVKITPRO $ENV{DEVKITPRO})

set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
set(CMAKE_C_COMPILER ${DEVKITARM}/bin/arm-none-eabi-gcc)
set(CMAKE_C_FLAGS "-mthumb-interwork -mthumb -O2 -Wall -fno-strict-aliasing -specs=gba.specs")
set(CMAKE_CXX_COMPILER ${DEVKITARM}/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_FLAGS "-mthumb-interwork -mthumb -O2 -Wall -fno-strict-aliasing -specs=gba.specs")

function(add_gba_rom ROMNAME)
    set(ROM_SRC ${ARGV})
    list(REMOVE_AT ROM_SRC 0)
    add_executable(${ROMNAME}.elf ${ROM_SRC})
    add_custom_target(${ROMNAME}.gba ALL
                   COMMAND ${DEVKITARM}/bin/arm-none-eabi-objcopy -v -O binary ${ROMNAME}.elf ${ROMNAME}.gba
                   COMMAND ${DEVKITARM}/bin/gbafix ${ROMNAME}.gba
                   DEPENDS ${ROMNAME}.elf
                   COMMENT "Creating GBA ROM ${ROMNAME}.gba")
    add_dependencies(${ROMNAME}.gba ${ROMNAME}.elf)
    set_directory_properties(PROPERTIES  ADDITIONAL_MAKE_CLEAN_FILES ${ROMNAME}.gba)
endfunction(add_gba_rom)