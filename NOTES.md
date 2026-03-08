# Docker build and publish

For me to locally build and push docker images:

```bash
docker build \
    --build-arg="VTK_VERSION=v9.6.0" \
    --target slim \
    -t ghcr.io/banesullivan/python-vtk:3.12-9.6.0 \
    .

docker build \
    --build-arg="VTK_VERSION=v9.6.0" \
    --target jupyter \
    -t ghcr.io/banesullivan/pyvista:3.12-9.6.0 \
    .
```

Multi-architecture build/push

```bash
docker buildx create \
    --name container-builder \
    --driver docker-container \
    --use --bootstrap


docker buildx build \
    --push \
    --platform linux/arm64/v8,linux/amd64 \
    --target builder \
    --build-arg="VTK_VERSION=v9.6.0" \
    -t ghcr.io/banesullivan/vtk-builder:3.12-9.6.0 \
    .

docker buildx build \
    --push \
    --platform linux/arm64/v8,linux/amd64 \
    --target slim \
    --build-arg="VTK_VERSION=v9.6.0" \
    -t ghcr.io/banesullivan/python-vtk:3.12-9.6.0 \
    .

docker buildx build \
    --push \
    --platform linux/arm64/v8,linux/amd64 \
    --target jupyter \
    --build-arg="VTK_VERSION=v9.6.0" \
    -t ghcr.io/banesullivan/pyvista:3.12-9.6.0 \
    .
```

FYI:

- DOCKER_DEFAULT_PLATFORM=linux/amd64
- DOCKER_DEFAULT_PLATFORM=linux/aarch64
