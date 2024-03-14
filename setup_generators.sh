#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh

# NEUT
export NEUTROOT=/exp/uboone/app/users/apapadop/BuildEventGenerators/neut
source ${NEUTROOT}/neutbuild/cernlib/setup_cernlib.sh
export LD_LIBRARY_PATH=${NEUTROOT}/src/reweight:${LD_LIBRARY_PATH}
source ${NEUTROOT}/build/Linux/setup.sh
#echo "NEUT setup is ready!"

# GENIE
export GENIE_FQ_DIR=${BASE_DIR}
export GENIE=${BASE_DIR}/Generator
export GENIE_LIB=${BASE_DIR}/Generator/lib
export PYTHIA6=${PYTHIA_FQ_DIR}/lib
export LHAPDF5_INC=${LHAPDF_INC}
export LHAPDF5_LIB=${LHAPDF_LIB}
export GENIE_REWEIGHT=${BASE_DIR}/Reweight
export PATH=${GENIE}/bin:${GENIE_REWEIGHT}/bin:$PATH
export LD_LIBRARY_PATH=${GENIE}/lib:${GENIE_REWEIGHT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${LIBRARY_PATH}:${GENIE_REWEIGHT}/lib
#echo "GENIE setup is ready!"

# Set up GiBUU (run via the "gibuu" symbolic link to GiBUU.x)
# GiBUU 2023
export PATH=${PATH}:${BASE_DIR}/GiBUU/release/testRun

# NuWro
export PYTHIA6=$PYTHIA6_LIBRARY
export NUWRO=${BASE_DIR}/nuwro
export LD_LIBRARY_PATH=${BASE_DIR}/pythia6:$NUWRO/lib:$NUWRO/bin:$LD_LIBRARY_PATH
export PATH=$NUWRO/bin:$PATH
#echo "NuWro setup is ready!"

# MARLEY
#export MARLEYROOT=${BASE_DIR}/marley
#source ${MARLEYROOT}/setup_marley.sh
#echo "MARLEY setup is ready!"

#NuSystematics
source ${BASE_DIR}/nusystematics/build/Linux/bin/setup.nusystematics.sh

# NUISANCE
source ${BASE_DIR}/nuisance/build/Linux/setup.sh
#echo "NUISANCE setup is ready!"
