cmake_minimum_required(VERSION 3.21)

project(myd2d_1 LANGUAGES CXX)

add_executable(myd2d_1 WIN32
    myd2d_1.cpp
)

target_compile_features(myd2d_1 PRIVATE cxx_std_17)

target_compile_definitions(myd2d_1 PRIVATE
    UNICODE
    _UNICODE
    NOMINMAX
    WIN32_LEAN_AND_MEAN
)

target_link_libraries(myd2d_1 PRIVATE
    d2d1
)
