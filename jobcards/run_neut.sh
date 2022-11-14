#!/bin/bash

# Generate NuWro events
neutroot2 neut_uboone_num.card bnb.ub.num.neut_5_4_0_1.root

# Prepare NuWro events for Nuisance
PrepareNEUT -i bnb.ub.num.neut_5_4_0_1.root -o NEUT.prep.root -G -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv

# Convert to Nuisance flat tree
nuisflat -i NEUT:NEUT.prep.root -o samples/NEUT.flat.root

# Remove unnecessary files
rm bnb.ub.num.neut_5_4_0_1.root
#rm bnb.ub.num.neut_5_4_0_1.prep.root
mv NEUT.prep.root samples
rm hEnumu_cv_o.root
