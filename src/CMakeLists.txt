aux_source_directory(. DIR_SRCS)
include_directories(
	${LLVM_PROF_INCLUDE_DIRS}
	${PROJECT_BINARY_DIR}
	${LLVM_INCLUDE_DIRS} 
   ../include
	)
link_directories(
   ${LLVM_LIBRARY_DIRS} 
   )

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall --std=c++11 -fno-rtti")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -DNO_DEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")

add_library(LLVMSlicing SHARED
	${DIR_SRCS}
	)

target_link_libraries(LLVMSlicing
	${LLVM_DYNAMIC_LIBRARY}
	)
