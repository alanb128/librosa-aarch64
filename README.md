# librosa-aarch64
A block for using Librosa on aarch64 architecture devices. (Work in progress - will be released in balenaBlocks repo soon...)

[Librosa](https://librosa.org/) is a popular audio and music processing tool for Python. It is notoriously difficult and time-consuming to build for aarch64 devices such as the Pi4, Coral Dev and Jetson boards. Simply add this block to an existing project and/or extend it for your own needs.

## Usage

Add the following to your `docker-compose`:
```yaml
version: '2.1'
services:
  librosa:
    restart: always
    image: balenablocks/librosa:latest
    privileged: true
```

Alternatively, you may want to extend the base image within your own Dockerfile:
```dockerfile
FROM balenablocks/librosa:latest

# Add your installs and/or copy your files below...
```

## Details:

Librosa version: 0.7.2

Includes dependencies: cython, cmake, tbb, llvmlite, numba, numpy, scipy, scikit-learn.

## Build

### Build with buildx

docker buildx build -t balenablocks/librosa-aarch64:latest --platform raspberrypi4-64 --file Dockerfile .

### Push to the repo
docker push balenablocks/librosa-aarch64:latest

