## builds strongly off of 'mapplots' package, but now incorporates more general worldwide mapping abilities by combining with existing mapdata

library(maps)
library(mapdata)
library(maptools)
library(mapplots)
library(scales)



#dummy data

#my field data, smaller geographic area
dat1 <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_1.csv")
dat11 <- read.table("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_1.txt", header=TRUE)  #need the header specifier unlike the default for reading .csv

#illingworth field data, larger geographic area
dat2 <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_2.csv")
dat22 <- read.table("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_2.txt", header=TRUE)
## NOTE - must not have spaces in column names! otherwise text file messes up, while .csv doesn't





# # # # # # # # # #         MAKE THE MAP        # # # # # # # # # # # # # # #

basemap(xlim=range(dat1$lon), ylim=range(dat1$lat))
map("world", add=TRUE)


## EDIT THE BASEMAP FUNCTION FROM mapplots

extent.map <- function(dat, bg = "white", col="gray90", fill=TRUE, axes=FALSE, xlab="", ylab="", main="", usstates=FALSE)#, ...)
{
	xlim <- range(dat$lon)
	ylim <- range(dat$lat)
	asp <- 1/cos(sum(ylim) * pi/360)
    plot(NA, xlim = xlim, ylim = ylim, asp = asp, axes=axes, xlab=xlab, ylab=ylab, main=main)#, ...)
    rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col = bg)
    #add world map plotted on top
    map("world", add=TRUE, col=col, fill=fill)
    if(usstates==TRUE){map("state", add=TRUE, col=col, fill=fill)}
    box()
}
## NEED TO FIGURE OUT HOW TO LEAVE THE ... in there, it calls standard options from base graphics
#the above map extent changes based on resizing of quartz window; might be okay once I figure out how to export to file, but try something else for now below





### just plot a map based on lat/lon in file

bmap <- function(dat, col="gray90", fill=TRUE, axes=FALSE, xlab="", ylab="", main="", usstates=FALSE)#, ...)
{
	xlim <- range(dat$lon)
	ylim <- range(dat$lat)
    #plot map
    map("world", xlim = xlim, ylim = ylim, col=col, fill=fill)
    if(usstates==TRUE){map("state", add=TRUE, col=col, fill=fill)}
    box()
}











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