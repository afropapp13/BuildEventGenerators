#!/bin/bash

export gpvm=${HOSTNAME}
export suffix=".fnal.gov"
export prefix="gpvm"
export hostgpvm=${gpvm%"$suffix"}
hostgpvm=$(printf '%s\n' "${hostgpvm//[[:digit:]]/}")
hostgpvm=${hostgpvm%"$prefix"}

# MicroBooNE
if [[ "${hostgpvm}" == "uboone" ]] 
then 
	source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone_mcc9.sh
fi

# SBND
if [[ "${hostgpvm}" == "sbnd" ]] 
then 
	source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh
fi

# ICARUS
if [[ "${hostgpvm}" == "icarus" ]] 
then 
	source /cvmfs/icarus.opensciencegrid.org/products/icarus/setup_icarus.sh
fi

#DUNE
if [[ "${hostgpvm}" == "dune" ]] 
then 
	source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
fi

setup root v6_28_12 -q e26:p3915:prof                      
setup lhapdf v6_5_4 -q e26:p3915:prof                                           
setup log4cpp v1_1_3e -q e26:prof                                            
setup pdfsets v5_9_1b                                                           
setup gdb v13_1 
setup git v2_45_1                                                                       
setup cmake v3_27_4
setup boost v1_82_0 -q e26:prof
setup tbb v2021_9_0 -q e26
setup sqlite v3_40_01_00
setup pythia v6_4_28x -q e26:prof
setup hepmc3 v3_3_1 -q e26:p3915:prof
setup geant4 v4_11_2_p02 -q e26:prof
setup inclxx v5_2_9_5f -q e26:prof
setup hdf5 v1_12_2b -q e26:prof
setup spdlog v1_9_2 -q e26:prof