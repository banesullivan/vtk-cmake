#!/bin/bash
# These are general build dependencies
set -e -u -x

apt-get update
apt-get install --no-install-recommends --yes \
  build-essential \
  cmake \
  ninja-build \
  libboost-all-dev

# OSMesa and EGL build dependencies (both needed for unified build)
apt-get install --no-install-recommends --yes \
  libosmesa6-dev \
  libopengl-dev \
  libglvnd-dev \
  libgl-dev \
  libglx-dev \
  libegl-dev
