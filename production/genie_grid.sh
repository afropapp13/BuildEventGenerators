#!/bin/bash

STEM=$1
SPLINES_FILE=$2
FLUX_FILE=$3
GIT_CHECKOUT=$4

shift 4
MY_GENIE_ARGS="$@"

# Create a dummy file in the output directory. This is a hack to get jobs
# that fail to end themselves quickly rather than hanging on for a long time
# waiting for output to arrive.
DUMMY_OUTPUT_FILE=${CONDOR_DIR_OUTPUT}/${JOBSUBJOBID}_${STEM}_dummy_output
touch ${DUMMY_OUTPUT_FILE}

# Get the source code for GENIE v3
cd $CONDOR_DIR_INPUT
source /cvmfs/larsoft.opensciencegrid.org/products/setups
setup git v2_15_1
#git clone https://github.com/GENIE-MC/Generator.git genie-build
git clone https://github.com/sjgardiner/Generator.git genie-build

# Set up GENIE environment
setup root v6_12_04e -q e15:prof
setup lhapdf v5_9_1k -q e15:prof
setup pdfsets v5_9_1b
setup log4cpp v1_1_3a -q e15:prof

echo "Setting GENIE environment variables..."

export GENIEBASE=$(pwd)
export GENIE=$GENIEBASE/genie-build
export PYTHIA6=$PYTHIA_FQ_DIR/lib
# This is handled by the pdfsets ups product
#export LHAPATH=$LHAPDF_FQ_DIR
export LHAPDF5_INC=$LHAPDF_INC
export LHAPDF5_LIB=$LHAPDF_LIB
export LD_LIBRARY_PATH=$GENIE/lib:$LD_LIBRARY_PATH
export PATH=$GENIE/bin:$PATH
unset GENIEBASE

# Check out the requested git branch, tag, or commit
cd $GENIE
git checkout -b temp ${GIT_CHECKOUT}

# Configure for the build
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

# Build GENIE
make

# Get a randomly-selected random number seed using bash
myseed=${RANDOM}

# Generate some events
cd ${CONDOR_DIR_INPUT}
printf -v PADDED_PROCESS "%05d" $PROCESS
output_file_stem="${CONDOR_DIR_OUTPUT}/${STEM}_${myseed}_${PADDED_PROCESS}"
gevgen ${MY_GENIE_ARGS} --seed ${myseed} --cross-sections ${SPLINES_FILE} \
  -f ${FLUX_FILE},${FLUX_HIST_NAME} -o ${output_file_stem}.ghep.root

# Make a gst-format summary file for easy plotting
gntpc -i ${output_file_stem}.ghep.root -o ${output_file_stem}.gst.root -f gst
