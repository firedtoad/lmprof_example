cmake_minimum_required(VERSION 3.16)
project(lua_memory_perf C CXX)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(UseFastestLinker)
include(Ccache)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -fno-omit-frame-pointer -Wall -pedantic -Wextra -march=native  -Wno-unused-parameter -Wno-unused-variable -Wno-ignored-qualifiers -fdiagnostics-color=auto ")

if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    #    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -fsanitize=address -fno-omit-frame-pointer")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-limit-debug-info")
    #    set(CMAKE_CXX_FLAGS_RELEASE  "-O2 -DNDEBUG")
endif ()

aux_source_directory("src" LMP_SRC)
aux_source_directory("3party/lpeg/" LPEG_SRC )


aux_source_directory("3party/lua52/src" LUA_52_SRC)
add_executable(lua5.2 ${LUA_52_SRC} ${LPEG_SRC} ${LMP_SRC})
target_include_directories(lua5.2 PRIVATE 3party/lua52/src)
target_compile_definitions(lua5.2 PRIVATE  LUA_COMPAT_ALL)


aux_source_directory("3party/lua53/src" LUA_53_SRC)
add_executable(lua5.3 ${LMP_SRC} ${LPEG_SRC} ${LUA_53_SRC})
target_include_directories(lua5.3 PRIVATE 3party/lua53/src)
target_compile_definitions(lua5.3 PRIVATE  LUA_COMPAT_5_2)


aux_source_directory("3party/lua54/src" LUA_54_SRC)
add_executable(lua5.4 ${LUA_54_SRC} ${LPEG_SRC} ${LMP_SRC})
target_include_directories(lua5.4 PRIVATE 3party/lua54/src)
target_compile_definitions(lua5.4 PRIVATE  LUA_COMPAT_5_3)

