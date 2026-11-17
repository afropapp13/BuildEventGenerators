#!/bin/bash

#run neut
neutroot2 NEUT_6.2.3_CC_numu.toml samples/neut.ghep.root

## Only one NUISANCE step is required for NEUT
#echo "Creating NUISANCE flat trees"
nuisflat -f GenericVectors -i NEUT:samples/neut.ghep.root -o samples/neut.flat.root

rm flux_*_o.root