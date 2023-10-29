#!/bin/bash
set -e -u -x

apt-get update
apt-get install --no-install-recommends --yes \
  build-essential \
  libosmesa6-dev \
  cmake \
  ninja-build \
  libboost-all-dev
