This directory contains the calculation of reference values for the solvent
accessible area (SAS) of the side-chains of LC3-bound peptides harboring a LIR
motif. 

The cleaned_structures directory contains modified versions of the original PDB
files which have been elaborated by reconstruing the biological unit, when they
are fusion constructs, and the core LIR motif is kept. These PDB files are then
used to calculate the SAS of the respective HP1 and HP2 residues, and these
values are then used as bounds in order to judge the quality of our homology
models.

The reference_table file contains, for each experimental complex, chain and
number fo the HP1 and HP2 residues, in this order. This is then used by the
do_analysis.sh script. The script requires an installation of GROMACS, as well
as a Python 3.7 environment with MDAnalysis installed.

The values.dat file is the product of the whole calculation and contains the SAS
value for each case, in nm^2.

In order to run the analysis, just run the do_analysis.sh file, after installing
the prerequisites and taking care to have the right source of your GROMACS
install in the file (see the first line of do_analysis.sh).

The structures used for the calculation are:

	PDB		LC3 	Ligand
   ---------------------------
	2LUE	LC3B 	OPTN
	2N9X	LC3B 	FUNDC1
	3WAN	LC3A	ATG13
	3WAO	LC3B	ATG13
	3WAP	LC3C	ATG13
	3X0W	LC3B	PLEKHM1
	4WAA	LC3B	NIX
	4ZDV	LC3A	FAM134B
	5CX3	LC3A	FYCO1
	5D94	LC3B	FYCO1
	5DPR	LC3A	PLEKHM1
	5DPW	LC3C	PLEKHM1
	5GMV	LC3B 	FUNDC1
