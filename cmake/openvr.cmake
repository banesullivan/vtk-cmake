include("${CMAKE_CURRENT_LIST_DIR}/_base.cmake")

set(VTK_MODULE_ENABLE_VTK_RenderingOpenVR YES CACHE STRING "")

set(VTK_DIST_NAME_SUFFIX "openvr" CACHE STRING "")

# TODO: change these hardcoded values
set(OpenVR_INCLUDE_DIR "C:\\Users\\banes\\source\\repos\\openvr\\headers" CACHE STRING "")
set(OpenVR_LIBRARY "C:\\Users\\banes\\source\\repos\\openvr\\lib\\win64\\openvr_api.lib" CACHE STRING "")

set(Python3_EXECUTABLE "C:\\Users\\banes\\miniconda3\\envs\\pyvista\\python.exe" CACHE STRING "")
# import sysconfig; print(sysconfig.get_config_var('LIBDEST'))
set(Python3_LIBRARIES "C:\\Users\\banes\\miniconda3\\envs\\pyvista\\Lib" CACHE STRING "")
# import sysconfig; print(sysconfig.get_path('include'))
set(Python3_INCLUDE_DIRS "C:\\Users\\banes\\miniconda3\\envs\\pyvista\\Include" CACHE STRING "")
