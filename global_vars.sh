#!/bin/bash

export gpvm=${HOSTNAME}
export suffix=".fnal.gov"
export prefix="gpvm"
export hostgpvm=${gpvm%"$suffix"}
hostgpvm=$(printf '%s\n' "${hostgpvm//[[:digit:]]/}")
hostgpvm=${hostgpvm%"$prefix"}

case "${hostgpvm}" in
    uboone) source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone_mcc9.sh ;;
    sbnd)   source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh ;;
    icarus) source /cvmfs/icarus.opensciencegrid.org/products/icarus/setup_icarus.sh ;;
    dune)   source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh ;;
    *)      source /cvmfs/larsoft.opensciencegrid.org/products/setup ;;   # generic fallback
esac
export EXPERIMENT=${EXPERIMENT:-${hostgpvm}}

LARSOFT=/cvmfs/larsoft.opensciencegrid.org/products
FLAV=Linux64bit+3.10-2.17

setup root          v6_28_12    -f ${FLAV} -z ${LARSOFT} -q e26:p3915:prof
setup lhapdf        v6_5_5                 -z ${LARSOFT} -q e26:p3915:prof   # GENIE --enable-lhapdf6
setup pdfsets       v5_9_1b                -z ${LARSOFT}
setup log4cpp       v1_1_3e     -f ${FLAV} -z ${LARSOFT} -q e26:prof
setup boost         v1_82_0                -z ${LARSOFT} -q e26:prof          # GENIE --with-boost-*
setup hepmc3        v3_3_1                 -z ${LARSOFT} -q e26:p3915:prof   # GENIE --enable-hepmc3
setup inclxx        v5_2_9_5g   -f ${FLAV} -z ${LARSOFT} -q e26:prof
setup geant4        v4_11_2_p02 -f ${FLAV} -z ${LARSOFT} -q e26:prof
setup pythia8       v8_3_15                -z ${LARSOFT} -q e26:p3915:prof
setup python        v3_9_15                -z ${LARSOFT}
setup eigen         v3_4_0                 -z ${LARSOFT}     # needed by Professor2
setup nlohmann_json v3_11_2                -z ${LARSOFT}     # needed by Reweight
setup cmake         v3_27_4                -z ${LARSOFT}