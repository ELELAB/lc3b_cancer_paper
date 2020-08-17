

# read the concatenated trajectory containing each force field and run the PCA analysis
./run_pca_noCNter.sh

# calculate the percentages of protein motion explained by each PC
python get_PCA_percent_value.py eigenval.xvg > values.dat

# create the PCA plot
Rscript read_pca_pc12_allgraybutone.R


