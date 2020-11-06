FROM balenalib/aarch64-ubuntu-python:3.7.7-bionic-build

# Ensure package install won't block for user input during build
ENV DEBIAN_FRONTEND=noninteractive


WORKDIR /usr/src/app

# ___ FOR LIBROSA ___
# Modified from https://gist.github.com/Namburger/82e86f2d3514288aa46c9183fc53c809

# Install some librosa dependencies:
RUN \
    apt-get update && apt-get install -y libssl-dev
    
RUN \
    apt install -y python3-dev git libatlas-base-dev

RUN \
    python3 -m pip install Cython https://dl.google.com/coral/python/tflite_runtime-2.1.0.post1-cp37-cp37m-linux_aarch64.whl

RUN \
    sudo apt-get install -y libblas3 liblapack3 liblapack-dev libblas-dev \
    liblapack-dev liblapacke-dev gfortran libsndfile1-dev

# Install cmake:
RUN \
    wget https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0.tar.gz && \
    tar xvf cmake-3.17.0.tar.gz && \
    rm cmake-3.17.0.tar.gz && \
    cd cmake-3.17.0 && \
    ./configure && \
    make && \
    make install

# Build & install TBB:
RUN \
    apt install -y libffi-dev && \
    git clone https://github.com/wjakob/tbb.git && \
    cd tbb && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Build & install llvmlite
ENV LLVM_CONFIG=/usr/lib/llvm-8/bin/llvm-config

RUN \
    apt install -y libllvm8:arm64 llvm llvm-8 llvm-8-dev llvm-8-runtime llvm-runtime python3-llvmlite && \
    git clone -b v0.32.1 https://github.com/numba/llvmlite.git && \
    cd llvmlite && \
    python3 setup.py build

ENV LAPACK=/usr/lib/aarch64-linux-gnu/lapack/liblapack.so
ENV BLAS=/usr/lib/aarch64-linux-gnu/blas/libblas.so

RUN \
    python3 -m pip install scikit-learn numba==0.48.0

# Finally build and install librosa:
RUN \
    wget https://github.com/librosa/librosa/archive/0.7.2.tar.gz && \
    tar -xvf 0.7.2.tar.gz librosa-0.7.2 && \
    cd librosa-0.7.2 && \
    python3 setup.py install

# ___ END FOR LIBROSA ___


# Get some audio recording tools
RUN \
    apt-get install -y python3-pyaudio


CMD ["sleep","infinity"]
