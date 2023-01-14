set(Python3_EXECUTABLE "C:\\Users\\banes\\miniconda3\\envs\\pyvista\\python.exe" CACHE STRING "")
# import sysconfig; print(sysconfig.get_config_var('LIBDEST'))
set(Python3_LIBRARIES "C:\\Users\\banes\\miniconda3\\envs\\pyvista\\Lib" CACHE STRING "")
# import sysconfig; print(sysconfig.get_path('include'))
set(Python3_INCLUDE_DIRS "C:\\Users\\banes\\miniconda3\\envs\\pyvista\\Include" CACHE STRING "")

set(VTK_MODULE_ENABLE_VTK_GUISupportMFC NO CACHE STRING "")

# Ref https://gitlab.kitware.com/vtk/vtk/-/blob/master/.gitlab/ci/configure_windows.cmake
set(VTK_MODULE_ENABLE_VTK_RenderingExternal NO CACHE STRING "") # glut
# Windows-only features
set(VTK_USE_MICROSOFT_MEDIA_FOUNDATION ON CACHE BOOL "")
set(VTK_USE_VIDEO_FOR_WINDOWS ON CACHE BOOL "")
set(VTK_USE_VIDEO_FOR_WINDOWS_CAPTURE ON CACHE BOOL "")
set(VTK_DISABLE_QT_MULTICONFIG_WINDOWS_WARNING ON CACHE BOOL "")
