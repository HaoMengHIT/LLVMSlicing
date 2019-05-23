add_definitions(${LLVM_DEFINITIONS} -Wall)
include_directories(
   ${LLVM_INCLUDE_DIRS}
   ../include 
   )

link_directories(${LLVM_LIBRARY_DIRS})

set(SELF ${CMAKE_CURRENT_SOURCE_DIR})
find_program(CLANG NAMES "clang-${LLVM_RECOMMEND_VERSION}" "clang")
add_custom_command(OUTPUT inst-timing
   COMMAND ${CLANG} -O0 -DTIMING_${TIMING} ${SELF}/inst-timing.c -emit-llvm -c -o /tmp/inst-timing.bc
   COMMAND ${LLVM_OPT} -load ${PROJECT_BINARY_DIR}/lib/libLLVMSlicing.so -InstTemplate /tmp/inst-timing.bc -o /tmp/inst-timing.1.bc
   COMMAND ${CLANG} -O0 /tmp/inst-timing.1.bc -o inst-timing -lm
   DEPENDS ${SELF}/inst-timing.c ${SELF}/libtiming.c ${SELF}/../lib/InstTemplate.cpp
   )
add_custom_target(InstTiming ALL DEPENDS inst-timing)

add_executable(libfn-timing
   libfn-timing.c
   )
target_link_libraries(libfn-timing m)
set_target_properties(libfn-timing
   PROPERTIES COMPILE_FLAGS "-DTIMING_${TIMING} -O0"
   )
