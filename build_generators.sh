#!/bin/bash                                                                                                                                                                                               

# GENIE v3.4.0
./build_genie.sh

# GiBUU 2023 patch 1
./build_gibuu.sh

# Private repo, teh code will be using my own neut build
#./build_neut.sh
./build_nuwro.sh
#./build_marley.sh

./build_achilles.sh

./build_nusyst.sh

./build_nuisance.sh
