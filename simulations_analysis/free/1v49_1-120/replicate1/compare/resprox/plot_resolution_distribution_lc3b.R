#setwd("/Users/burcu/Desktop/atg8-proteins_lc3b/resolution_data_resprox")

library(ggplot2)
library(ggpubr)

mydata1 <- read.fwf("../../CHARMM22star/resprox/charmm22star_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata2 <- read.fwf("../../CHARMM27/resprox/charmm27_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata3 <- read.fwf("../../CHARMM36/resprox/charmm36_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata4 <- read.fwf("../../ff14SB/resprox/a14_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101) 
mydata5 <- read.fwf("../../ff99SBstar-ILDN-Q/resprox/amber99star-ildn-q_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata6 <- read.fwf("../../ff99SBnmr1/resprox/amber99star-nmr_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata7 <- read.fwf("../../RSFF2/resprox/rsff2_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata8 <- read.fwf("../../a99SB-disp/resprox/amber99sb-disp_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata9 <- read.fwf("../../RSFF1/resprox/rsff1_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  


resol_df00 <- rbind(mydata1$V3,mydata2$V3,mydata3$V3,mydata4$V3,mydata5$V3,mydata6$V3,mydata7$V3,mydata8$V3,mydata9$V3)
 
resol_df0 <- data.frame(t(resol_df00))

colnames(resol_df0) <- c("CHARMM22*", "CHARMM27", "CHARMM36","ff14SB","ff99SB*-ILDN-Q","ff99SBnmr1","RSFF2","a99SB-disp","RSFF1")


library("tidyr")
resol_df <- gather(resol_df0)



# Give the chart file a name
#png(file = "resol_ff_noCNter_boxplot_R.png", width = 1024, height = 768) #bg = "transparent"
pdf(file = "resol_ff_noCNter_boxplot_R_160820.pdf", width = 17, height = 12, family = "Helvetica") # defaults to 7 x 7 inches

## so change the margin on the left (no. 2)
## and shrink text size so we don't need a huge margin
op <- par(mar = c(11, 5, 4, 2) + 0.2)
boxplot(resol_df0, main="Prediction of resolution values for different FFs", xlab="", ylab="Resolution (Å)", ylim = c(0,3.0),
        #        col = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "purple", "#AEC8C9"), las = 2, 
        col = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "purple", "#AEC8C9"), las = 2, 
        cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6) 
        # color-blind color set

#c("red","yellow","orange","pink", "purple", "blue", "steelblue", "gray", "darkgreen", "green")

abline(h=1.5, lty = "dotted", lwd=2, col = "red")

## reset the plotting parameters
par(op)

# Save the file.
dev.off()

shapiro1 <- shapiro.test(resol_df0$`CHARMM22*`)
shapiro2 <- shapiro.test(resol_df0$CHARMM27)
shapiro3 <- shapiro.test(resol_df0$CHARMM36)
shapiro4 <- shapiro.test(resol_df0$ff14SB)
shapiro5 <- shapiro.test(resol_df0$`ff99SB*-ILDN-Q`)
shapiro6 <- shapiro.test(resol_df0$`ff99SBnmr1`)
shapiro7 <- shapiro.test(resol_df0$RSFF2)
shapiro8 <- shapiro.test(resol_df0$`a99SB-disp`)
shapiro9 <- shapiro.test(resol_df0$RSFF1)

# xlab = "Resolution (\uc5)" #alternative for angstrom character

p1 <- ggdensity(resol_df0$`CHARMM22*`, xlab = "Resolution (Å)", ylab = "Density", main = "CHARMM22star",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p1p <- p1 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro1[["p.value"]],digits=3)))

p2 <- ggdensity(resol_df0$CHARMM27, xlab = "Resolution (Å)", ylab = "Density", main = "CHARMM27",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p2p <- p2 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro2[["p.value"]],digits=3)))

p3 <- ggdensity(resol_df0$CHARMM36, xlab = "Resolution (Å)", ylab = "Density", main = "CHARMM36",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p3p <- p3 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro3[["p.value"]],digits=3)))

p4 <- ggdensity(resol_df0$ff14SB, xlab = "Resolution (Å)", ylab = "Density", main = "A14",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p4p <- p4 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro4[["p.value"]],digits=3)))

p5 <- ggdensity(resol_df0$`ff99SB*-ILDN-Q`, xlab = "Resolution (Å)", ylab = "Density", main = "Amber99star-ildn-q",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p5p <- p5 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro5[["p.value"]],digits=3)))

p6 <- ggdensity(resol_df0$`ff99SBnmr1`, xlab = "Resolution (Å)", ylab = "Density", main = "Amber99star-nmr",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p6p <- p6 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro6[["p.value"]],digits=3)))

p7 <- ggdensity(resol_df0$RSFF2, xlab = "Resolution (Å)", ylab = "Density", main = "RSFF2",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p7p <- p7 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro7[["p.value"]],digits=3)))

p8 <- ggdensity(resol_df0$`a99SB-disp`, xlab = "Resolution (Å)", ylab = "Density", main = "Amber99sb-disp",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p8p <- p8 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro8[["p.value"]],digits=3)))

p9 <- ggdensity(resol_df0$RSFF1, xlab = "Resolution (Å)", ylab = "Density", main = "RSFF1",xlim=c(0.5,4.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p9p <- p9 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro9[["p.value"]],digits=3)))



pdf("lc3b_resprox_distributions_noCNter.pdf", width=7, height=7) ## open pdf driver
# pdf("lc3b_resprox_distributions_resall.pdf", width=7, height=7) ## open pdf driver
# # Arranging the plot
ggarrange(p1p, p2p, p3p,
          p4p, p5p, p6p,
          p7p, p8p, p9p,
          ncol = 4, nrow = 4,
          common.legend = TRUE)

dev.off() ## turn the pdf driver off


png(file = "lc3b_resprox_distributions_noCNter.png", width = 1024, height = 768) #bg = "transparent",
# png(file = "lc3b_resprox_distributions_resall.png", width = 1024, height = 768) #bg = "transparent", 
ggarrange(p1p, p2p, p3p,
          p4p, p5p, p6p,
          p7p, p8p, p9p,
          ncol = 4, nrow = 4,
          common.legend = TRUE)

dev.off()



# All densities together
png(file = "lc3b_resprox_distributions_ALLinONE_noCNter.png", width = 1024, height = 768) #bg = "transparent", 

ggplot() + 
  geom_density(data=resol_df, aes(x=value, group=key, fill=key), alpha=0.5, adjust=2) + 
  xlab("Resolution (Å)") +
  ylab("Density")

dev.off()

#pairwise Mann-Whitney-U-test
pairwise.wilcox.test(resol_df$value, resol_df$key, p.adjust.method = "bonferroni")

pairwise.wilcox.test(resol_df$value, resol_df$key, p.adjust.method = "holm") # actually the default is Holm

pairwise.wilcox.test(resol_df$value, resol_df$key, p.adjust.method = "none")


export.tab <- as.matrix(resol_df0)
write.table(export.tab,"resol_MWUtest.txt",quote = FALSE, sep = ";", row.names = TRUE, col.names = TRUE)

