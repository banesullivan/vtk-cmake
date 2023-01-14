include("${CMAKE_CURRENT_LIST_DIR}/_base.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/_windows.cmake")

# Make sure to comment out where this is disabled in `_modules.cmake`
set(VTK_MODULE_ENABLE_VTK_RenderingOpenVR YES CACHE STRING "")
set(VTK_BUILD_PYI_FILES OFF CACHE BOOL "")

set(VTK_DIST_NAME_SUFFIX "openvr" CACHE STRING "")

# TODO: change these hardcoded values
set(OpenVR_INCLUDE_DIR "C:\\Users\\banes\\source\\repos\\openvr-1.23.7\\headers" CACHE STRING "")
set(OpenVR_LIBRARY "C:\\Users\\banes\\source\\repos\\openvr-1.23.7\\lib\\win64\\openvr_api.lib" CACHE STRING "")
