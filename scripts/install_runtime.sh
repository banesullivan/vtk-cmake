#!/bin/bash
# These are runtime dependencies for the unified build (both OSMesa and EGL)
set -e -u -x

apt-get update

apt-get install --no-install-recommends --yes \
    libosmesa6 \
    libopengl0 \
    libgl1 \
    libegl1

# Cleanup
rm -rf /var/lib/apt/lists/*
