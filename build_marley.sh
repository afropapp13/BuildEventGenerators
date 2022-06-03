#!/bin/bash                                  

# Set up ups products needed to use the various generators                                                                                                                                                         
#source /grid/fermiapp/products/larsoft/setups

#setup root v6_12_06a -q e17:debug
#setup lhapdf v5_9_1k -q e17:debug
#setup log4cpp v1_1_3a -q e17:debug
#setup pdfsets v5_9_1b
#setup gdb v8_1
#setup git v2_15_1
#setup cmake v3_11_4

git clone https://github.com/MARLEY-MC/marley ./marley
cd marley
cd build
make
