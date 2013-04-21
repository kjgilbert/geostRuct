
#dummy data
dat <- read.csv("")


library(maps)
library(mapdata)
library(maptools)
library(mapplots)


library(shapefiles) 
shp.file <- file.path(system.file(package = "mapplots", "extdata"), "Ireland")
 irl <- read.shapefile(shp.file)
  xlim <- c(-11,-5.5) 
  ylim <- c(51.5,55.5)
   basemap(xlim, ylim) 
draw.shape(irl, col='cornsilk')


### draw.pie example
data(landings)
data(coast)
xlim <- c(-12,-5)
ylim <- c(50,56)
xyz <- make.xyz(landings$Lon,landings$Lat,landings$LiveWeight,landings$Species)
col <- rainbow(5)
basemap(xlim, ylim, main = 'Species composition of gadoid landings')
draw.shape(coast, col='cornsilk')
draw.pie(xyz$x, xyz$y, xyz$z, radius = 0.3, col=col)
legend.pie(-13.25,54.8,labels=c('cod','had','hke','pok','whg'), radius=0.3, bty='n', col=col,
 cex=0.8, label.dist=1.3)
legend.z <- round(max(rowSums(xyz$z,na.rm=TRUE))/10^6,0)
legend.bubble(-13.25,55.5,z=legend.z,round=1,maxradius=0.3,bty='n',txt.cex=0.6)
text(-13.25,56,'landings (kt)',cex=0.8) 


### add.pie example
plot(NA,NA, xlim=c(-1,1), ylim=c(-1,1) )
add.pie(z=rpois(6,10), x=-0.5, y=0.5, radius=0.5)
add.pie(z=rpois(4,10), x=0.5, y=-0.5, radius=0.3)