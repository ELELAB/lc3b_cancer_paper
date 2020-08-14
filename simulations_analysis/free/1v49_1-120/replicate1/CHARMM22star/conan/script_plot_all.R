library(ggplot2)
library(viridis)
atg8 = read.table("/aggregate/timeline.dat", header = FALSE, fill = TRUE)
ff <- "charmm22star"
plotclr <- c(colorRampPalette(c("white", "blue"))(50),
             colorRampPalette(c("blue", "purple", "orange"))(55),
             colorRampPalette(c("orange", "red", "darkred"))(70))
x <- atg8$V1
y <- atg8$V2
z <- atg8$V4
### Plotting
pdf(paste("timeseries_atg8", ff, "pdf", sep="."), width=20,height=20)
plot(x, y, type = "n") # create new plot
z_scl <- (z - min(z, na.rm=T))/(max(z, na.rm=T) - min(z, na.rm=T))
color_scl = round(z_scl*length(plotclr))
color_scl[color_scl == 0] = 1

# Loop to plot each point
for(i in 1:length(x)){ 
  points(x[i], y[i], pch = 15, col = plotclr[color_scl[i]], cex = 1)
}
### End of Plotting
dev.off()

d = subset(atg8, x == 3)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "S3.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 16)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "R16.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 19)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "D19.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 21)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "R21.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 28)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "P28.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 29)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "T29.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 32)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "P32.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 35)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "I35.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 37)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "R37.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 38)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "Y38.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 39)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "K39.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 49)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "K49.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 56)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "D56.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 60)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "M60.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 65)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "K65.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 70)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "R70.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()


d = subset(atg8, x == 82)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "L82.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 89)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "V89.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 91)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "V91.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 98)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "V98.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

d = subset(atg8, x == 113)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "Y113.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()


d = subset(atg8, x == 120)
d2 <- d
d2[d2 == 0] <- NA
d3 <- d2[!is.na(d2$V5), ]
plot1 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V5))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "viridis", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Persistence during time') 
plot2 <- ggplot(d3, aes(as.factor(V1), as.factor(V2), fill = as.numeric(d3$V7))) + geom_tile() + scale_fill_viridis(begin =0, end =1, option = "magma", direction = -1) + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), axis.text.y=element_text(color="black",size=8)) + xlab("residue") + ylab("residue") + labs(fill='Number of contact formation')
pdf(paste("Heatmap_atg8", ff, "G120.pdf", sep="."))
require(gridExtra)
#plot1 + labs(x = "residue", y = "residue", fill = "Persistence during time")
grid.arrange(plot1, plot2, ncol=2)
dev.off()

#require(formattable)
#lc3 = read.table("/Users/Matteo/Dropbox (ELELAB)/lc3b_burcu/contact_map_conan/charmm27/aggregate/timeline.dat", header = FALSE, fill = TRUE)
#x <- lc3$V1
#y <- lc3$V2
#z <- lc3$V4


#lc3 <- subset(lc3, x %in% c(3, 16, 19, 21, 28, 29, 32, 35, 37, 38, 39, 49, 56, 60, 65, 70, 82, 89, 91, 98, 113, 120) , select=c(V1, V2, V5, V7))
#lc3[lc3 == 0] <- NA
#lc3_inter <- lc3[!is.na(lc3$V5), ]
#colnames(lc3_inter) <- c("res1", "res2", "persistence", "encounters")


#formattable(lc3_inter, list(
#  persistence = color_tile("white", "yellow"), 
#  area(col = c(encounters)) ~ normalize_bar("pink", 0.2)))
