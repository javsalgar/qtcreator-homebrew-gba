project(%ProjectName%)

cmake_minimum_required(VERSION 2.8)
find_package(GBA REQUIRED)

aux_source_directory(. SRC_LIST)
add_gba_rom(${PROJECT_NAME} ${SRC_LIST})
