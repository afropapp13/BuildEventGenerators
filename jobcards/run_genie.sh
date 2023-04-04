#!/bin/bash

export events="1000"
export version="v3_4_0"
export tune="G18_10a_02_11a"
export probe="14"
export target="1000180400"
export interaction="CC"
export minE="0."
export maxE="10."
export fluxfile="/uboone/app/users/apapadop/BuildEventGenerators/jobcards/MCC9_FluxHist_volTPCActive.root"
export fluxhisto="hEnumu_cv"

# Produce the GENIE splines
#gmkspl -p ${probe} -t ${target} -e ${maxE} -o ${probe}_${target}_${interaction}_${version}_${tune}.xml --tune ${tune} --event-generator-list ${interaction}

# Convert the xml splines to root format
gspl2root -f ${probe}_${target}_${interaction}_${version}_${tune}.xml --event-generator-list ${interaction} -p ${probe} -t ${target} -o ${probe}_${target}_${interaction}_${version}_${tune}.root --tune ${tune}

# Generate GENIE events
gevgen -n $events -p ${probe} -t ${target} -e ${minE},${maxE}  --event-generator-list ${interaction} --tune ${tune} --cross-sections ${probe}_${target}_${interaction}_${version}_${tune}.xml -f ${fluxfile},${fluxhisto} -o samples/${probe}_${target}_${interaction}_${version}_${tune}.ghep.root

# Convert file from ghep to gst
gntpc -f gst -i samples/${probe}_${target}_${interaction}_${version}_${tune}.ghep.root -o samples/${probe}_${target}_${interaction}_${version}_${tune}.gst.root

# Convert file from ghep to nuisance format
PrepareGENIE -i samples/${probe}_${target}_${interaction}_${version}_${tune}.ghep.root -t ${target}[1] -o samples/${probe}_${target}_${interaction}_${version}_${tune}.gprep.root -f ${fluxfile},${fluxhisto}

# Convert to nuisance flat tree format
nuisflat -i GENIE:samples/${probe}_${target}_${interaction}_${version}_${tune}.gprep.root -o samples/${probe}_${target}_${interaction}_${version}_${tune}.flat.root

# Remove all unnecessary files
#rm *.status 
rm input-flux.root
