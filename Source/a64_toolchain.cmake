SET(A64_PATH "/opt/linaro/gcc-linaro_aarch64_bare/bin/")    #your aarch64 compiler path
SET(A64_LD "${A64_PATH}aarch64-elf-ld")
SET(A64_CC "${A64_PATH}aarch64-elf-gcc")
SET(A64_OD "${A64_PATH}aarch64-elf-objdump")

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR ARM)
SET(CMAKE_C_COMPILER ${A64_CC})
SET(CMAKE_C_FLAGS " -std=c99 -fno-common -fno-builtin -ffreestanding  -nostdinc ")
set(CMAKE_EXE_LINKER_FLAGS " -T ${CMAKE_SOURCE_DIR}/fr.lds -static ")
SET(CMAKE_C_LINK_EXECUTABLE " ${A64_LD}  <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> ")
