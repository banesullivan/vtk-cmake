# Docker build and publish

For me to locally build and push docker images:

```bash
VTK_VERSION=9.2.6 docker build \
    --build-arg="VTK_VERSION=${VTK_VERSION}" \
    -t ghcr.io/banesullivan/python-vtk:3.11-${VTK_VERSION} \
    .
```

FYI:

- DOCKER_DEFAULT_PLATFORM=linux/amd64
- DOCKER_DEFAULT_PLATFORM=linux/aarch64
