## builds strongly off of 'mapplots' package, but now incorporates more general worldwide mapping abilities by combining with existing mapdata

library(maps)
library(mapdata)
library(maptools)
library(mapplots)
library(scales)



#dummy data
dat <- read.csv("")







map("world", xlim=c(-130,30),ylim=c(34,59.5), resolution=0.01,  col="gray90", fill=TRUE)#, projection="conic", param=30)
map("state", add=TRUE)
ids <- seq(1, length(gps$POP)) #make a list the length of my number of data points
i <- 0  #start the loop at 0
for(i in ids){   #run through all data points
	east <- gps[i,2]
	west <- gps[i,3]
	tot <- gps[i,4]
	lat <- gps[i,5]
	lon <- gps[i,6]
	add.pie(z=c(east, west), x=lon, y=lat, radius=sqrt(tot)/2, col=c(alpha("orange", 0.6), alpha("blue", 0.6)), labels="")
	#draw.pie((z=c(east, west), x=lon, y=lat, radius=1, col=c(alpha("orange", 0.6), alpha("blue", 0.6))))
}
map.scale(-50, 55, ratio=FALSE, relwidth=0.14, cex=1.5)
box()