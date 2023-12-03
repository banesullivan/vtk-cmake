# vtk-cmake

CMake configurations for how I like to build VTK.

## Pull Pre-built Images

I've built Docker images for a few Python and VTK versions and pushed them to the
following images in this repositories container registry:

- `ghcr.io/banesullivan/pyvista`: PyVista configured for JupyterLab (VTK OSMesa)
- `ghcr.io/banesullivan/pyvista-gpu`: PyVista configured for JupyterLab (VTK EGL for use with NVIDIA GPUs)
- `ghcr.io/banesullivan/vtk-python`: Python slim image with VTK (OSMesa) installed.

The tags for these images follow the format `{Python Version}-{VTK version}`. For example,
the image with Python version 3.11 and VTK version 9.3.0 would be: `ghcr.io/banesullivan/pyvista:3.11-9.3.0`

You can pull this image from the container registry here:

```bash
docker pull ghcr.io/banesullivan/pyvista:3.11-9.3.0
```

To run it:

```bash
docker run -it -p 8888:8888 --rm ghcr.io/banesullivan/pyvista:3.11-9.3.0
```

There is also a GPU version ready for use with NVIDIA hardware:

```bash
docker pull ghcr.io/banesullivan/pyvista-gpu:3.11-9.3.0
docker run -it -p 8888:8888 --rm --runtime=nvidia --gpus all ghcr.io/banesullivan/pyvista-gpu:3.11-9.3.0
```

## Build it yourself

I have set up a Docker build to generate a VTK wheel and install that wheel along with PyVista in
a Docker image with JupyterLab ready to go. There are two targets for the build:

- `slim`: Builds and installs VTK into a python-slim image (without PyVista)
- `jupyter`: Builds and installs VTK with Python and JupyterLab

To build the slim image

```bash
docker build --target slim -t ghcr.io/banesullivan/vtk-python .
```

Or you can specify specific versions of Python and VTK by:

```bash
# Build with Python 3.9
docker build --target slim --build-arg='PYTHON_VERSION=3.9' -t ghcr.io/banesullivan/vtk-python .

# Build VTK 9.3 with EGL (defaults to Python 3.11)
docker build --target slim --build-arg='VTK_VERSION=9.3.0' --build-arg='VTK_VARIANT=egl' -t ghcr.io/banesullivan/vtk-python .
```

After building, you can extract the wheel or use that base image for all your VTK Python needs.

The wheel is saved uner `/opt/vtk/`

To run a JupyterLab instance with EGL and access to NVIDIA GPUs:

```bash
# Build VTK 9.3 with EGL for use in Jupyter
docker build --target jupyter --build-arg='VTK_VERSION=9.3.0' --build-arg='VTK_VARIANT=egl' -t ghcr.io/banesullivan/pyvista-gpu .

# Run the image with NVIDIA runtime and GPU access
docker run -it -p 8888:8888 --rm --runtime=nvidia --gpus all ghcr.io/banesullivan/pyvista-gpu
```

PyVista/VTK with OSMesa (CPU-rendering) in JupyterLab:
```bash
docker build --target jupyter --build-arg='VTK_VERSION=9.3.0' --build-arg='VTK_VARIANT=osmesa' -t ghcr.io/banesullivan/pyvista:3.11-9.3.0 .

docker run -it -p 8888:8888 --rm --runtime=nvidia --gpus all ghcr.io/banesullivan/pyvista:3.11-9.3.0
```

PyVista/VTK with EGL (GPU-rendering) in JupyterLab:
```bash
docker build --target jupyter --build-arg='VTK_VERSION=9.3.0' --build-arg='VTK_VARIANT=egl' -t ghcr.io/banesullivan/pyvista-gpu:3.11-9.3.0 .

docker run -it -p 8888:8888 --rm --runtime=nvidia --gpus all ghcr.io/banesullivan/pyvista-gpu:3.11-9.3.0
```

## Manual Build

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

Reference `scripts/build.sh`

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
