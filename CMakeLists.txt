cmake_minimum_required(VERSION 2.8)
project(LLVMSlicing)

set(CMAKE_MODULE_PATH 
   ${CMAKE_MODULE_PATH}
   ${CMAKE_SOURCE_DIR}/cmake
   )

set(TIMING "tsc" CACHE STRINGS "Select timing implement")
set_property(CACHE TIMING PROPERTY STRINGS "tsc" "tscp" "clock_gettime")
option(DYNAMIC_LINK "Link Dynamic LLVM Libraries" ${LLVM_DYNAMIC_LIBRARY_FOUND})


if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
endif()

find_package(LLVM)

add_subdirectory(include)
add_subdirectory(lib)
add_subdirectory(src)
