#!/bin/bash                                                                                                                                

cd ../achilles/build

./bin/achilles ../../jobcards/run_argon.yml

cd -
mv ../achilles/build/achilles_argon.hepmc ./

nuisflat -i NuHepMC:achilles_argon.hepmc -o achilles.flat.root 
mv achilles_argon.hepmc samples/
mv achilles.flat.root samples/
 
