#configure compile
PROJECT(FreeRtos_PINE64 C ASM)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8) 

#flags must wrote in this file
SET(CMAKE_C_FLAGS " -std=c99 -fno-common -fno-builtin -ffreestanding ")#  -nostdinc ")
set(CMAKE_EXE_LINKER_FLAGS " -T ${CMAKE_SOURCE_DIR}/fr.lds -static ")

SET(TARGET_EXE_Z "frpine")

SET(A_SRC ${PROJECT_SOURCE_DIR}/src/portASM.S ${PROJECT_SOURCE_DIR}/src/vector_table.S ${PROJECT_SOURCE_DIR}/src/translation_table.S)

AUX_SOURCE_DIRECTORY(./src FR_SOURCE_DIR)

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)# ${PROJECT_SOURCE_DIR}/src)

ADD_EXECUTABLE(${TARGET_EXE_Z} ${A_SRC} ${FR_SOURCE_DIR} )

add_custom_command(OUTPUT  ${CMAKE_BINARY_DIR}/dump
    COMMAND ${A64_OD} -D -S ${CMAKE_BINARY_DIR}/${TARGET_EXE_Z} > dump
    COMMAND ${A64_OC} -O binary frpine frpine.bin
    COMMENT "this is dump and bin file")

add_custom_target(dumpfile ALL DEPENDS dump ${TARGET_EXE_Z})



