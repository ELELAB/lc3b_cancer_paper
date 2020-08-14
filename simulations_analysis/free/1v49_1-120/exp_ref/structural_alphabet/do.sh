export GSA_TOOLS=/usr/local/gsa-tools/
. ${GSA_TOOLS}/bin/GSATOOLSRC
GSA_ENCODE=$GSA_TOOLS/bin/g_sa_encode

PDB_ID=1V49
PDB=${PDB_ID}.pdb

wget https://files.rcsb.org/download/${PDB}

$GSA_ENCODE     -s ${PDB} \
                -f ${PDB} \
                -strlf

