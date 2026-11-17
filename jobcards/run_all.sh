#!/bin/bash

./run_genie.sh
./run_gibuu.sh
if command -v neutroot2 >/dev/null 2>&1; then
    ./run_neut.sh
else
    printf "Skipping NEUT, no build found.\n"
fi
./run_nuwro.sh
