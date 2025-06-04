#!/bin/bash                                                                                                                                

export TERM=screen
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh

mkdir HepMC3
cd HepMC3
  wget http://hepmc.web.cern.ch/hepmc/releases/HepMC3-3.3.1.tar.gz
  tar -xzf HepMC3-3.3.1.tar.gz
  mkdir hepmc3-build
  cd hepmc3-build
  cmake -DCMAKE_INSTALL_PREFIX=../hepmc3-install   \
        -DHEPMC3_ENABLE_ROOTIO:BOOL=OFF            \
        -DHEPMC3_ENABLE_PROTOBUFIO:BOOL=OFF        \
        -DHEPMC3_ENABLE_TEST:BOOL=OFF              \
        -DHEPMC3_INSTALL_INTERFACES:BOOL=ON        \
        -DHEPMC3_BUILD_STATIC_LIBS:BOOL=OFF        \
        -DHEPMC3_BUILD_DOCS:BOOL=OFF     \
        -DHEPMC3_ENABLE_PYTHON:BOOL=ON   \
        -DHEPMC3_PYTHON_VERSIONS=3.9     \
        -DHEPMC3_Python_SITEARCH39=../hepmc3-install/lib/python3.9/site-packages \
        ../HepMC3-3.3.1


# git clone https://github.com/NuHepMC/HepMC3.git HepMC3
# cd HepMC3
# mkdir hepmc3-build
# cd hepmc3-build
# cmake -DCMAKE_INSTALL_PREFIX=../hepmc3-install   \
#        -DHEPMC3_ENABLE_ROOTIO:BOOL=OFF            \
#        -DHEPMC3_ENABLE_PROTOBUFIO:BOOL=OFF        \
#        -DHEPMC3_ENABLE_TEST:BOOL=OFF              \
#         -DHEPMC3_INSTALL_INTERFACES:BOOL=ON        \
#         -DHEPMC3_BUILD_STATIC_LIBS:BOOL=OFF        \
#         -DHEPMC3_BUILD_DOCS:BOOL=OFF     \
#         -DHEPMC3_ENABLE_PYTHON:BOOL=OFF   \
#         -DHEPMC3_PYTHON_VERSIONS=3.9     \
#         -DHEPMC3_Python_SITEARCH39=../hepmc3-install/lib/python3.9/site-packages \
#         ..

make
make install
cd $BASE_DIR