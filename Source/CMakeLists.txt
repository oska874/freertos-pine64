#configure compile
PROJECT(FreeRtos_PINE64 C ASM)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8) 

#SET(PORT portable)
SET(TARGET_EXE_Z "frpine")

#ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/src/portable/)

SET(A_SRC ${PROJECT_SOURCE_DIR}/src/portASM.S ${PROJECT_SOURCE_DIR}/src/vector_table.S)

#set_source_files_properties(${PROJECT_SOURCE_DIR}/src/portASM.s PROPERTIES COMPILE_FLAGS "-x assembler-with-cpp")
#set_source_files_properties(${PROJECT_SOURCE_DIR}/src/vector_table.S PROPERTIES COMPILE_FLAGS "-x assembler-with-cpp")

AUX_SOURCE_DIRECTORY(./src FR_SOURCE_DIR)

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)# ${PROJECT_SOURCE_DIR}/src)

ADD_EXECUTABLE(${TARGET_EXE_Z} ${A_SRC} ${FR_SOURCE_DIR} )


#COMMAND "${A64_OD} -D -S ${CMAKE_BINARY_DIR}/${TARGET_EXE_Z} > dump"
#COMMAND "/bin/ls -D -S ${CMAKE_BINARY_DIR}/${TARGET_EXE_Z} > ${CMAKE_BINARY_DIR}/dump"
#COMMAND "${A64_OD} ${CMAKE_BINARY_DIR}/${TARGET_EXE_Z} > ${CMAKE_BINARY_DIR}/dump"
add_custom_command(OUTPUT  ${CMAKE_BINARY_DIR}/dump
    COMMAND ${A64_OD} -D -S ${CMAKE_BINARY_DIR}/${TARGET_EXE_Z} > dump
    COMMENT "this is dump file")
add_custom_target(dumpfile ALL DEPENDS dump ${TARGET_EXE_Z})
#TARGET_LINK_LIBRARIES(${TARGET_EXE_Z} libport)
#TARGET_LINK_LIBRARIES(${TARGET_EXE_Z} src/portable/libport)



