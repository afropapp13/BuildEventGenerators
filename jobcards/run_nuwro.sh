#!/bin/bash

#https://nuwro.github.io/user-guide/

# Generate NuWro events
# old fashioned way
##nuwro -i NuWroCard_CC_Ar_uBFlux.txt -p "beam_particle = 14"  -p "beam_inputroot_flux = hEnumu_cv" -p "beam_inputroot = MCC9_FluxHist_volTPCActive.root"
# new way, May 22 2023
nuis gen NuWro -f  MCC9_FluxHist_volTPCActive.root,hEnumu_cv -P numu -n 100 -t Ar

# Prepare NuWro events for Nuisance
# old way
##PrepareNuwroEvents -f eventsout.root -F MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o NuWroCard_CC_Ar_uBFlux.prep.root
# new way, May 22 203
PrepareNuWroEvents -F MCC9_FluxHist_volTPCActive.root,hEnumu_cv,14 NuWro.numu.hEnumu_cv.MCC9_FluxHist_volTPCActive.1280.evts.root -o NuWro.prep.root

# Convert to Nuisance flat tree
nuisflat -i NuWro:NuWro.prep.root -o samples/NuWro.flat.root

# Remove unnecessary files
#rm eventsout.root.par
#rm eventsout.root.txt
#rm eventsout.root
#rm q0.txt
#rm q2.txt
#rm qv.txt
#rm totals.txt
#rm random_seed
#rm T.txt
#mv NuWro.prep.root samples/
