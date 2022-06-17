#!/bin/bash

# Generate NuWro events
nuwro -i NuWroCard_CC_Ar_uBFlux.txt

# Prepare NuWro events for Nuisance
PrepareNuwro -f eventsout.root

# Convert to Nuisance flat tree
nuisflat -i NUWRO:eventsout.root -o samples/NuWro.flat.root

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
