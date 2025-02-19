#!/bin/bash                                                                                                                                

cd ../achilles/build

./bin/achilles ../../jobcards/run_uboone.yml

cd -
mv ../achilles/build/achilles.hepmc ./
# this line is not working / complaining about missing libtbb libraries
nuisflat -i NuHepMC:achilles.hepmc -o achilles.flat.root  
