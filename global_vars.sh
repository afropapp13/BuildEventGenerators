#!/bin/bash

# MicroBooNE
source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh

# SBND
#source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh

#DUNE
#source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

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
