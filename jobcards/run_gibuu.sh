#!/bin/bash

# Generate GiBUU events
../GiBUU/release/testRun/./GiBUU.x < GiBUU2025_numu.job

# Convert all GiBUU outputs to Nuisance prep format
for f in EventOutput.Pert.*.root; do
    [ -e "$f" ] || continue  # skip if no files match

    # extract run number (everything after last dot, before .root)
    num=$(basename "$f" .root | awk -F. '{print $NF}')

    echo "Preparing $f -> GiBUU_${num}.prep.root"
    PrepareGiBUU -i "$f" -f sbnd_flux.root,flux_sbnd_numu -o "GiBUU_${num}.prep.root"
done

# Convert to Nuisance flat tree format

for f in GiBUU_*.prep.root; do
    [ -e "$f" ] || continue

    num=$(basename "$f" .prep.root | sed 's/GiBUU_//')

    echo "Flattening $f -> samples/GiBUU_${num}.flat.root"
    nuisflat -i GiBUU:"$f" -o "samples/GiBUU_${num}.flat.root"
done

# Optionally merge everything
hadd samples/GiBUU_all.flat.root samples/GiBUU_*.flat.root

# Cleanup
rm -f *.dat
rm -f GiBUU_database_decayChannels.txt
rm -f GiBUU_database.tex
rm -f main.run
rm -f PYR.RG
rm -f EventOutput.Pert.*.root
rm -f *.prep.root