#!/bin/bash
# Script to simplify GENIE job submission to the grid

##### Parse any command-line options passed to this script ######
# This section is based on https://stackoverflow.com/a/29754866/4081973
#
# Currently, the allowed options for invoking this script are
#
# -p, --prod:  Submit jobs with the VOMS Production role (rather than the
#              usual Analysis role). The job will be run on the grid
#              using the anniepro account instead of your normal user
#              account. Job submission will fail unless you have permission
#              to submit production jobs.

# Check for a suitable version of the getopt program (should be installed
# on just about any flavor of Linux these days)
getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
    echo "ERROR: enhanced getopt is not installed on this system."
    exit 1
fi

# Number of expected command-line arguments
NUM_EXPECTED=8

# Define the command-line options accepted by this script
OPTIONS=p:
LONGOPTIONS=prod:

# Parse the command line used to run this script using getopt
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTIONS --name "$0" -- "$@")

if [[ $? -ne 0 ]]; then
    # getopt has complained about wrong arguments to stdout, so we can quit
    exit 2
fi

# Read getopt’s output this way to handle the quoting right
eval set -- "$PARSED"

# Process the options in order until we see --
while true; do
    case "$1" in
        -p|--prod)
            USE_PRODUCTION="y"
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Error encountered while parsing the command-line options!"
            exit 3
            ;;
    esac
done

if [ "$#" -ne "$NUM_EXPECTED" ]; then
  echo "Usage: ./submit_genie.sh [--prod] NUM_JOBS JOB_NAME ARGS_FILE SPLINES_FILE FLUX_FILE FLUX_HIST_NAME OUTPUT_DIRECTORY GIT_CHECKOUT"
  exit 1
fi

NUM_JOBS=$1
STEM=$2
ARGS_FILE=$3
SPLINES_FILE=$4
FLUX_FILE=$5
FLUX_HIST_NAME=$6
OUTPUT_DIRECTORY=$7
GIT_CHECKOUT=$8

GRID_RESOURCES_DIR=/pnfs/sbnd/persistent/users/$(whoami)/grid

# Check if the USE_PRODUCTION variable is set
if [ ! -z ${USE_PRODUCTION+x} ]; then
  echo "Production job will run as uboonepro"
  PROD_OPTION="--role=Production"
else
  echo "Analysis job will run as $(whoami)"
  PROD_OPTION="--role=Analysis"
fi

#source /cvmfs/fermilab.opensciencegrid.org/products/common/etc/setups
#setup fife_utils

MY_GENIE_ARGS="$(<$ARGS_FILE)"

jobsub_submit -G sbnd --disk=60GB --expected-lifetime=8h -N $NUM_JOBS \
  $PROD_OPTION -f $SPLINES_FILE -f $FLUX_FILE \
  -e FLUX_HIST_NAME=${FLUX_HIST_NAME} -d OUTPUT $OUTPUT_DIRECTORY \
  --resource-provides=usage_model=DEDICATED,OPPORTUNISTIC,OFFSITE \
  --singularity-image \
    /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-wn-sl7:latest \
  file://$GRID_RESOURCES_DIR/genie_grid.sh $STEM $(basename $SPLINES_FILE) \
  $(basename $FLUX_FILE) ${GIT_CHECKOUT} ${MY_GENIE_ARGS}
