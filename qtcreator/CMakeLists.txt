project(%ProjectName%)

cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

find_package(GBA REQUIRED)

aux_source_directory(. SRC_LIST)
add_gba_rom(${PROJECT_NAME} ${SRC_LIST})
