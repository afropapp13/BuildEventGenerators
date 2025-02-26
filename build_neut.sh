#!/bin/bash                                                                                                                                                                                              

#Using a container until neut 6 becomes public
#https://docs.google.com/document/d/1NIrI9BW4Vxw-zYUvec-hsDPSAluAqLuumdj27TG5cic/edit?usp=sharing

git clone https://github.com/NUISANCEMC/tutorials.git neut_container
cd neut_container/interactive
singularity pull nuisance_nuint2024.sif docker://nuisancemc/tutorial:nuint2024
wget https://github.com/afropapp13/BuildEventGenerators/raw/master/jobcards/sbnd_flux.root
wget https://raw.githubusercontent.com/afropapp13/BuildEventGenerators/refs/heads/master/jobcards/neut_argon.card
wget https://raw.githubusercontent.com/afropapp13/BuildEventGenerators/refs/heads/master/jobcards/run_neut.sh
wget https://raw.githubusercontent.com/afropapp13/BuildEventGenerators/refs/heads/master/jobcards/run_neut_container.sh

#BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
#source ${BASE_DIR}/global_vars.sh         

## Cloning the NEUT repo
#git clone https://github.com/neut-devel/neut.git
#cd neut
#git checkout tags/neut_5.6.0_RC1

## Building all the NEUT dependencies
#git clone https://github.com/luketpickering/neutbuild.git
#cd neutbuild
#./build_neut.sh ../

## Exporting all the paths
#export CERNLIB=${BASE_DIR}/neut/neutbuild/cernlib/cernlib_build
#export CERN=${CERNLIB}
#export CERN_LEVEL=2005

## Building NEUT
#cd ..
#mkdir build; cd build;
#../src/configure --prefix=$(readlink -f Linux)
#make -j 4
#make install
#source $(pwd)/Linux/setup.sh
