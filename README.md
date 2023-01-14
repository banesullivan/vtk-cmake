# vtk-cmake

CMake configurations for how I like to build VTK.

1. Copy/paste the `*.cmake` files in the `cmake/` directory here to your build directory.
2. Choose a build configuration. Each configuration is a `.cmake` file without the `_` prefix.
    - For example, to build the OSMESA variant, choose the `osmesa.cmake` configuration
3. Configure the build using the chosen configuration:
    ```
    cmake -GNinja -C osmesa.cmake ..
    ```
4. Build!
    ```
    ninja
    ```


## Contributing

Feel free to add your own configurations that adopt from the base configurations `_base.cmake` and `_modules.cmake`.

### Modules
To turn on/off modules not included here, specify these in the `_modules.cmake` configuration file.

The enabled/disabled modules follow a similar specification to the default for what VTK publishes on PyPI. Reference:

- https://gitlab.kitware.com/vtk/vtk/-/blob/master/.gitlab/ci/configure_macos.cmake

This has the behaviour of "enable all, disable some".

Additionally Qt and MPI are disabled in these configurations.


## Windows Notes

Some reminders for how to build on windows:

- Use "x64 Native Tools Command Prompt" for the installed Visual Studio
version to configure with CMake and to build with ninja.


### OpenVR

- `VTK_BUILD_PYI_FILES` must be set to OFF
- Copy `openvr_api.dll` to the installed `vtkmodules` path
