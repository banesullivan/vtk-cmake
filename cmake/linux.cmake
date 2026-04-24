include("${CMAKE_CURRENT_LIST_DIR}/_base.cmake")

# Unified headless build with both OSMesa and EGL support.
# Runtime backend selection is available since VTK 9.4+ (GLAD replaced GLEW).
set(VTK_DEFAULT_RENDER_WINDOW_HEADLESS True CACHE BOOL "")
set(VTK_OPENGL_HAS_EGL True CACHE BOOL "")
set(VTK_OPENGL_HAS_OSMESA True CACHE BOOL "")
set(VTK_USE_COCOA False CACHE BOOL "")
set(VTK_USE_X False CACHE BOOL "")

set(VTK_DIST_NAME_SUFFIX "" CACHE STRING "")
