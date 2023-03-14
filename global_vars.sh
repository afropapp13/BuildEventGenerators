#!/bin/bash

# MicroBooNE
source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh

# SBND
#source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh

#DUNE
#source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

setup root v6_12_06a -q e17:debug                                               
setup lhapdf v5_9_1k -q e17:debug                                               
setup log4cpp v1_1_3a -q e17:debug                                              
setup pdfsets v5_9_1b                                                           
setup gdb v8_1                                                                  
setup git v2_15_1                                                                       
setup cmake v3_14_3
