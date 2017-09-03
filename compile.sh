#! /bin/bash
if [ ! -d build ]; then
    mkdir -p build
fi

cd build

cmake .. -DEIGEN3_INCLUDE_DIR=eigen

make 

cd ..

