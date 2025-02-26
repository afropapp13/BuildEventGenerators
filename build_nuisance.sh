#!/bin/bash

source setup_generators.sh

# Clone and build Nuisance
git clone https://github.com/NUISANCEMC/nuisance.git
cd nuisance
#git checkout v2r8
mkdir build
cd build
cmake -DGENIE_ENABLED=ON -DNuWro_ENABLED=ON -DNEUT_ENABLED=OFF -DGiBUU_ENABLED=ON -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_BUILD_TYPE=Debug -DProb3plusplus_ENABLED=ON -Dnusystematics_ENABLED=ON -DNuHepMC_ENABLED=ON  ../
make
make install
