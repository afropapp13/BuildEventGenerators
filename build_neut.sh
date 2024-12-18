#!/bin/bash                                                                                                                                                                                              

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh         

# Cloning the NEUT repo
git clone https://github.com/neut-devel/neut.git
cd neut
git checkout tags/neut_5.6.0_RC1

# Building all the NEUT dependencies
git clone https://github.com/luketpickering/neutbuild.git
cd neutbuild
./build_neut.sh ../

# Exporting all the paths
export CERNLIB=${BASE_DIR}/neut/neutbuild/cernlib/cernlib_build
export CERN=${CERNLIB}
export CERN_LEVEL=2005

# Building NEUT
cd ..
mkdir build; cd build;
../src/configure --prefix=$(readlink -f Linux)
make -j 4
make install
source $(pwd)/Linux/setup.sh
