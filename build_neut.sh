#!/bin/bash                                                                                                                                                                                                       
source global_vars.sh

# Cloning the NEUT repo
#git clone https://github.com/neut-devel/neut.git
git clone https://github.com/afropapp13/neut.git
cd neut
git checkout tags/neut_5.6.0_RC1

# Building all the NEUT dependencies
git clone https://github.com/afropapp13/neutbuild.git
cd neutbuild
./build_neut.sh ../

# Exporting all the paths
export CERNLIB=${THIS_DIRECTORY}/neut/neutbuild/cernlib/cernlib_build
export CERN=${CERNLIB}
export CERN_LEVEL=2005

# Building NEUT
cd ..
mkdir build; cd build;
../src/configure --prefix=$(readlink -f Linux)
make -j 8
make install
source $(pwd)/Linux/setup.sh
