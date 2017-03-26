SET(A64_PATH "/opt/linaro/gcc-linaro_aarch64_bare/bin/")    #your aarch64 compiler path
SET(A64_LD "${A64_PATH}aarch64-elf-ld")
SET(A64_CC "${A64_PATH}aarch64-elf-gcc")
SET(A64_OD "${A64_PATH}aarch64-elf-objdump")
SET(A64_OC "${A64_PATH}aarch64-elf-objcopy")

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR ARM)
SET(CMAKE_C_COMPILER ${A64_CC})
SET(CMAKE_C_LINK_EXECUTABLE "${A64_LD} <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> ")
