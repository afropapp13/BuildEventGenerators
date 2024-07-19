#!/bin/bash

source global_vars.sh

git clone https://github.com/NuWro/nuwro.git nuwro
cd nuwro
git checkout tags/nuwro_21.09.2
export PATH=$PATH:$ROOTSYS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTSYS/lib
export PYTHIA6=${PYTHIA_FQ_DIR}/lib
export LIBRARY_PATH=${LIBRARY_PATH}:${PYTHIA6}
make
