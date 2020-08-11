labels=$(python -c 'import md; print(" ".join(md.labels), end="")')

# plot ensemble comparison matrices
../structural_alphabet/plot_jsd ces.dat  -w 1 -l 1 -m 0 -x 1 -s 5 5 -c gray_r -t CES -b $labels -L -o ces -N -B e -C 2 -x 1.0
../structural_alphabet/plot_jsd dres.dat -w 1 -l 1 -m 0 -x 1 -s 5 5 -c gray_r -t DRES -b $labels -L -o dres -N -B e -C 2 -x 1.0
python plot_projection.py dres_projection.dat
python plot_space.py space_ces.dat
python plot_space.py space_dres.dat

