. /usr/local/gromacs-2019.4/bin/GMXRC

GMX="gmx"
GMX_SAS="$GMX sasa"
GMX_SELECT="$GMX select"
TMPF1=$(tempfile)
TMPF2=$(tempfile)
TMPF3=$(tempfile)
TMPF4=$(tempfile)
OUTF=values.dat

reference_table=reference_table
ndxs=ndxs
pdbs=cleaned_structures
sasa=sasa

mkdir -p $ndxs
mkdir -p $sasa
rm -f ${ndxs}/*
rm -f ${sasa}/*

echo -n '' > $TMPF1
echo -n '' > $TMPF2
echo -n '' > $TMPF3

echo -e '#pdb\thp1\thp2\tsasHP1\tsasHP2' > $OUTF

while read line; do
	read pdb hp1chain hp1res hp2chain hp2res <<< $line
	grp1name="ch"${hp1chain}'_&_r_'{$hp1res}'_&_SideChain'
	grp2name="ch"${hp2chain}'_&_r_'{$hp2res}'_&_SideChain'
	$GMX_SELECT -s ${pdbs}/${pdb}.pdb -on $ndxs/${pdb}.ndx -select \
		"group 2"\
		"chain ${hp1chain} and resnr ${hp1res} and group 9"\
		"chain ${hp2chain} and resnr ${hp2res} and group 9"
	$GMX_SAS -s ${pdbs}/${pdb}.pdb -f ${pdbs}/${pdb}.pdb -o ${sasa}/${pdb}.xvg -n ${ndxs}/${pdb}.ndx -surface -output <<EOF
0
1
2
EOF
	rm -f ${sasa}/\#*
	hp1sel=$(python extract_res_pos.py ${pdbs}/${pdb}.pdb ${hp1chain} ${hp1res})
	hp2sel=$(python extract_res_pos.py ${pdbs}/${pdb}.pdb ${hp2chain} ${hp2res})
	echo -ne "$(egrep -v '(@|#)' ${sasa}/${pdb}.xvg | head -n 1 | tr -s ' ' | cut -f4,5 -d ' ' | tr ' ' '\t')"      > $TMPF4
	yes ${pdb}        | head -n $(nl $TMPF4 | wc -l | cut -d ' ' -f 2) > $TMPF1
	yes ${hp1sel:0:3} | head -n $(nl $TMPF4 | wc -l | cut -d ' ' -f 2) > $TMPF2
	yes ${hp2sel:0:3} | head -n $(nl $TMPF4 | wc -l | cut -d ' ' -f 2) > $TMPF3

	paste $TMPF1 $TMPF2 $TMPF3 $TMPF4 >> $OUTF

done < $reference_table
