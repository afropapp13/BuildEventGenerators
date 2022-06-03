#!/bin/bash

write_genie_env_script() {
cat > ./genie_env.sh << 'EOF'
#!/bin/bash

source ../global_vars.sh

#source /grid/fermiapp/products/larsoft/setups

#setup root v6_12_06a -q e17:debug
#setup lhapdf v5_9_1k -q e17:debug
#setup log4cpp v1_1_3a -q e17:debug
#setup pdfsets v5_9_1b
#setup gdb v8_1
#setup git v2_15_1

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
  --enable-gsl \
  --enable-rwght \
  --with-optimiz-level=O2 \
  --with-log4cpp-inc=${LOG4CPP_INC} \
  --with-log4cpp-lib=${LOG4CPP_LIB} \
  --with-libxml2-inc=${LIBXML2_INC} \
  --with-libxml2-lib=${LIBXML2_LIB} \
  --with-lhapdf5-lib=${LHAPDF_LIB} \
  --with-lhapdf5-inc=${LHAPDF_INC} \
  --with-pythia6-lib=${PYTHIA_LIB}
EOF
}

git clone https://github.com/GENIE-MC/Generator.git
git clone https://github.com/GENIE-MC/Reweight.git
write_genie_env_script
cd Generator
git checkout -b v3.2.0 R-3_02_00
write_do_configure_script
source do_configure.sh
make -j4
cd ../Reweight
git checkout -b v1.2.0 R-1_02_00
make -j4
cd ..
echo "DONE!"
