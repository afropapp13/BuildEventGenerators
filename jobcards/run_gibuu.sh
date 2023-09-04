#!/bin/bash

# Generate GiBUU events
# GiBUU 2023
/uboone/app/users/apapadop/BuildEventGenerators/GiBUU2023/release/testRun/./GiBUU.x < GiBUU2023_MicroBooNE_numu.job
# GiBUU 2021
#/uboone/app/users/apapadop/BuildEventGenerators/GiBUU/release/testRun/./GiBUU.x < GiBUU_MicroBooNE_numu.job

# Convert to Nuisance format
PrepareGiBUU -i EventOutput.Pert.00000001.root -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o GiBUU.prep.root

# Convert to Nuisance flat tree format
nuisflat -i GiBUU:GiBUU.prep.root -o samples/GiBUU.flat.root

# Remove unnecessary files
rm *.dat
rm GiBUU_database_decayChannels.txt
rm GiBUU_database.tex
rm main.run
rm PYR.RG
rm EventOutput.Pert.00000001.root
mv GiBUU.prep.root samples/
