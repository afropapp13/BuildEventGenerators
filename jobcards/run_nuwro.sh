#!/bin/bash

#https://nuwro.github.io/user-guide/

# Generate NuWro events
nuwro -i NuWroCard_CC_Ar_uBFlux.txt -p "beam_particle = 14"  -p "beam_inputroot_flux = hEnumu_cv" -p "beam_inputroot = MCC9_FluxHist_volTPCActive.root"

# Prepare NuWro events for Nuisance
PrepareNuwro -f eventsout.root -F MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o NuWroCard_CC_Ar_uBFlux.prep.root

# Convert to Nuisance flat tree
nuisflat -i NUWRO:NuWro.prep.root -o samples/NuWro.flat.root

# Remove unnecessary files
rm eventsout.root.par
rm eventsout.root.txt
rm eventsout.root
rm q0.txt
rm q2.txt
rm qv.txt
rm totals.txt
rm random_seed
rm T.txt
mv NuWro.prep.root samples/
