#!/bin/bash                                                                                                                                                                                                       

source global_vars.sh

#THIS_DIRECTORY=$(pwd)

#source /grid/fermiapp/products/larsoft/setups

#setup root v6_12_06a -q e17:debug
#setup lhapdf v5_9_1k -q e17:debug
#setup log4cpp v1_1_3a -q e17:debug
#setup pdfsets v5_9_1b
#setup gdb v8_1
#setup git v2_15_1
#setup cmake v3_11_4

./build_genie.sh
./build_gibuu.sh
./build_neut.sh
./build_nuwro.sh
./build_marley.sh

./build_nuisance.sh
