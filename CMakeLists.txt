cmake_minimum_required(VERSION 3.22)
project(ZeonDB)

set(PROJECT_VERSION 0.9.9)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CTEST_COLOR_OUTPUT TRUE)
set(CMAKE_COLOR_MAKEFILE TRUE)
set(CMAKE_CTEST_ARGUMENTS "--output-on-failure")
enable_testing()

add_compile_definitions(ZEON_VERSION="${PROJECT_VERSION}")
add_compile_definitions(ARGPARSE_VERSION="3.0")
add_compile_definitions(TOMLPLUSPLUS_VERSION="3.4.0")
include_directories("src/include/" "external/")
if(WIN32)
	link_libraries("-static")
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fstack-protector-all")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fstack-protector-all")
endif()

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

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Debug)
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

include_directories(${SSL_INCLUDE_DIRS} ${UV_INCLUDE_DIRS})
link_directories(${SSL_LIBRARY_DIRS} ${UV_LIBRARY_DIRS})
link_libraries(${SSL_LIBRARIES} ${UV_LIBRARIES})
add_compile_options(${SSL_CFLAGS_OTHER} ${UV_CFLAGS_OTHER})

if(CMAKE_BUILD_TYPE MATCHES Debug)
	add_compile_options(-g)
endif()

file(GLOB_RECURSE ZEONDB_SOURCES "src/*.cpp")
list(FILTER ZEONDB_SOURCES EXCLUDE REGEX "src/client/.*")
add_library(ZeonAPI "src/client/zeonapi.cpp" "src/net/frame.cpp" "src/ssl.cpp")

add_library(ZeonCAPI STATIC "src/client/zeonapi.cpp" "src/client/zeonapi_c.cpp"
	"src/net/frame.cpp" "src/ssl.cpp")

add_library(ZeonCAPI_Shared SHARED "src/client/zeonapi.cpp"
	"src/client/zeonapi_c.cpp" "src/net/frame.cpp" "src/ssl.cpp")

set_target_properties(ZeonCAPI_Shared PROPERTIES OUTPUT_NAME ZeonCAPI)

add_executable(ZeonDB ${ZEONDB_SOURCES})
target_link_libraries(ZeonDB tomlplusplus::tomlplusplus argparse::argparse)

add_executable(ZeonCTL "src/client/main.cpp")
target_link_libraries(ZeonCTL ZeonAPI argparse::argparse)

add_subdirectory(tests)
