#!/bin/bash                                                                                                                                

source global_vars.sh 

mkdir achilles
cd achilles
TOP_DIR=$(pwd)

##MPICH                                                                                                                                                                                                    
#mkdir mpich
#cd mpich
#MPICH_DIR=$(pwd)
#wget https://www.mpich.org/static/downloads/4.0.3/mpich-4.0.3.tar.gz
#tar -xvkf mpich-4.0.3.tar.gz
#cd mpich-4.0.3/
#./configure --prefix=$MPICH_DIR/mpich-install --disable-f08 --disable-collalgo-tests  &> con.log
#make &> make&>.log
#make install &> install.log
#cd $TOP_DIR

##HDF5                                                                                                                                                                                                     
#mkdir hdf5
#cd hdf5
#HDF5_DIR=$(pwd)
#cp /pnfs/uboone/resilient/users/markross/tars/hdf5-1.12.2.tar.gz .
#tar -xvkf hdf5-1.12.2.tar.gz
#cd hdf5-1.12.2/
#CC=$MPICH_DIR/mpich-install/bin/mpicc ./configure  --enable-parallel --prefix=$HDF5_DIR-install/
#make &> make.log
#make check &> make.check.log
#make install &> install.log
#make check-install &> install.check.log
#cd $TOP_DIR

##ACHILLES

export HDF5_LIBRARIES="/uboone/app/users/gardiner/temp-gen/BuildEventGenerators/achilles/hdf5-install/lib/"

git clone https://github.com/jxi24/Achilles.git
cd Achilles

mkdir build && cd build
cmake ..
make -jN

cd $TOP_DIR
