# setwd("/data/user/shared_projects/atg8_proteins/md/lc3b/free/1v49/analyses/resolution_data_resprox")
setwd("/Users/burcu/Desktop/atg8-proteins_lc3b/resolution_data_resprox")

library(ggplot2)
library(ggpubr)

mydata1 <- read.fwf("../../CHARMM22star/resprox/charmm22star_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata2 <- read.fwf("../../CHARMM27/resprox/charmm27_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata3 <- read.fwf("../../CHARMM36/resprox/charmm36_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata4 <- read.fwf("../../ff14SB/resprox/a14_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101) 
mydata5 <- read.fwf("../../ff99SBstar-ILDN/resprox/amber99star-ildn_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata6 <- read.fwf("../../ff99SBstar-ILDN-Q/resprox/amber99star-ildn-q_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata7 <- read.fwf("../../ff99SBnmr1/resprox/amber99star-nmr_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata8 <- read.fwf("../../RSFF2/resprox/rsff2_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata9 <- read.fwf("../../a99SB-disp/resprox/amber99sb-disp_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  
mydata10 <- read.fwf("../../RSFF1/resprox/rsff1_resol_noCNter.txt", sep="\t", skip = 1, widths=c(9, 7, 6), n = 101)  


resol_df00 <- rbind(mydata1$V3,mydata2$V3,mydata3$V3,mydata4$V3,mydata5$V3,mydata6$V3,mydata7$V3,mydata8$V3,mydata9$V3,mydata10$V3)
 
resol_df0 <- data.frame(t(resol_df00))

colnames(resol_df0) <- c("charmm22star", "charmm27", "charmm36","a14","amber99star-ildn","amber99star-ildn-q","amber99star-nmr","rsff2","amber99sb-disp","rsff1")

library("tidyr")
resol_df <- gather(resol_df0)

#############################################
# No need for these anymore
# resol_df["index"]<- 1:1010
# 
# resol_df["FF"]<- ""
# resol_df$FF[1:101]<-"charmm22star"
# resol_df$FF[102:202]<-"charmm27"
# resol_df$FF[203:303]<-"charmm36"
# resol_df$FF[304:404]<-"a14"
# resol_df$FF[405:505]<-"amber99star-ildn"
# resol_df$FF[506:606]<-"amber99star-ildn-q"
# resol_df$FF[607:707]<-"amber99star-nmr"
# resol_df$FF[708:808]<-"rsff2"
# resol_df$FF[809:909]<-"amber99sb-disp"
# resol_df$FF[910:1010]<-"rsff1"
#############################################


# Give the chart file a name
png(file = "resol_ff_noCNter_boxplot_R.png", width = 1024, height = 768) #bg = "transparent"

## so change the margin on the left (no. 2)
## and shrink text size so we don't need a huge margin
op <- par(mar = c(10, 5, 4, 2) + 0.3)
boxplot(resol_df0, main="Prediction of resolution values for different FFs", xlab="", ylab="Resolution (Å)", 
        col = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "purple", "#AEC8C9"), las = 2, cex.axis=1.0) 
              # color-blind color set

#c("red","yellow","orange","pink", "purple", "blue", "steelblue", "gray", "darkgreen", "green")

abline(h=1.5, lty = "dotted", lwd=2, col = "red")

## reset the plotting parameters
par(op)

# Save the file.
dev.off()


# plot doesn't work by assigning to variables
# p1 <- plot(density(resol_df0$charmm22star),main = "CHARMM22star",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p2 <- plot(density(resol_df0$charmm27),main = "CHARMM27",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p3 <- plot(density(resol_df0$charmm36),main = "CHARMM36",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p4 <- plot(density(resol_df0$a14),main = "A14",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p5 <- plot(density(resol_df0$'amber99star-ildn'),main = "Amber99star-ildn",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p6 <- plot(density(resol_df0$'amber99star-ildn-q'),main = "Amber99star-ildn-q",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p7 <- plot(density(resol_df0$'amber99star-nmr'),main = "Amber99star-nmr",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p8 <- plot(density(resol_df0$rsff2),main = "RSFF2",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p9 <- plot(density(resol_df0$'amber99sb-disp'),main = "Amber99sb-disp",xlim=c(0.5,2.5), ylim=c(0,3.2))
# p10 <- plot(density(resol_df0$rsff1),main = "RSFF1",xlim=c(0.5,2.5), ylim=c(0,3.2))



shapiro1 <- shapiro.test(resol_df0$charmm22star)
shapiro2 <- shapiro.test(resol_df0$charmm27)
shapiro3 <- shapiro.test(resol_df0$charmm36)
shapiro4 <- shapiro.test(resol_df0$a14)
shapiro5 <- shapiro.test(resol_df0$`amber99star-ildn`)
shapiro6 <- shapiro.test(resol_df0$`amber99star-ildn-q`)
shapiro7 <- shapiro.test(resol_df0$`amber99star-nmr`)
shapiro8 <- shapiro.test(resol_df0$rsff2)
shapiro9 <- shapiro.test(resol_df0$`amber99sb-disp`)
shapiro10 <- shapiro.test(resol_df0$rsff1)

# xlab = "Resolution (\uc5)" #alternative for angstrom character

p1 <- ggdensity(resol_df0$charmm22star, xlab = "Resolution (Å)", ylab = "Density", main = "CHARMM22star",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p1p <- p1 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro1[["p.value"]],digits=3)))

p2 <- ggdensity(resol_df0$charmm27, xlab = "Resolution (Å)", ylab = "Density", main = "CHARMM27",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p2p <- p2 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro2[["p.value"]],digits=3)))

