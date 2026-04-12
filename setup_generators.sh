#!/bin/bash

export TERM=screen
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh

## NEUT
export NEUTROOT=${BASE_DIR}/neut
source ${NEUTROOT}/build/Linux/bin/setup.NEUT.sh 

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

# Set up GiBUU (run via the "gibuu" symbolic link to GiBUU.x)
export PATH=${PATH}:${BASE_DIR}/GiBUU/release/testRun

# NuWro
export PYTHIA6=$PYTHIA6_LIBRARY
export NUWRO=${BASE_DIR}/nuwro
export LD_LIBRARY_PATH=${BASE_DIR}/pythia6:$NUWRO/lib:$NUWRO/bin:$LD_LIBRARY_PATH
export PATH=$NUWRO/bin:$PATH

#NuSystematics
if [ -f "${BASE_DIR}/nusystematics/build/Linux/bin/setup.nusystematics.sh" ]; then
    echo "Sourcing NuSystematics setup..."
    source "${BASE_DIR}/nusystematics/build/Linux/bin/setup.nusystematics.sh"
else
    echo "NuSystematics setup not found (skipping)"
fi

# NUISANCE
if [ -f "${BASE_DIR}/nuisance/build/Linux/setup.sh" ]; then
    echo "Sourcing NUISANCE setup..."
    source "${BASE_DIR}/nuisance/build/Linux/setup.sh"
else
    echo "NUISANCE setup not found (skipping)"
fi

export HTTOKEN_ROLE="${EXPERIMENT,,}"
htgettoken -a htvaultprod.fnal.gov -i "${HTTOKEN_ROLE}" || true
