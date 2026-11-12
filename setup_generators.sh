#!/bin/bash

export TERM=screen
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh

# Stop early if UPS isn't available (e.g. not on an experiment gpvm)
type setup &>/dev/null || { echo "UPS not available on ${HOSTNAME}; aborting setup"; return 1 2>/dev/null || exit 1; }

## Pythia6 (local build, shared by GENIE and NuWro)
export PYTHIA6=${PYTHIA6_LIBRARY:-${BASE_DIR}/pythia6}
export LD_LIBRARY_PATH=${PYTHIA6}:${LD_LIBRARY_PATH}

## NEUT
export NEUTROOT=${BASE_DIR}/neut
source ${NEUTROOT}/build/Linux/bin/setup.NEUT.sh

# GENIE
export GENIE_FQ_DIR=${BASE_DIR}
export GENIE=${BASE_DIR}/Generator
export GENIE_LIB=${BASE_DIR}/Generator/lib
# LHAPDF: only populated if 'setup lhapdf' is enabled in global_vars.sh
if [ -n "${LHAPDF_INC}" ]; then
    export LHAPDF5_INC=${LHAPDF_INC}
    export LHAPDF5_LIB=${LHAPDF_LIB}
fi
export GENIE_REWEIGHT=${BASE_DIR}/Reweight
export PATH=${GENIE}/bin:${GENIE_REWEIGHT}/bin:$PATH
export LD_LIBRARY_PATH=${GENIE}/lib:${GENIE_REWEIGHT}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${LIBRARY_PATH}:${GENIE_REWEIGHT}/lib
export GENIE_COMPARISONS=${BASE_DIR}/Comparisons

# Headers for Professor2 (eigen) and Reweight (nlohmann_json)
export C_INCLUDE_PATH=${EIGEN_INC}:${NLOHMANN_JSON_INC}:${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH=${EIGEN_INC}:${NLOHMANN_JSON_INC}:${CPLUS_INCLUDE_PATH}

# Professor
export PROF_ROOT=${GENIE}/src/ExternalLibs/professor
export PYTHONPATH=${GENIE}/lib/python3.9/site-packages:${PYTHONPATH}

# Set up GiBUU (run via the "gibuu" symbolic link to GiBUU.x)
export PATH=${PATH}:${BASE_DIR}/GiBUU/release/testRun

# NuWro
export NUWRO=${BASE_DIR}/nuwro
export LD_LIBRARY_PATH=$NUWRO/lib:$LD_LIBRARY_PATH
export PATH=$NUWRO/bin:$PATH

# NuSystematics
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

# Token: fall back to the experiment parsed from the hostname in global_vars.sh
export EXPERIMENT=${EXPERIMENT:-${hostgpvm}}
export HTTOKEN_ROLE="${EXPERIMENT,,}"
if [ -n "${HTTOKEN_ROLE}" ]; then
    htgettoken -a htvaultprod.fnal.gov -i "${HTTOKEN_ROLE}" || echo "htgettoken failed for role '${HTTOKEN_ROLE}'"
else
    echo "EXPERIMENT not set; skipping htgettoken"
fi