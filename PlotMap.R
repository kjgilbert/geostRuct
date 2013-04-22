library(maps)
library(mapdata)
library(maptools)



### just plot a map based on lat/lon in file

plot.map <- function(dat, col="gray90", fill=TRUE, axes=FALSE, xlab="", ylab="", main="", usstates=FALSE, zoom=0.005)#, ...)  #increasing zoom increases the amount of map space plotted
{
	xlim <- c(range(dat$lon)[1]+range(dat$lon)[1]*zoom, range(dat$lon)[2]-range(dat$lon)[2]*zoom)  ## NEED TO PUT IF STATEMENTS IN HERE FOR DATA THAT IS NOT IN N.AMERICA, because their longitudes in europe will be positive, or latitude in southern hemisphere negative
	ylim <- c(range(dat$lat)[1]-range(dat$lat)[1]*zoom, range(dat$lat)[2]+range(dat$lat)[2]*zoom)
    #plot map
    map("world", xlim = xlim, ylim = ylim, col=col, fill=fill)
    if(usstates==TRUE){map("state", add=TRUE, col=col, fill=fill)}
    box()
}