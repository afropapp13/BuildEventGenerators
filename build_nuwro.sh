#!/bin/bash

#source /grid/fermiapp/products/larsoft/setups

#setup root v6_12_06a -q e17:debug                                                                                                          
#setup lhapdf v5_9_1k -q e17:debug                                                                                                        
#setup log4cpp v1_1_3a -q e17:debug                                                                                                       
#setup pdfsets v5_9_1b             
#setup gdb v8_1                                                                                                                            
#setup git v2_15_1

git clone https://github.com/NuWro/nuwro.git nuwro
cd nuwro
export PATH=$PATH:$ROOTSYS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTSYS/lib
export PYTHIA6=${PYTHIA_FQ_DIR}/lib
export LIBRARY_PATH=${LIBRARY_PATH}:${PYTHIA6}
make
