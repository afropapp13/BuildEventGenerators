#!/bin/bash                                  

# Set up ups products needed to use the various generators                                                                                  
#source /grid/fermiapp/products/larsoft/setups

#setup root v6_12_06a -q e17:debug
#setup lhapdf v5_9_1k -q e17:debug
#setup log4cpp v1_1_3a -q e17:debug
#setup pdfsets v5_9_1b
#setup gdb v8_1
#setup git v2_15_1
#setup cmake v3_14_3

mkdir GiBUU; cd GiBUU
wget --content-disposition https://gibuu.hepforge.org/downloads?f=release2021.tar.gz;tar -xzvf release2021.tar.gz
wget --content-disposition https://gibuu.hepforge.org/downloads?f=buuinput2021.tar.gz; tar -xzvf buuinput2021.tar.gz
wget --content-disposition https://gibuu.hepforge.org/downloads?f=libraries2021_RootTuple.tar.gz; tar -xzvf libraries2021_RootTuple.tar.gz

sed -i 's/-std=c++11/-std=c++17/g' libraries/RootTuple/RootTuple-master/src/CMakeLists.txt

mkdir build; cd build
cmake -DCMAKE_INSTALL_PREFIX=./ ../libraries/RootTuple/RootTuple-master/
make
make install

cp lib/libRootTuple.a ../release/objects/LIB/lib/libRootTuple.100.a

cd ../release

make withROOT=1
