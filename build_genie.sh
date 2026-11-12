#!/bin/bash

write_genie_env_script() {
cat > ./genie_env.sh << 'EOF'
#!/bin/bash

source ../global_vars.sh
echo "Setting GENIE environment variables..."

# Finds the directory where this script is located. This method isn't
# foolproof. See https://stackoverflow.com/a/246128/4081973 if you need
# something more robust for edge cases (e.g., you're calling the script using
# symlinks).
THIS_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export GENIEBASE=$THIS_DIRECTORY
export GENIE=$GENIEBASE/Generator
export PYTHIA6=$PYTHIA_FQ_DIR/lib
export LHAPDF5_INC=$LHAPDF_INC
export LHAPDF5_LIB=$LHAPDF_LIB
export XSECSPLINEDIR=$GENIEBASE/data
export GENIE_REWEIGHT=$GENIEBASE/Reweight
export PATH=$GENIE/bin:$GENIE_REWEIGHT/bin:$PATH
export LD_LIBRARY_PATH=$GENIE/lib:$GENIE_REWEIGHT/lib:$LD_LIBRARY_PATH
unset GENIEBASE
EOF
}

write_do_configure_script() {
cat > ./do_configure.sh << 'EOF'
#!/bin/bash

source ../genie_env.sh

./configure \
  --with-compiler=gcc \
  ${OPT_FLAGS} \
  --enable-fnal \
  --enable-gfortran \
  --enable-gsl \
  --enable-rwght \
  --enable-atmo \
  --enable-geant4 \
  --with-geant4-inc=${GEANT4_FQ_DIR}/include \
  --with-geant4-lib=${GEANT4_FQ_DIR}/lib \
  --disable-lhapdf5 \
  --enable-lhapdf6 \
  --with-lhapdf6-inc=${LHAPDF_INC} \
  --with-lhapdf6-lib=${LHAPDF_LIB} \
  --enable-pythia8 \
  --disable-pythia6 \
  --with-pythia8-inc=${PYTHIA8_INC} \
  --with-pythia8-lib=${PYTHIA8_LIB} \
  --enable-hepmc3 \
  --enable-incl \
  --with-incl-inc=${INCLXX_FQ_DIR}/include/inclxx \
  --with-incl-lib=${INCLXX_FQ_DIR}/lib \
  --with-log4cpp-inc=${LOG4CPP_INC} \
  --with-log4cpp-lib=${LOG4CPP_LIB} \
  --with-libxml2-inc=${LIBXML2_INC} \
  --with-libxml2-lib=${LIBXML2_LIB} \
  --with-boost-inc=${BOOST_FQ_DIR}/include \
  --with-boost-lib=${BOOST_FQ_DIR}/lib
EOF
}

git clone https://github.com/GENIE-MC/Generator.git
git clone https://github.com/GENIE-MC/Reweight.git
write_genie_env_script
cd Generator
git checkout -b v3.8.0 R-3_08_00
write_do_configure_script
source do_configure.sh
make -j4 GOPT_WITH_COMPILER=gcc
cd ../Reweight
git checkout -b v1.6.0 R-1_06_00
make -j4 GOPT_WITH_COMPILER=gcc
cd ..
echo "DONE!"
