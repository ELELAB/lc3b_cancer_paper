#!/bin/bash

# This script requires:
#     a GROMACS installation
#     a R installation with the Peptides package installed


#source gromacs
. /usr/local/gromacs-5.1.5/bin/GMXRC

#variables

R="Rscript"
GMX="gmx"

MAKE_NDX="${GMX} make_ndx"
GYRATE="${GMX} gyrate"
SASA="${GMX} sasa"
RANKING="../rank_models_nodih.R"

BASE="lc3B_PLEKHM1"


mkdir -p ranking
cd ranking

# concatenate pdb files with theseus
theseus ../models/${BASE}.*.pdb
mv theseus_sup.pdb merged_models.pdb 


# create the following groups:
#     LC3 (1-120)
#     peptide (121-137)
#     HP1 side-chain (129)
#     HP2 side-chain (132)
# this uses ri, so it expects all models to be built in the same fashion
# as defined in these group definitions. This allows to ignore the
# actual residue numbering - 129 refers to the 129th residue in the
# complex and so on

${MAKE_NDX} -f merged_models.pdb -o index.ndx <<eof
ri 1-120
ri 121-137
ri 129 & 8
ri 132 & 8
q
eof

#calculate the radius of gyration of the LIR peptide
${GYRATE} -s merged_models.pdb -f merged_models.pdb -n index.ndx -o gyrate.xvg <<eof
11
eof

# calculate the solvent accessible surface area for the two residues of the LIR peptide localized inside the HP1 and HP2 of LC3. 
# This analysis should be performed with at least GROMACS version 5.0 (Here we used 5.1.0)
${SASA} -s merged_models.pdb  -f merged_models.pdb -o sasa_residues.xvg -n index.ndx -surface -output <<eof
1
12
13
eof

${R} ${RANKING} gyrate.xvg \
	sasa_residues.xvg 0 0.75 0 0.5
