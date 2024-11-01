#!/bin/bash                                                                                                                                

export gpvm=${HOSTNAME}
export suffix=".fnal.gov"
export prefix="gpvm"
export hostgpvm=${gpvm%"$suffix"}
hostgpvm=$(printf '%s\n' "${hostgpvm//[[:digit:]]/}")

hostgpvm=${hostgpvm%"$prefix"}

export TERM=screen
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"

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

unsetup root
setup root v6_22_08b -q e20:p383b:prof
#setup lhapdf v5_9_1k -q e17:debug
#setup log4cpp v1_1_3a -q e17:debug
#setup pdfsets v5_9_1b
#setup gdb v8_1
#unsetup git
#setup git v2_15_1
#unsetup cmake
#setup cmake v3_14_3
setup hdf5 v1_12_0b -q e20:prof 
setup tbb v2021_7_0 -q e20

cd ../achilles/build

export LD_LIBRARY_PATH=/cvmfs/larsoft.opensciencegrid.org/products/gcc/v9_3_0/Linux64bit+3.10-2.17/lib64/:$LD_LIBRARY_PATH

./bin/achilles ../../jobcards/run_uboone.yml

cd -
mv ../achilles/build/achilles.hepmc ./
# this line is nort working / complaining about missing libtbb libraries
#nuisflat -i NuHepMC:achilles.hepmc -o achilles.flat.root  
