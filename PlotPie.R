
dat <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_2.csv")



library(mapplots)
library(scales)

source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/Colors.R', chdir = TRUE)


### plot points

plot.pie <- function(dat, labels="", zoom=0.01, color=colors, bord=TRUE, scale=FALSE){  
	#adjust zoom to make nonscaled points larger or smaller
	#can call 'colors' or 'bw' to use default color settings
	
	#how many slices (i.e. clusters) will be drawn:
	selectedCols <- dat[, grep("s", names(dat))]  #find column with colons, after this column is the columns where the Q values are stored
	numslices <- length(selectedCols)
	
	iterate <- seq_along(dat$lat)
	i <- 0
	for(i in iterate){
	#only set up currently for 10 slices at most
		slice1 <- dat[i, which(colnames(dat)=="s1")]
		if(numslices>1){slice2 <- dat[i, which(colnames(dat)=="s2")]
			if(numslices>2){slice3 <- dat[i, which(colnames(dat)=="s3")]
				if(numslices>3){slice4 <- dat[i, which(colnames(dat)=="s4")]
					if(numslices>4){slice5 <- dat[i, which(colnames(dat)=="s5")]
						if(numslices>5){slice6 <- dat[i, which(colnames(dat)=="s6")]
							if(numslices>6){slice7 <- dat[i, which(colnames(dat)=="s7")]
								if(numslices>7){slice8 <- dat[i, which(colnames(dat)=="s8")]
									if(numslices>8){slice9 <- dat[i, which(colnames(dat)=="s9")]	
										if(numslices>9){slice10 <- dat[i, which(colnames(dat)=="s10")]
										}else{slice10 <- 0}
									}else{slice9 <- 0; slice10 <-0}
								}else{slice8 <- 0; slice9 <-0; slice10 <-0}
							}else{slice7 <- 0; slice8 <-0; slice9 <-0; slice10 <-0}			
						}else{slice6 <- 0; slice7 <-0; slice8 <-0; slice9 <-0; slice10 <-0}
					}else{slice5 <- 0; slice6 <-0; slice7 <-0; slice8 <-0; slice9 <-0; slice10 <-0}
				}else{slice4 <-0; slice5 <-0; slice6 <-0; slice7 <-0; slice8 <-0; slice9 <-0; slice10 <-0}
			}else{slice3 <-0; slice4 <-0; slice5 <-0; slice6 <-0; slice7 <-0; slice8 <-0; slice9 <-0; slice10 <-0}
		}else{slice2 <-0; slice3 <-0; slice4 <-0; slice5 <-0; slice6 <-0; slice7 <-0; slice8 <-0; slice9 <-0; slice10 <-0}
		#end if statements for number of slices/clusters being plotted
		
		total <- dat[i, dat[i, which(colnames(dat)=="tot")]]
		
	#determine size of points - r specifies radius
	#if no size scaling:
	if(scale==FALSE){
		if(abs(range(dat$lon)[1]-range(dat$lon)[2]) > abs(range(dat$lat)[1]-range(dat$lat)[2])){r <- zoom*abs(range(dat$lon)[1]-range(dat$lon)[2])}else{r <- zoom*abs(range(dat$lat)[1]-range(dat$lat)[2])}
	}
	#if scaled by pop/sample size:
	if(scale==TRUE){
		r <- zoom*dat[i, which(colnames(dat)=="tot")]
	}	
		#location of plotting points:
		latitude <- dat[i, which(colnames(dat)=="lat")]
		longitude <- dat[i, which(colnames(dat)=="lon")]
		
		#areas of each slice of the pie
		z <- c(slice1, slice2, slice3, slice4, slice5, slice6, slice7, slice8, slice9, slice10)  
			#doubtful that anyone will ever need more than 10 slices
		cols <- color
		
		#put it all together and plot:
		add.pie(z=z, x=longitude, y=latitude, radius=r, col= cols, labels=labels, border=bord, lwd=0.5)
	} #end for loop
} #end function




