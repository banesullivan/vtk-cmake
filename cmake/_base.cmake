# set(VTK_BUILD_LEGACY_REMOVE ON)
set(VTK_BUILD_TESTING OFF CACHE STRING "")
set(VTK_BUILD_DOCUMENTATION OFF CACHE STRING "")
set(VTK_BUILD_EXAMPLES OFF CACHE STRING "")

set(VTK_USE_LARGE_DATA ON CACHE STRING "")
set(VTK_LINKER_FATAL_WARNINGS ON CACHE STRING "")
set(VTK_ENABLE_EXTRA_BUILD_WARNINGS ON CACHE STRING "")
set(VTK_ENABLE_EXTRA_BUILD_WARNINGS_EVERYTHING ON CACHE STRING "")

set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")
# set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "")
# set(VTK_DEBUG_LEAKS ON CACHE STRING "")
# set(VTK_SMP_ENABLE_STDTHREAD OFF CACHE STRING "")

set(VTK_VERSION_SUFFIX "" CACHE STRING "")

# Wheel configuration
set(VTK_INSTALL_SDK ON CACHE STRING "")  # wheels turn this off by default
set(VTK_WHEEL_BUILD ON CACHE STRING "")
set(VTK_PYTHON_VERSION "3" CACHE STRING "")
# configuration_flag(VTK_WRAP_PYTHON "python")
set(VTK_WRAP_PYTHON YES CACHE STRING "")
set(VTK_MODULE_ENABLE_VTK_PythonInterpreter NO CACHE STRING "")
set(VTK_BUILD_PYI_FILES ON CACHE BOOL "")

include("${CMAKE_CURRENT_LIST_DIR}/_modules.cmake")
