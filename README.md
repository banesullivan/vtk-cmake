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
5. Make a wheel (will then be generated in `VTK/build/dist`)
    ```
    python setup.py bdist_wheel
    ```


For example:

```
git clone https://github.com/Kitware/VTK.git
cd VTK
git checkout release
mkdir build
git clone https://github.com/banesullivan/vtk-cmake.git
cp vtk-cmake/cmake/*.cmake build/
cd build
cmake -GNinja -C osmesa.cmake ..
ninja
python setup.py bdist_wheel
```

## Contributing

Feel free to add your own configurations that adopt from the base configurations `_base.cmake` and `_modules.cmake`.

### Modules
To turn on/off modules not included here, specify these in the `_modules.cmake` configuration file.

The enabled/disabled modules follow a similar specification to the default for what VTK publishes on PyPI. Reference:

- https://gitlab.kitware.com/vtk/vtk/-/blob/master/.gitlab/ci/configure_macos.cmake

This has the behaviour of "enable all, disable some".

Additionally Qt and MPI are disabled in these configurations.


Some additions

- `Module_vtkAcceleratorsVTKm:BOOL=OFF`


## Further Resources

See [VTK's build notes](https://gitlab.kitware.com/vtk/vtk/-/blob/master/Documentation/dev/build.md#building-vtk)


## Linux Build Dependencies

I think these are all the system dependencies needed:

```
sudo apt-get update
sudo apt-get install --no-install-recommends --yes \
  build-essential \
  libosmesa6-dev \
  cmake \
  ninja-build \
  libboost-all-dev
```

And Python of course :)


## Windows Notes

Some reminders for how to build on windows:

- Use "x64 Native Tools Command Prompt" for the installed Visual Studio
version to configure with CMake and to build with ninja.
- Many of the necessary Python paths are hardcoded in the configurations (for my local machine) and need to be updated per-environment.

### OpenVR

- `VTK_BUILD_PYI_FILES` must be set to OFF
- Copy `openvr_api.dll` to the installed `vtkmodules` path
