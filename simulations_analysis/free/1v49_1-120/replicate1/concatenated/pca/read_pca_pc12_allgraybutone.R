
library(ggpubr)

pca_proj <- read.fwf("2dproj.xvg", sep = "\t", skip = 16, widths=c(10, 11), col.names=c("PC1", "PC2")) #noCNter
# pca_proj <- read.fwf("2dproj_resall.xvg", sep = "\t", skip = 16, widths=c(10, 11), col.names=c("PC1", "PC2"))

pca_proj["index"]<- 1:900001


pca_proj["FF"]<- ""
pca_proj$FF[1:100001]<-"charmm22star"
pca_proj$FF[100002:200001]<-"charmm27"
pca_proj$FF[200002:300001]<-"charmm36"
pca_proj$FF[300002:400001]<-"amber99star-ildn-q"
pca_proj$FF[400002:500001]<-"amber99star-nmr"
pca_proj$FF[500002:600001]<-"a14"
pca_proj$FF[600002:700001]<-"rsff1"
pca_proj$FF[700002:800001]<-"rsff2"
pca_proj$FF[800002:900001]<-"amber99sb-disp"

# to convert nm to Angstrom
pca_proj$PC1 <- pca_proj$PC1*10
pca_proj$PC2 <- pca_proj$PC2*10

#subset, each x frame
pca_proj_sub <- pca_proj[seq(1, nrow(pca_proj), 50), ]


#install.packages("scatterD3")
library (scatterD3)

FFClasses <- unique(pca_proj_sub$FF)

pca_proj_sub["FF_color"] <- " Others"

#plot_list = list()
#
#for (FFnumber in 1:length(FFClasses)) {
#  
##pca_proj_sub_color <- subset(pca_proj_sub, pca_proj_sub$FF == FFClasses[1]) # or
#pca_proj_sub_color <- pca_proj_sub[pca_proj_sub$FF==FFClasses[FFnumber],]
#
#pca_proj_sub_color["FF_color"] <- FFClasses[FFnumber]
#
#pca_plot <- rbind(pca_proj_sub,pca_proj_sub_color) 
  
  
                    
#p <- ggscatter(pca_plot, x = "PC1", y = "PC2",
#              color = unique("FF_color"), 
#              palette = c("darkgray","red"),
#              #palette = c("red","darkgray"),
#              xlim=c(-2.5,4), ylim=c(-2.5,4),
#              legend.title = "FF",
#              font.legend = c("bold", 8),
#              size = 2, alpha = 0.6)+ border() 
#
## p + stat_density_2d()
#               
#plot_list[[FFnumber]] = p
#
#
#pca_proj_sub_color$FF_color <- NULL
#
#rm(pca_plot)
#
##color = "FF", palette = c("steelblue", "orange", "yellow","green","darkgreen","red","darkred","black","purple"), #palette = "jco",
#
#}



# # Other Option, different colors
FFClasses <- unique(pca_proj_sub$FF)

                          
                          
pca_proj_sub["FF_color"] <- " Others"


pca_proj_sub_color1 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[1],]
pca_proj_sub_color1["FF_color"] <- FFClasses[1]
pca_plot1 <- rbind(pca_proj_sub,pca_proj_sub_color1) 
  
pca_proj_sub_color2 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[2],]
pca_proj_sub_color2["FF_color"] <- FFClasses[2]
pca_plot2 <- rbind(pca_proj_sub,pca_proj_sub_color2) 

pca_proj_sub_color3 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[3],]
pca_proj_sub_color3["FF_color"] <- FFClasses[3]
pca_plot3 <- rbind(pca_proj_sub,pca_proj_sub_color3) 

pca_proj_sub_color4 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[4],]
pca_proj_sub_color4["FF_color"] <- FFClasses[4]
pca_plot4 <- rbind(pca_proj_sub,pca_proj_sub_color4) 

pca_proj_sub_color5 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[5],]
pca_proj_sub_color5["FF_color"] <- FFClasses[5]
pca_plot5 <- rbind(pca_proj_sub,pca_proj_sub_color5) 

pca_proj_sub_color6 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[6],]
pca_proj_sub_color6["FF_color"] <- FFClasses[6]
pca_plot6 <- rbind(pca_proj_sub,pca_proj_sub_color6) 

pca_proj_sub_color7 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[7],]
pca_proj_sub_color7["FF_color"] <- FFClasses[7]
pca_plot7 <- rbind(pca_proj_sub,pca_proj_sub_color7) 

pca_proj_sub_color8 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[8],]
pca_proj_sub_color8["FF_color"] <- FFClasses[8]
pca_plot8 <- rbind(pca_proj_sub,pca_proj_sub_color8) 

pca_proj_sub_color9 <- pca_proj_sub[pca_proj_sub$FF==FFClasses[9],]
pca_proj_sub_color9["FF_color"] <- FFClasses[9]
pca_plot9 <- rbind(pca_proj_sub,pca_proj_sub_color9) 