p3 <- ggdensity(resol_df0$charmm36, xlab = "Resolution (Å)", ylab = "Density", main = "CHARMM36",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p3p <- p3 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro3[["p.value"]],digits=3)))

p4 <- ggdensity(resol_df0$a14, xlab = "Resolution (Å)", ylab = "Density", main = "A14",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p4p <- p4 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro4[["p.value"]],digits=3)))

p5 <- ggdensity(resol_df0$'amber99star-ildn', xlab = "Resolution (Å)", ylab = "Density", main = "Amber99star-ildn",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p5p <- p5 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro5[["p.value"]],digits=3)))

p6 <- ggdensity(resol_df0$'amber99star-ildn-q', xlab = "Resolution (Å)", ylab = "Density", main = "Amber99star-ildn-q",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p6p <- p6 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro6[["p.value"]],digits=3)))

p7 <- ggdensity(resol_df0$'amber99star-nmr', xlab = "Resolution (Å)", ylab = "Density", main = "Amber99star-nmr",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p7p <- p7 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro7[["p.value"]],digits=3)))

p8 <- ggdensity(resol_df0$rsff2, xlab = "Resolution (Å)", ylab = "Density", main = "RSFF2",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p8p <- p8 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro8[["p.value"]],digits=3)))

p9 <- ggdensity(resol_df0$'amber99sb-disp', xlab = "Resolution (Å)", ylab = "Density", main = "Amber99sb-disp",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p9p <- p9 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro9[["p.value"]],digits=3)))

p10 <- ggdensity(resol_df0$rsff1, xlab = "Resolution (Å)", ylab = "Density", main = "RSFF1",xlim=c(0.5,2.5), ylim=c(0,3.2),size = 2, alpha = 0.7)+border()
p10p <- p10 + annotate("text", x = 2, y = 3, label = paste0("P-value = ", format(shapiro10[["p.value"]],digits=3)))




pdf("lc3b_resprox_distributions_noCNter.pdf", width=7, height=7) ## open pdf driver
# # Arranging the plot
ggarrange(p1p, p2p, p3p,
          p4p, p5p, p6p,
          p7p, p8p, p9p,
          p10p, NULL, NULL,
          ncol = 4, nrow = 4,
          common.legend = TRUE)

dev.off() ## turn the pdf driver off


png(file = "lc3b_resprox_distributions_noCNter.png", width = 1024, height = 768) #bg = "transparent", 
ggarrange(p1p, p2p, p3p,
          p4p, p5p, p6p,
          p7p, p8p, p9p,
          p10p, NULL, NULL,
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



