cmake_minimum_required(VERSION 2.7.1)

project(bloomgenerator)

set(CMAKE_CXX_FLAGS "-std=c++11 -pthread")
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0")

include_directories(
    "./"
    "../libbloom"
    ${OPENSSL_INCLUDE_DIR}
)

file(GLOB src "./src/*.cc")

add_executable(bloomgenerator ${src})

target_link_libraries(bloomgenerator "/src/libbloom/build/libbloom.so.1.6")
