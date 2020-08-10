export GSA_TOOLS=/usr/local/gsa-tools/
export GSA_ENCODE=$GSA_TOOLS/bin/g_sa_encode

ff=$(basename $(dirname $(pwd)))
simdir="../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/${ff}/md"

top_prot="${simdir}/Mol_An/update.gro"
traj="${simdir}/Mol_An/center_traj.xtc"

. $GSA_TOOLS/bin/GSATOOLSRC

$GSA_ENCODE     -s $top_prot \
                -f $traj \
                -strlf \
                -dt 100
