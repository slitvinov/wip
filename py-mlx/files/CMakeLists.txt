# pkgsrc: build only the mlx.core Python extension, against the installed
# MLX library (wip/mlx), instead of the whole MLX tree.
cmake_minimum_required(VERSION 3.25)
project(mlx_python LANGUAGES C CXX)

# Generate the type stubs, as the top-level CMakeLists.txt does by default;
# setup.py installs them (and expects an install target).
option(MLX_BUILD_PYTHON_STUBS "Build stub files for python bindings" ON)

find_package(MLX CONFIG REQUIRED)
find_package(
  Python 3.10
  COMPONENTS Interpreter Development.Module
  REQUIRED)
find_package(nanobind CONFIG REQUIRED)

# The bindings include their own headers as "python/src/...".
get_filename_component(MLX_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)
include_directories(${MLX_SOURCE_DIR})

add_subdirectory(${MLX_SOURCE_DIR}/python/src ${CMAKE_BINARY_DIR}/python)
