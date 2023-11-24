# Steps

Build an EGL variant of VTK

Install nvidia's docker container-toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

```bash
docker build -t pyvista-gpu .

docker run -it -p 8888:8888 -v .:/home/jovyan/data --rm --runtime=nvidia --gpus all pyvista-gpu
```

Reference: https://medium.com/@benjamin.botto/opengl-and-cuda-applications-in-docker-af0eece000f1

Setting `NVIDIA_DRIVER_CAPABILITIES` seems to be the key
