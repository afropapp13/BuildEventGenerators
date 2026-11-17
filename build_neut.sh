#!/bin/bash                                                                                                                                                                                              

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]:-${(%):-%x}}" )" && pwd )"
source ${BASE_DIR}/global_vars.sh         

echo ${USER}
if [[ ${USER} == "apapadop" ]]; then 
    if [ ! -d "neut" ]; then
        git clone https://github.com/neut-devel/neut.git
    fi
    cd neut
    git fetch --tags
    git checkout tags/6.2.3
else
    case "${hostgpvm}" in
        uboone) cp -rf /exp/sbnd/app/users/apapadop/BuildEventGenerators/neut ./ ;;
        sbnd)   cp -rf /exp/uboone/app/users/bbogart/new_BuildEventGen/BuildEventGenerators/neut ./;;
        icarus) cp -rf /exp/sbnd/app/users/apapadop/BuildEventGenerators/neut ./ ;;
        dune)   echo "Sorry no NEUT"; exit 0 ;;
        *)      echo "Sorry no NEUT" exit 0 ;;   # generic fallback
    esac
    export EXPERIMENT=${EXPERIMENT:-${hostgpvm}}
    rm -rf neut/build
    cd neut
fi

mkdir build; cd build;
cmake ../ -DNEUT_DOWNLOAD_DATA=OFF -DNEUT_WERROR_ENABLED=OFF
make -j 4
make install
source $(pwd)/Linux/bin/setup.NEUT.sh 
