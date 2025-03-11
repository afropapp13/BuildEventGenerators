#!/bin/bash

# Generate GiBUU events
../GiBUU/release/testRun/./GiBUU.x < GiBUU2025_numu.job

# Convert to Nuisance format
#for i in {1..9}; do PrepareGiBUU -i EventOutput.Pert.0000000${i}.root -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o GiBUU_${i}.prep.root; done
#for i in {10..99}; do PrepareGiBUU -i EventOutput.Pert.000000${i}.root -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o GiBUU_${i}.prep.root; done
#for i in {100..300}; do PrepareGiBUU -i EventOutput.Pert.00000${i}.root -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o GiBUU_${i}.prep.root; done

PrepareGiBUU -i EventOutput.Pert.00000001.root -f sbnd_flux.root,flux_sbnd_numu -o GiBUU.prep.root

# Convert to Nuisance flat tree format
#for i in {1..300}; do nuisflat -i GiBUU:GiBUU_${i}.prep.root -o samples/GiBUU_${i}.flat.root; done
nuisflat -i GiBUU:GiBUU.prep.root -o samples/GiBUU.flat.root

#cd samples
#hadd GiBUU2023.flat.root GiBUU*.flat.root
#mv GiBUU2023.flat.root /pnfs/uboone/persistent/users/apapadop/GiBUU_Samples/GiBUU2023/GiBUU2023_300runs.root
##rm *.root
#cd ..

# Remove unnecessary files
#rm *.prep.root
rm *.dat
rm GiBUU_database_decayChannels.txt
rm GiBUU_database.tex
rm main.run
rm PYR.RG
rm EventOutput.Pert.000000*.root
mv GiBUU.prep.root samples/
