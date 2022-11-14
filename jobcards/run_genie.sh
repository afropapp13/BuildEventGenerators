#!/bin/bash

export Events=1000

# Produce the GENIE splines
#gmkspl -p 14 -t 1000180400 -e 10 -o 14_1000180400_Default_G18_10a_02_11a.xml --tune G18_10a_02_11a --event-generator-list CC

# Generate GENIE events
gevgen -n $Events -p 14 -t 1000180400 -e 0.,10.  --event-generator-list CC --tune G18_10a_02_11a --cross-sections 14_1000180400_Default_G18_10a_02_11a.xml -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv

# Convert file from ghep to gst
#gntpc -f gst -i gntp.0.ghep.root

# Convert file from ghep to nuisance format
PrepareGENIE -i gntp.0.ghep.root -t 1000180400[1] -o nuisance_gntp.0.gprep_G18_10a_02_11a.root -f MCC9_FluxHist_volTPCActive.root,hEnumu_cv

# Convert to nuisance flat tree format
nuisflat -i GENIE:nuisance_gntp.0.gprep_G18_10a_02_11a.root -o samples/GENIE_v3_0_6_G18_10a_02a.flat.root

# Remove all unnecessary files
rm genie-mcjob-0.status 
rm input-flux.root
#rm gntp.0.ghep.root
 mv gntp.0.ghep.root samples/
#rm nuisance_gntp.0.gprep_G18_10a_02_11a.root
mv nuisance_gntp.0.gprep_G18_10a_02_11a.root samples/
