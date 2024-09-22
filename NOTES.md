# Docker build and publish

For me to locally build and push docker images:

```bash
docker build \
    --build-arg="VTK_VERSION=9.3.1" \
    --target slim \
    -t ghcr.io/banesullivan/python-vtk:3.12-9.3.1 \
    .

docker build \
    --build-arg="VTK_VERSION=9.3.1" \
    --target jupyter \
    -t ghcr.io/banesullivan/pyvista:3.12-9.3.1 \
    .

docker buildx build \
    --push \
    --platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
    --target slim \
    --build-arg="VTK_VERSION=9.3.1" \
    -t ghcr.io/banesullivan/python-vtk:3.12-9.3.1 \
    .
```

FYI:

- DOCKER_DEFAULT_PLATFORM=linux/amd64
- DOCKER_DEFAULT_PLATFORM=linux/aarch64
