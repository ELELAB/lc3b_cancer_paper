systems=["CHARMM22star", "CHARMM27", "CHARMM36",  "ff14SB", "ff99SBstar-ILDN",  "ff99SBstar-ILDN-Q", "ff99SBnmr1", "RSFF2", "a99SB-disp", "RSFF1"]
tops =  ["../../{0}/filt_tprs/md_ca.tpr".format(s) for s in systems]
trajs = ["../../{0}/filt_trjs/ca.xtc".format(s) for s in systems]
labels=["CHARMM22*", "CHARMM27", "CHARMM36",  "ff14SB", "ff99SB*-ILDN", "ff99SB*-ILDN-Q", "ff99SBnmr1", "RSFF2", "a99SB-disp", "RSFF1"]
colors = {      "CHARMM22star"      : "#999999",
                "CHARMM27"          : "#E69F00",
                "CHARMM36"          : "#56B4E9",
                "ff99SBstar-ILDN"   : "#F0E442",
                "ff99SBstar-ILDN-Q" : "#0072B2",
                "ff99SBnmr1"        : "#D55E00",
                "ff14SB"            : "#009E73",
                "RSFF1"             : "#AEC8C9",
                "RSFF2"             : "#CC79A7",
                "a99SB-disp"        : "#A020F0"
        }

