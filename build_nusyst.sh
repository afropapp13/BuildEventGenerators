#!/bin/bash                                                                                                                                                                                              
# wiki: https://twiki.cern.ch/twiki/bin/view/Main/DirtTwo#Getting_Started

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source setup_generators.sh

# Cloning the NEUT repo
git clone https://github.com/NuSystematics/nusystematics.git
cd nusystematics
git checkout tags/v02_00_01

mkdir build
cd build
cmake ../
make install

source ${BASE_DIR}/nusystematics/build/Linux/bin/setup.nusystematics.sh
