#!/bin/bash

#https://nuwro.github.io/user-guide/

# Generate NuWro events
nuwro -i NuWroCard_CC_Ar_numu.txt -o NuWroCard_CC_Ar_numu.prep.root

#convert to nuisance format
PrepareNuWroEvents -f NuWroCard_CC_Ar_numu.prep.root -o NuWro.prep.root

# Convert to Nuisance flat tree
nuisflat -i NuWro:NuWro.prep.root -o samples/NuWro.flat.root

# Remove unnecessary files
rm NuWroCard_CC_Ar_numu.prep.root
rm NuWro.*
rm NuWroCard_CC_Ar_numu.prep.root.*
rm Ar*.txt
rm q*.txt
rm T.txt
rm random_seed
rm totals.txt