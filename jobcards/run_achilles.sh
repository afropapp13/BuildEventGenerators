#!/bin/bash                                                                                                                                

cd ../achilles/build

./bin/achilles ../../jobcards/run_uboone.yml

cd -
mv ../achilles/build/achilles.hepmc ./

## this line is not working
#nuisflat -i NuHepMC:achilles.hepmc -o achilles.flat.root  

cp achilles.hepmc ../neut_container/interactive/
cd ../neut_container/interactive
/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer exec nuisance_nuint2024.sif /bin/bash nuisflat -i NuHepMC:achilles.hepmc -o achilles.flat.root

