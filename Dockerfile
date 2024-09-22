ARG PYTHON_VERSION=3.12

FROM python:${PYTHON_VERSION} as builder

RUN mkdir -p /app
COPY ./cmake/ /app/cmake/
COPY ./scripts/install.sh /app/scripts/
COPY ./scripts/build.sh /app/scripts/
WORKDIR /app

# Install build dependencies
RUN ./scripts/install.sh

RUN pip install --upgrade pip
RUN pip install setuptools wheel

ARG VTK_VERSION="9.3.1"
ARG VTK_VARIANT="osmesa"
RUN VTK_VERSION=${VTK_VERSION} VTK_VARIANT=${VTK_VARIANT} ./scripts/build.sh

############################################
####                Python              ####
FROM python:${PYTHON_VERSION}-slim as slim
COPY --from=builder /app/vtk/build/dist/*.whl /opt/vtk/

# Install runtime dependencies
ARG VTK_VARIANT="osmesa"
COPY ./scripts/install_runtime.sh /opt/scripts/install_runtime.sh
RUN VTK_VARIANT=${VTK_VARIANT} /opt/scripts/install_runtime.sh

RUN pip install /opt/vtk/*.whl

# If the build variant is EGL, will need:
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Validate installation
RUN python -c "import vtk; print(vtk.VTK_VERSION)"

############################################
####             JupyterLab             ####
FROM slim AS jupyter

# Set non-root user
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
ENV PATH="/home/${NB_USER}/.local/bin:$PATH"
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${NB_USER}

# If building JupyterLab, give them PyVista because it's awesome
#  and how else would they do plotting in Jupyter?
RUN pip install jupyterlab 'pyvista[jupyter]'

# ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_TRAME_SERVER_PROXY_PREFIX='/proxy/'

COPY ./volume.ipynb ${HOME}/volume.ipynb

EXPOSE 8888
ENTRYPOINT [ "jupyter", "lab" ]
CMD ["--port=8888", "--no-browser", "--ip=0.0.0.0"]
