#!/bin/bash                                                                                                                                

export TERM=screen
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh

git clone https://github.com/AchillesGen/Achilles achilles
cd achilles
git checkout dev
#git checkout 89-bug-cross-section

mkdir build
cd build
cmake .. -DUSE_ROOT=ON
make -j4

export LD_LIBRARY_PATH=/cvmfs/larsoft.opensciencegrid.org/products/gcc/v12_1_0/Linux64bit+3.10-2.17/lib64/:$LD_LIBRARY_PATH

cd $BASE_DIR

