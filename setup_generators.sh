#!/bin/bash

source global_vars.sh

# NEUT
export NEUTROOT=${THIS_DIRECTORY}/neut
source ${NEUTROOT}/neutbuild/cernlib/setup_cernlib.sh
#source ${NEUTROOT}/bin/thisneut.sh
source ${NEUTROOT}/build/Linux/setup.sh
export LD_LIBRARY_PATH=$NEUTROOT/src/reweight:$LD_LIBRARY_PATH

# GENIE
export GENIE=${THIS_DIRECTORY}/Generator
export PYTHIA6=${PYTHIA_FQ_DIR}/lib
export LHAPDF5_INC=${LHAPDF_INC}
export LHAPDF5_LIB=${LHAPDF_LIB}
export GENIE_REWEIGHT=${THIS_DIRECTORY}/Reweight
export PATH=${GENIE}/bin:${GENIE_REWEIGHT}/bin:$PATH
export LD_LIBRARY_PATH=${GENIE}/lib:${GENIE_REWEIGHT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${LIBRARY_PATH}:${GENIE_REWEIGHT}/lib

# Set up GiBUU (run via the "gibuu" symbolic link to GiBUU.x)
export PATH=${PATH}:${THIS_DIRECTORY}/GiBUU2021

# NuWro
export PYTHIA6=$PYTHIA6_LIBRARY
export NUWRO=${THIS_DIRECTORY}/nuwro
export LD_LIBRARY_PATH=${THIS_DIRECTORY}/pythia6:$NUWRO/lib:$NUWRO/bin:$LD_LIBRARY_PATH
export PATH=$NUWRO/bin:$PATH

# MARLEY
export MARLEYROOT=${THIS_DIRECTORY}/marley
# Avoid name collision caused by MARLEY setup script
OLD_THIS_DIRECTORY=${THIS_DIRECTORY}
source ${MARLEYROOT}/setup_marley.sh

# NUISANCE
source ${OLD_THIS_DIRECTORY}/nuisance/build/Linux/setup.sh
