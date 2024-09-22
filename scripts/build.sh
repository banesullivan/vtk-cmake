#!/bin/bash
set -e -u -x
git clone https://gitlab.kitware.com/vtk/vtk.git --depth 1 --branch "v${VTK_VERSION:-9.3.1}" vtk
mkdir -p vtk/build
cp cmake/*.cmake vtk/build/

cd vtk
git submodule update --init --recursive

cd build
cmake -GNinja -C ${VTK_VARIANT:-osmesa}.cmake ..
ninja
python setup.py bdist_wheel
