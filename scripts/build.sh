#!/bin/bash
set -e -u -x
echo "Cloning VTK version ${VTK_VERSION:-v9.3.1}..."
git clone https://gitlab.kitware.com/vtk/vtk.git --depth 1 --branch "${VTK_VERSION:-v9.3.1}" vtk
mkdir -p vtk/build
cp cmake/*.cmake vtk/build/

cd vtk
git submodule update --init --recursive

cd build
cmake -GNinja -C ${VTK_VARIANT:-osmesa}.cmake ..
ninja
python setup.py bdist_wheel
