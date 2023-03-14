#!/bin/bash                                  

source global_vars.sh

mkdir GiBUU; cd GiBUU
wget --content-disposition https://gibuu.hepforge.org/downloads?f=release2021.tar.gz;tar -xzvf release2021.tar.gz
wget --content-disposition https://gibuu.hepforge.org/downloads?f=buuinput2021.tar.gz; tar -xzvf buuinput2021.tar.gz
wget --content-disposition https://gibuu.hepforge.org/downloads?f=libraries2021_RootTuple.tar.gz; tar -xzvf libraries2021_RootTuple.tar.gz
sed -i 's/-std=c++11/-std=c++17/g' libraries/RootTuple/RootTuple-master/src/CMakeLists.txt
#git clone https://github.com/afropapp13/GitGiBUU.git
#mv GitGiBUU/EventOutputFile.f90 release/code/inputOutput/EventOutputFile.f90
#rm -rf GitGiBUU

mkdir build; cd build
cmake -DCMAKE_INSTALL_PREFIX=./ ../libraries/RootTuple/RootTuple-master/
make
make install

cp lib/libRootTuple.a ../release/objects/LIB/lib/libRootTuple.100.a

cd ../release

# After discussion with Andy Mastbaum & C Wilkinson
# For fields x, y, z, you need to go back to your GiBUU build and, instead of make buildRootTuple, 
# do make buildRootTuple_POS  (version of the ntupler with the vtx location w/in the nucleus)
# Then re-run make withROOT

#make buildRootTuple_POS
make buildRootTuple

make withROOT=1
