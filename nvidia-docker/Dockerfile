FROM jupyter/base-notebook:python-3.11
LABEL maintainer="PyVista Developers"
LABEL repo="https://github.com/pyvista/pyvista"

USER root
RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends \
        libopengl0 \
        libglvnd0 \
        libgl1 \
        libglx0 \
        libegl1 \
    && rm -rf /var/lib/apt/lists/*
USER jovyan

COPY vtk-9.2.6.post0+egl-cp311-cp311-linux_x86_64.whl /build-context/
WORKDIR /build-context/

RUN pip install --no-cache-dir vtk*.whl
RUN pip install 'pyvista[jupyter]'
# https://github.com/Kitware/trame-vtk/issues/55
RUN pip install 'aiohttp<3.9'

WORKDIR $HOME

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_TRAME_SERVER_PROXY_PREFIX='/proxy/'

COPY *.ipynb $HOME/
