option(ASAN "ENABLE ASAN" OFF)
option(TSAN "ENABLE TSAN" OFF)
option(UBSAN "ENABLE UBSAN" OFF)

if(ASAN MATCHES "ON")
    set(CMAKE_CXX_FLAGS "-fsanitize=address -fsanitize-recover=address ${CMAKE_CXX_FLAGS}")
    message(STATUS "ASAN ENABLED")
    set(SANITIZER TRUE)
endif()

if(TSAN MATCHES "ON")
    set(CMAKE_CXX_FLAGS "-fsanitize=thread -fsanitize-recover=thread ${CMAKE_CXX_FLAGS}")
    message(STATUS "TSAN ENABLED")
    set(SANITIZER TRUE)
endif()

if(UBSAN MATCHES "ON")
    set(CMAKE_CXX_FLAGS "-fsanitize=undefined -fsanitize-recover=undefined ${CMAKE_CXX_FLAGS}")
    message(STATUS "UBSAN ENABLED")
    set(SANITIZER TRUE)
endif()