

# read the filtered trajectory for the current force field and run the PCA analysis
./run_pca_noCNter.sh

# calculate the percentages of protein motion explained by each PC
python get_PCA_percent_value.py eigenval.xvg > values.dat



