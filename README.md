# vtk-cmake

CMake configurations for how I like to build VTK.

Since VTK 9.4, GLEW was replaced with GLAD, enabling **runtime selection** of rendering backends. A single build now includes both OSMesa and EGL support — separate wheel variants are no longer needed. At runtime, set the `VTK_DEFAULT_RENDER_WINDOW_OFFSCREEN` environment variable or use `vtk.vtkRenderWindow().SetOffScreenRendering(True)` to choose the backend.

## Pull Pre-built Images

I've built Docker images for a few Python and VTK versions and pushed them to the
following images in this repository's container registry:

- `ghcr.io/banesullivan/pyvista`: PyVista configured for JupyterLab
- `ghcr.io/banesullivan/python-vtk`: Python slim image with VTK installed

The tags for these images follow the format `{Python Version}-{VTK version}`. For example,
the image with Python version 3.12 and VTK version 9.6.0 would be: `ghcr.io/banesullivan/pyvista:3.12-9.6.0`

You can pull this image from the container registry here:

```bash
docker pull ghcr.io/banesullivan/pyvista:3.12-9.6.0
```

To run with CPU rendering (OSMesa):

```bash
docker run -it -p 8888:8888 --rm ghcr.io/banesullivan/pyvista:3.12-9.6.0
```

To run with GPU rendering (EGL) on NVIDIA hardware:

```bash
docker run -it -p 8888:8888 --rm --gpus all ghcr.io/banesullivan/pyvista:3.12-9.6.0
```

## Build it yourself

I have set up a Docker build to generate a VTK wheel and install that wheel along with PyVista in
a Docker image with JupyterLab ready to go. There are two targets for the build:

- `slim`: Builds and installs VTK into a python-slim image (without PyVista)
- `jupyter`: Builds and installs VTK with Python and JupyterLab

To build the slim image:

```bash
docker build --target slim -t ghcr.io/banesullivan/python-vtk .
```

Or you can specify specific versions of Python and VTK:

```bash
# Build with Python 3.12
docker build --target slim --build-arg='PYTHON_VERSION=3.12' -t ghcr.io/banesullivan/python-vtk .

# Build VTK 9.6.0 (defaults to Python 3.12)
docker build --target slim --build-arg='VTK_VERSION=v9.6.0' -t ghcr.io/banesullivan/python-vtk .
```

After building, you can extract the wheel or use that base image for all your VTK Python needs.

The wheel is saved under `/opt/vtk/`

PyVista/VTK in JupyterLab:

```bash
docker build --target jupyter --build-arg='VTK_VERSION=v9.6.0' -t ghcr.io/banesullivan/pyvista .

# CPU rendering (OSMesa)
docker run -it -p 8888:8888 --rm ghcr.io/banesullivan/pyvista

# GPU rendering (EGL) with NVIDIA
docker run -it -p 8888:8888 --rm --gpus all ghcr.io/banesullivan/pyvista
```

## Manual Build (Linux)

1. Copy/paste the `*.cmake` files in the `cmake/` directory here to your build directory.
2. Choose a build configuration. Each configuration is a `.cmake` file without the `_` prefix.
    - `linux.cmake`: Headless build with both OSMesa and EGL support
    - `macos.cmake`: macOS build with Cocoa
    - `windows.cmake`: Windows build
3. Configure the build using the chosen configuration:
    ```
    cmake -GNinja -C linux.cmake ..
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
git checkout v9.6.0
mkdir build
git clone https://github.com/banesullivan/vtk-cmake.git
cp vtk-cmake/cmake/*.cmake build/
cd build
cmake -GNinja -C linux.cmake ..
ninja
python setup.py bdist_wheel
```

Reference `scripts/build.sh`

## Manual Build (macOS)

```
git clone https://github.com/Kitware/VTK.git
cd VTK
git checkout v9.6.0
mkdir build
git clone https://github.com/banesullivan/vtk-cmake.git
cp vtk-cmake/cmake/*.cmake build/
cd build
cmake -GNinja -C macos.cmake ..
ninja
python setup.py bdist_wheel
```

## Contributing

Feel free to add your own configurations that adopt from the base configurations `_base.cmake` and `_modules.cmake`.

### Modules
To turn on/off modules not included here, specify these in the `_modules.cmake` configuration file.

The enabled/disabled modules follow a similar specification to the default for what VTK publishes on PyPI. Reference:

- https://gitlab.kitware.com/vtk/vtk/-/blob/master/.gitlab/ci/configure_wheel.cmake

This has the behaviour of "enable all, disable some".

Additionally Qt and MPI are disabled in these configurations.


## Further Resources

See [VTK's build notes](https://gitlab.kitware.com/vtk/vtk/-/blob/master/Documentation/dev/build.md#building-vtk)


## Linux Build Dependencies

I think these are all the system dependencies needed:

```
sudo apt-get update
sudo apt-get install --no-install-recommends --yes \
  build-essential \
  libosmesa6-dev \
  libopengl-dev \
  libglvnd-dev \
  libgl-dev \
  libglx-dev \
  libegl-dev \
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
