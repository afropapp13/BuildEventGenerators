#!/bin/bash

source global_vars.sh

## Set up NEUT
export NEUTROOT=${THIS_DIRECTORY}/neut
source ${NEUTROOT}/neutbuild/cernlib/setup_cernlib.sh
source ${NEUTROOT}/build/Linux/setup.sh
export LD_LIBRARY_PATH=$NEUTROOT/src/reweight:$LD_LIBRARY_PATH

## Set up GENIE
export GENIE=${THIS_DIRECTORY}/Generator
export PYTHIA6=${PYTHIA_FQ_DIR}/lib
export LHAPDF5_INC=${LHAPDF_INC}
export LHAPDF5_LIB=${LHAPDF_LIB}
export GENIE_REWEIGHT=${THIS_DIRECTORY}/Reweight
export PATH=${GENIE}/bin:${GENIE_REWEIGHT}/bin:$PATH
export LD_LIBRARY_PATH=${GENIE}/lib:${GENIE_REWEIGHT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${LIBRARY_PATH}:${GENIE_REWEIGHT}/lib

## Set up GiBUU (run via the "gibuu" symbolic link to GiBUU.x)
export PATH=${PATH}:${THIS_DIRECTORY}/GiBUU2021

## Set up NuWro
#export PYTHIA6=$PYTHIA6_LIBRARY
export NUWRO=${THIS_DIRECTORY}/nuwro
#export LD_LIBRARY_PATH=${THIS_DIRECTORY}/pythia6:$NUWRO/lib:$NUWRO/bin:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${PYTHIA6}:$NUWRO/bin:$LD_LIBRARY_PATH
export PATH=$NUWRO/bin:$PATH

# Clone and build Nuisance
#git clone https://github.com/NUISANCEMC/nuisance.git
git clone https://github.com/afropapp13/nuisance.git
cd nuisance
mkdir build && cd build
cmake -DUSE_GENIE=1 -DUSE_NuWro=1 -DUSE_NEUT=1 -DUSE_GiBUU=1  -DLIBXML2_LIB=$(xml2-config --prefix)/lib -DNEUT_ROOT=${NEUTROOT}  ../
make
make install

sed -i 's/add_to_LD_LIBRARY_PATH "\/uboone\/app\/users\/apapadop\/BuildEventGenerators\/nuwro\/build\/Linux\/lib"/ /g' Linux/setup.sh
