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

bmap <- function(dat, col="gray90", fill=TRUE, axes=FALSE, xlab="", ylab="", main="", usstates=FALSE, zoom=0.005)#, ...)  #increasing zoom increases the amount of map space plotted
{
	xlim <- c(range(dat$lon)[1]+range(dat$lon)[1]*zoom, range(dat$lon)[2]-range(dat$lon)[2]*zoom)  ## NEED TO PUT IF STATEMENTS IN HERE FOR DATA THAT IS NOT IN N.AMERICA, because their longitudes in europe will be positive, or latitude in southern hemisphere negative
	ylim <- c(range(dat$lat)[1]-range(dat$lat)[1]*zoom, range(dat$lat)[2]+range(dat$lat)[2]*zoom)
    #plot map
    map("world", xlim = xlim, ylim = ylim, col=col, fill=fill)
    if(usstates==TRUE){map("state", add=TRUE, col=col, fill=fill)}
    box()
}



### plot points

map.pie <- function(dat, labels="", zoom=0.01){  #adjust zoom to make nonscaled points larger or smaller
	iterate <- seq_along(dat$lat)
	i <- 0
	for(i in iterate){
		slice1 <- dat[i, which(colnames(dat)=="c1")]
		slice2 <- dat[i, which(colnames(dat)=="c2")]
		#if()  #if there are more than 2 slices, plot them also
		total <- dat[i, dat[i, which(colnames(dat)=="tot")]]
		if(abs(range(dat$lon)[1]-range(dat$lon)[2]) > abs(range(dat$lat)[1]-range(dat$lat)[2])){r <- zoom*abs(range(dat$lon)[1]-range(dat$lon)[2])}else{r <- zoom*abs(range(dat$lat)[1]-range(dat$lat)[2])}
		latitude <- dat[i, which(colnames(dat)=="lat")]
		longitude <- dat[i, which(colnames(dat)=="lon")]
		z <- c(slice1, slice2)  #work this out for multiple slices
		cols <- c("orange", "blue")  #work this out for multiple colors
		#put it all together and plot:
		add.pie(z=z, x=longitude, y=latitude, radius=r, col= cols, labels=labels)
	}
}














## OLD STUFF BELOW
gps <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/MAPS/latifolia_cpDNA_data.csv")



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



#should try to get an apply funtion to work, but can't remember how to do it right now.  it would likely be better than a loop!!
pie <- function(dat, scaled, col, z){
	apply(dat, FUN=add.pie, MARGIN=1)
	
}


pie <- apply(function(dat){
	dat, FUN=add.pie(z=c(dat$c1,dat$c2), x=dat$lon, y=dat$lat, radius=dat$tot, col=c("orange", "blue"), labels="")
})

#MARGIN 1 = rows, 2 = columns



