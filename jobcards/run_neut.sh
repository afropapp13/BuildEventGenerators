#!/bin/bash

##use conatiner instructions below
##https://docs.google.com/document/d/1NIrI9BW4Vxw-zYUvec-hsDPSAluAqLuumdj27TG5cic/edit?usp=sharing

####################################################################

## Then run the commands below

cd ../neut_container/interactive

## for some reason this command is not working for neut
#singularity exec nuisance_nuint2024.sif /bin/bash run_neut_container.sh

/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer exec nuisance_nuint2024.sif /bin/bash -x run_neut_container.sh

cd -
mv ../neut_container/interactive/NEUT.flat.root samples/

##############################################################

## The output file name
#OUTFILE=NEUT.root

## The file that sets physics parameters for the NEUT simulation
#INCARD=neut_uboone_num.card

## NEUT uses the clock time for random seeding. To override this, you must provide a text file with a series of random numbers
## This file is accessed with the $RANFILE environment variable
#THIS_SEED=${RANDOM}
#echo "${THIS_SEED} $((THIS_SEED+1)) $((THIS_SEED+2)) $((THIS_SEED+3)) $((THIS_SEED+4))" > ranfile.txt
#export RANFILE=ranfile.txt

## This is NEUT's event generation application
#echo "Starting neutroot2..."
#neutroot2 ${INCARD} ${OUTFILE} &> /dev/null

## Only one NUISANCE step is required for NEUT
#echo "Creating NUISANCE flat trees"
#nuisflat -f GenericVectors -i NEUT:${OUTFILE} -o ${OUTFILE/.root/.flat.root}

## Clean up the files NEUT creates when generating events
#rm *_o.root ranfile.txt

##############################################################

##Ignore things below for now and until neut 6 becomes available
## Generate NEUT events
#neutroot2 neut_uboone_num.card bnb.ub.num.neut_5_4_0_1.root

## Prepare NuWro events for Nuisance
#PrepareNEUT -i bnb.ub.num.neut_5_4_0_1.root -o NEUT.prep.root -G -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv

## Convert to Nuisance flat tree
#nuisflat -i NEUT:NEUT.prep.root -o samples/NEUT.flat.root

## Remove unnecessary files
#rm bnb.ub.num.neut_5_4_0_1.root
##rm bnb.ub.num.neut_5_4_0_1.prep.root
#mv NEUT.prep.root samples
#rm hEnumu_cv_o.root
