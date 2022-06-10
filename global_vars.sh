#!/bin/bash

THIS_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh

setup root v6_12_06a -q e17:debug                                               
setup lhapdf v5_9_1k -q e17:debug                                               
setup log4cpp v1_1_3a -q e17:debug                                              
setup pdfsets v5_9_1b                                                           
setup gdb v8_1                                                                  
setup git v2_15_1                                                                       
setup cmake v3_14_3
