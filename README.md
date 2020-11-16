# librosa-aarch64
A base image for using Librosa on aarch64 architecture devices. (Work in progress - will be released in balenaBlocks repo soon...)

[Librosa](https://librosa.org/) is a popular audio and music processing tool for Python. It is notoriously difficult and time-consuming to build for aarch64 devices such as the Pi4, Coral Dev and Jetson boards. Simply add this image to an existing project and/or extend it for your own needs.

## Usage

Add the following to your `docker-compose`:
```yaml
version: '2.1'
services:
  librosa:
    restart: always
    image: balenablocks/librosa-aarch64:raspberrypi4-64
    privileged: true
```

Alternatively, you may want to extend the base image within your own Dockerfile:
```dockerfile
FROM balenablocks/librosa-aarch64:latest

# Add your installs and/or copy your files below...
```

## Details:

Librosa version: 0.7.2

Includes dependencies: cython, cmake, tbb, llvmlite, numba, numpy, scipy, scikit-learn.

