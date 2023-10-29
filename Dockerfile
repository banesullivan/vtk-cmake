FROM python:3.11 as builder

RUN mkdir -p /app
COPY ./cmake/ /app/cmake/
COPY ./scripts/ /app/scripts/
WORKDIR /app

RUN ./scripts/install.sh

ARG VTK_VERSION=9.2.6
ARG VTK_VARIANT="osmesa"
RUN VTK_VERSION=${VTK_VERSION} VTK_VARIANT=${VTK_VARIANT} ./scripts/build.sh

############################################
ARG PYTHON_VERSION=3.11
FROM python:3.11-slim
RUN mkdir -p opt/vtk/
COPY --from=builder /app/vtk/build/dist/*.whl /opt/vtk/

RUN apt update && apt install -y libosmesa6 && rm -rf /var/lib/apt/lists/*

RUN pip install /opt/vtk/*.whl

# Validate installation
RUN python -c "import vtk; print(vtk.VTK_VERSION)"
