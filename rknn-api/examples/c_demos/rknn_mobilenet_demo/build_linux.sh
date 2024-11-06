#!/bin/bash

set -e

RK3399PRO_TOOL_CHAIN=~/workspace/tools/cross_compiler/arm/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu/

# for RK3399Pro aarch64
GCC_COMPILER=${RK3399PRO_TOOL_CHAIN}/bin/aarch64-linux-gnu

ROOT_PWD=$( cd "$( dirname $0 )" && cd -P "$( dirname "$SOURCE" )" && pwd )

BUILD_DIR=${ROOT_PWD}/build

if [[ ! -d "${BUILD_DIR}" ]]; then
  mkdir -p ${BUILD_DIR}
fi

cd ${BUILD_DIR}
cmake .. \
    -DCMAKE_SYSTEM_NAME="Linux" \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_C_FLAGS="-g3 -O0" \
    -DCMAKE_CXX_FLAGS="-g3 -O0"
  
make -j4
make install
cd -

cp run_demo.sh install/rknn_mobilenet_demo_Linux/
