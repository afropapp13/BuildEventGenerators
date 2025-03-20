Usage: ./submit_genie.sh [--prod] NUM_JOBS JOB_NAME ARGS_FILE SPLINES_FILE FLUX_FILE FLUX_HIST_NAME OUTPUT_DIRECTORY GIT_CHECKOUT

# don't forget
# cp genie_grid.sh /pnfs/sbnd/persistent/users/apapadop/grid # or wherever your /persistent area might be

JOB_NAME = arbitrary prefix for the output files

ARGS_FILE = text file containing extra arguments to be passed to gevgen (see args.txt for an example)

SPLINES_FILE = XML file containing the splines for the tune you want to run. It must be stored somewhere on /cvmfs or /pnfs in order for the grid to be able to see it. eg /cvmfs/larsoft.opensciencegrid.org/products/genie_xsec/v3_04_00/NULL/AR2320i00000-k250-e1000/data/gxspl-NUsmall.xml or your own production

FLUX_FILE = ROOT file containing the flux histogram. Same storage rules under /cvmfs or /pnfs.

FLUX_HIST_NAME = Name used by TFile::GetObject() to retrieve the flux histogram

OUTPUT_DIRECTORY = folder on scratch or persistent that will receive the output files eg /pnfs/sbnd/persistent/users/apapadop/grid

GIT_CHECKOUT = identifier passed to git to indicate what version of the code you want checked out. Valid options are commit hashes, origin/BRANCH_NAME for a branch named BRANCH_NAME, and version tags like R-3_06_00.

example:

./submit_genie.sh 2 afro_grid_test_gene args.txt /pnfs/sbnd/persistent/users/apapadop/grid/14_1000180400_CC_v3_6_0_AR23_20i_00_000.xml /pnfs/sbnd/persistent/users/apapadop/grid/sbnd_flux.root flux_sbnd_numu /pnfs/sbnd/persistent/users/apapadop/grid/ tags/R-3_06_00
