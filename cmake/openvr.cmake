include("${CMAKE_CURRENT_LIST_DIR}/_base.cmake")

set(VTK_MODULE_ENABLE_VTK_RenderingOpenVR YES CACHE STRING "")

# TODO: change these hardcoded values
set(OpenVR_INCLUDE_DIR "C:\Users\banes\source\repos\openvr\headers" CACHE STRING "")
set(OpenVR_LIBRARY "C:\Users\banes\source\repos\openvr\lib\win64\openvr_api.lib" CACHE STRING "")

set(VTK_DIST_NAME_SUFFIX "openvr" CACHE STRING "")
