# Docker build and publish

For me to locally build and push docker images:

```bash
VTK_VERSION=9.2.6 docker build \
    --build-arg="VTK_VERSION=${VTK_VERSION}" \
    -t ghcr.io/banesullivan/python-vtk:3.11-${VTK_VERSION} \
    .

docker buildx build \
    --push \
    --platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
    -t ghcr.io/banesullivan/python-vtk:3.11-9.2.6 \
    .
```

FYI:

- DOCKER_DEFAULT_PLATFORM=linux/amd64
- DOCKER_DEFAULT_PLATFORM=linux/aarch64
