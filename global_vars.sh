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
	source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh
fi

# SBND
if [[ "${hostgpvm}" == "sbnd" ]] 
then 
	source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh
fi

#DUNE
if [[ "${hostgpvm}" == "dune" ]] 
then 
	source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
fi


setup root v6_22_08d -q e20:p392:prof                                               
setup lhapdf v6_3_0 -q e20:p392:prof                                           
setup log4cpp v1_1_3c -q e20:prof                                            
setup pdfsets v5_9_1b                                                           
setup gdb v8_1                                                                  
setup git v2_40_1                                                                       
setup cmake v3_27_4
setup boost v1_80_0 -q e20:prof
setup tbb v2021_7_0 -q e20
setup sqlite v3_39_02_00
setup pythia v6_4_28r -q gcc930:prof
setup hepmc3 v3_2_7 -q e26:p3915:prof
