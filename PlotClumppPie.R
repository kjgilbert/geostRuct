
#datafiles to test out the function
#popdat <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Distruct/ClumppOutput_Pop_K2_globalLatifolia.txt"
#gpsfile <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyGPS_popfileData.csv")

#make the map within this function
source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/PlotMap.R', chdir = TRUE)
#plot the pies within this function
source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/PlotPie.R', chdir = TRUE)
#colors
source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/Colors.R', chdir = TRUE)

clumpp.pie <- function(popfile, gpsfile, pie.map=TRUE){
	vals <- read.table(popfile)
	firstcol <- 2 # first column is always the IDs, 2nd up until penultimate is data
	lastcol <- length(vals)-1
	vals[,1] <- unlist(strsplit(as.character(vals$V1), ":"))  #need to deconcatenate the colons from the pop IDs
	vals[,1] <- as.integer(vals[,1])
	#rename data columns for if being plotted below
	ncols <- length(names(vals)[firstcol:lastcol])
	letter <- rep("s", ncols)
	number <- seq(1:ncols)
	cnames <- paste0(letter, number)
	names(vals)[firstcol:lastcol] <- cnames
	vals$tot <- rowSums(vals[,c(firstcol:lastcol)])
		
	names(gpsfile)[which(names(gpsfile)=="pop")] <- "V1" #rename "pop" column as V1 so that it matches CLUMPP column heading, all other column names will be retained.	#user must have a lat and lon column specified, other columns are fine
	
	dat <- merge(gpsfile, vals, by="V1")
	
	#if user wants a default map with pie charts spit out
	if(pie.map==TRUE){
		plot.map(dat)
		plot.pie(dat)
	}
	return(dat) #if user just wants the merged dataset back so that they can tweak the map and plotted points manually, the data is output (in both cases the merged data is output)
}

