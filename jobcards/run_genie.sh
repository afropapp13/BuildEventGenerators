#!/bin/bash

export events="100"
export version="v3_6_0"

export tune="AR23_20i_00_000"
#export tune="G18_10a_02_11a"

export probe="14"
export target="1000180400"
export interaction="CC"
export minE="0."
export maxE="10."

export fluxfile="./sbnd_flux.root";export fluxhisto="flux_sbnd_numu"
#export fluxfile="./MCC9_FluxHist_volTPCActive.root";export fluxhisto="hEnumu_cv"

export outdir="./samples"

# Produce the GENIE splines
#gmkspl -p ${probe} -t ${target} -e ${maxE} -o ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.xml --tune ${tune} --event-generator-list ${interaction}

# Convert the xml splines to root format
gspl2root -f ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.xml --event-generator-list ${interaction} -p ${probe} -t ${target} -o ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.xml.root --tune ${tune}

# Generate GENIE events
gevgen -n $events -p ${probe} -t ${target} -e ${minE},${maxE}  --event-generator-list ${interaction} --tune ${tune} --cross-sections ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.xml -f ${fluxfile},${fluxhisto} -o ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.ghep.root

# Convert file from ghep to gst
gntpc -f gst -i ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.ghep.root -o ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.gst.root --tune ${tune}

# Convert file from ghep to nuisance format
PrepareGENIE -i ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.ghep.root -t ${target}[1] -o ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.gprep.root -f ${fluxfile},${fluxhisto}

# Convert to nuisance flat tree format
nuisflat -i GENIE:${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.gprep.root -o ${outdir}/${probe}_${target}_${interaction}_${version}_${tune}.flat.root

# Remove all unnecessary files
##rm *.status 
rm input-flux.root
