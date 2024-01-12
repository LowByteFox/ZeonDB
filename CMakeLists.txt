cmake_minimum_required(VERSION 3.22)
project(ZeonDB)

set(PROJECT_VERSION 0.6.0)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_definitions(ZEON_VERSION="${PROJECT_VERSION}")
add_compile_definitions(ARGPARSE_VERSION="v3.0")
add_compile_definitions(TOMLPLUSPLUS_VERSION="v3.4.0")
include_directories("src/include/" "external/")
link_directories("/usr/local/lib") # CMake forgets to set it, because of PkgConfig

find_package(PkgConfig REQUIRED)
pkg_check_modules(SSL libressl QUIET)

if(NOT SSL_FOUND)
    if(${CMAKE_SYSTEM_NAME} STREQUAL "OpenBSD")
        message("Detected OpenBSD! LibreSSL will be used, but under the name openssl")
    else()
        message("Detected ${CMAKE_SYSTEM_NAME}! Using OpenSSL :(")
    endif()

    pkg_check_modules(SSL openssl REQUIRED)
endif()

pkg_check_modules(UV libuv REQUIRED)

include(FetchContent)

FetchContent_Declare(
    tomlplusplus
    GIT_REPOSITORY https://github.com/marzer/tomlplusplus.git
    GIT_TAG v3.4.0
)
FetchContent_MakeAvailable(tomlplusplus)

FetchContent_Declare(
    argparse
    GIT_REPOSITORY https://github.com/p-ranav/argparse.git
    GIT_TAG v3.0
)

FetchContent_MakeAvailable(argparse)

file(GLOB_RECURSE ZEONDB_SOURCES "src/*.cpp")
list(FILTER ZEONDB_SOURCES EXCLUDE REGEX "src/client/.*")

add_library(ZeonAPI "src/client/zeonapi.cpp" "src/net/frame.cpp" "src/ssl.cpp")
target_include_directories(ZeonAPI PRIVATE ${SSL_INCLUDE_DIRS} ${UV_INCLUDE_DIRS})
target_link_libraries(ZeonAPI PRIVATE ${SSL_LIBRARIES} ${UV_LIBRARIES})
target_compile_options(ZeonAPI PRIVATE ${SSL_CFLAGS_OTHER} ${UV_CFLAGS_OTHER})

add_executable(ZeonDB ${ZEONDB_SOURCES})
target_include_directories(ZeonDB PRIVATE ${SSL_INCLUDE_DIRS} ${UV_INCLUDE_DIRS})
target_link_libraries(ZeonDB PRIVATE ${SSL_LIBRARIES} ${UV_LIBRARIES} tomlplusplus::tomlplusplus argparse::argparse)
target_compile_options(ZeonDB PRIVATE ${SSL_CFLAGS_OTHER} ${UV_CFLAGS_OTHER})

add_executable(ZeonCTL "src/client/main.cpp")
target_include_directories(ZeonCTL PRIVATE ${SSL_INCLUDE_DIRS} ${UV_INCLUDE_DIRS})
target_link_libraries(ZeonCTL PRIVATE ${SSL_LIBRARIES} ${UV_LIBRARIES} ZeonAPI argparse::argparse)
target_compile_options(ZeonCTL PRIVATE ${SSL_CFLAGS_OTHER} ${UV_CFLAGS_OTHER})