# xlim=c(-2.5,2.5), ylim=c(-2.5,2.5), #c(-2.5,4.1), ylim=c(-2.5,4.1)
FFallplot <- ggscatter(pca_proj_sub, x = "PC1", y = "PC2", #shape = 1,
                       color = "FF", palette = c("charmm22star"="gray60", "charmm27"="#E69F00","charmm36"="#56B4E9",
                                                 "amber99star-ildn-q"="#0072B2","amber99star-nmr"="#D55E00","a14"="#009E73","rsff1"="#AEC8C9","rsff2"="#CC79A7","amber99sb-disp"="purple"),
                       xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                       xlim=c(-25,25), ylim=c(-25,25), size = 2, alpha = 0.7) +
                       border() + theme(legend.position = "none")
FFallplot <- FFallplot+ annotate("text", x = -10, y = 23, label = paste0("All FFs")) # x = -1, y = 2,

FF1plot <- ggscatter(pca_plot1, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray", "gray30"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF1plot <- FF1plot+ annotate("text", x = -10, y = 23, label = paste0("CHARMM22*"))

FF1plot <- FF1plot+ annotate("text", x=pca_proj$PC1[1], y=pca_proj$PC2[1], label = "*", color="white")


FF2plot <- ggscatter(pca_plot2, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray", "#E69F00"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF2plot <- FF2plot+ annotate("text", x = -10, y = 23, label = paste0("CHARMM27"))

FF2plot <- FF2plot+ annotate("text", x=pca_proj$PC1[100002], y=pca_proj$PC2[100002], label = "*", color="white")


FF3plot <- ggscatter(pca_plot3, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray", "#56B4E9"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF3plot <- FF3plot+ annotate("text", x = -10, y = 23, label = paste0("CHARMM36"))

FF3plot <- FF3plot+ annotate("text", x=pca_proj$PC1[200002], y=pca_proj$PC2[200002], label = "*", color="white")



FF4plot <- ggscatter(pca_plot4, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray","#0072B2"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF4plot <- FF4plot+ annotate("text", x = -10, y = 23, label = paste0("ff99SB*-ILDN-Q"))

FF4plot <- FF4plot+ annotate("text", x=pca_proj$PC1[300002], y=pca_proj$PC2[300002], label = "*", color="white")


FF5plot <- ggscatter(pca_plot5, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray","#D55E00"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF5plot <- FF5plot+ annotate("text", x = -10, y = 23, label = paste0("ff99SBnmr1"))

FF5plot <- FF5plot+ annotate("text", x=pca_proj$PC1[400002], y=pca_proj$PC2[400002], label = "*", color="white")


FF6plot <- ggscatter(pca_plot6, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray", "#009E73"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF6plot <- FF6plot+ annotate("text", x = -10, y = 23, label = paste0("ff14SB"))

FF6plot <- FF6plot+ annotate("text", x=pca_proj$PC1[500002], y=pca_proj$PC2[500002], label = "*", color="white")


FF7plot <- ggscatter(pca_plot7, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray","#AEC8C9"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF7plot <- FF7plot+ annotate("text", x = -10, y = 23, label = paste0("RSFF1"))

FF7plot <- FF7plot+ annotate("text", x=pca_proj$PC1[600002], y=pca_proj$PC2[600002], label = "*", color="white")


FF8plot <- ggscatter(pca_plot8, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray","#CC79A7"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF8plot <- FF8plot+ annotate("text", x = -10, y = 23, label = paste0("RSFF2"))

FF8plot <- FF8plot+ annotate("text", x=pca_proj$PC1[700002], y=pca_proj$PC2[700002], label = "*", color="white")


FF9plot <- ggscatter(pca_plot9, x = "PC1", y = "PC2",
                     color = "FF_color", palette = c("darkgray","purple"),
                     xlab = "PC1 (Å)", ylab = "PC2 (Å)",
                     xlim=c(-25,25), ylim=c(-25,25),
                     size = 2, alpha = 0.7)+ border() + theme(legend.position = "none")
FF9plot <- FF9plot+ annotate("text", x = -10, y = 23, label = paste0("a99SB-disp"))

FF9plot <- FF9plot+ annotate("text", x=pca_proj$PC1[800002], y=pca_proj$PC2[800002], label = "*", color="white")


pdf("lc3b_pca_ff_noCNter_pcs12_NoLegend.pdf",  width = 17, height = 12, family = "Helvetica", onefile=FALSE) # defaults to 7 x 7 inches
# pdf("lc3b_pca_ff_each50frame_FF_allgraybutone_diff_col_newFF_resall.pdf", width=7, height=7) ## open pdf driver
# # Arranging the plot
ggarrange(FFallplot,FF1plot, FF2plot, FF3plot,
          FF6plot, FF4plot, FF5plot,FF8plot,
          FF9plot, FF7plot, NULL, NULL, 
          ncol = 4, nrow = 3,
          common.legend = FALSE)
dev.off() ## turn the pdf driver off

png(file = "lc3b_pca_ff_noCNter_pcs12_NoLegend.png", width = 1024, height = 768) #bg = "transparent",
# png(file = "lc3b_pca_ff_each50frame_FF_allgraybutone_diff_col_newFF_resall.png", width = 1024, height = 768) #bg = "transparent", 
ggarrange(FFallplot,FF1plot, FF2plot, FF3plot,
           FF6plot, FF4plot, FF5plot, FF8plot,
           FF9plot, FF7plot, NULL, NULL,
          ncol = 4, nrow = 3,
          common.legend = FALSE)
# rect(1, 5, 3, 7, col = "white")
dev.off()

