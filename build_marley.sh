#!/bin/bash                                  

source global_vars.sh

git clone https://github.com/MARLEY-MC/marley ./marley
cd marley
cd build
make
