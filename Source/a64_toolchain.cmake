SET(A64_LD "aarch64-elf-ld")
SET(A64_CC "aarch64-elf-gcc")

#SET(CMAKE_SYSTEM_NAME Generic)
#SET(CMAKE_SYSTEM_PROCESSOR ARM)
SET(CMAKE_C_COMPILER ${A64_CC})
SET(CMAKE_C_FLAGS " -std=c99 -fno-common -fno-builtin -ffreestanding  -nostdinc ")
SET(CMAKE_ASM_FLAGS "${CFLAGS} -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS " -T ${CMAKE_SOURCE_DIR}/fr.lds -static ")
SET(CMAKE_C_LINK_EXECUTABLE " ${A64_LD}  <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> ")
#set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)



