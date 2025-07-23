#!/bin/bash

## The output file name
OUTFILE=NEUT.root
## The file that sets physics parameters for the NEUT simulation
INCARD=neut_argon.card

workdir="/opt/generators"
# Source ROOT
source $workdir/root/install/bin/thisroot.sh

# Source NEUT
source $workdir/neut/build/Linux/setup.sh

# Source NUISANCE
source $workdir/NUISANCE/build/Linux/setup.sh

## NEUT uses the clock time for random seeding. To override this, you must provide a text file with a series of random numbers
## This file is accessed with the $RANFILE environment variable
THIS_SEED=${RANDOM}
echo "${THIS_SEED} $((THIS_SEED+1)) $((THIS_SEED+2)) $((THIS_SEED+3)) $((THIS_SEED+4))" > ranfile.txt
export RANFILE=ranfile.txt
## This is NEUT's event generation application
echo "Running neutroot2..."
neutroot2 ${INCARD} ${OUTFILE}
echo $?


## Only one NUISANCE step is required for NEUT
echo "Creating NUISANCE flat trees"
nuisflat -f GenericVectors -i NEUT:${OUTFILE} -o ${OUTFILE/.root/.flat.root}
## Clean up the files NEUT creates when generating events
rm *_o.root ranfile.txt