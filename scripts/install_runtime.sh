#!/bin/bash
# These are runtime dependencies
set -e -u -x

apt-get update

echo ${VTK_VARIANT}

if [[ "${VTK_VARIANT}" == "egl" ]]; then
    echo "Installing runtime dependencies for EGL variant"
    apt-get install --no-install-recommends --yes \
        libopengl0 \
        libgl1 \
        libegl1
elif [[ "${VTK_VARIANT}" == "osmesa" ]]; then
    echo "Installing runtime dependencies for OSMesa variant"
    apt-get install --no-install-recommends --yes \
        libosmesa6
else
    echo "Invalid VTK_VARIANT value"
    exit 1
fi

# Cleanup
rm -rf /var/lib/apt/lists/*
