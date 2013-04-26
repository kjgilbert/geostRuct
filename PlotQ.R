
source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/Colors.R', chdir = TRUE)


#create a bar plot from data that has been read in


### THIS FILE NEEDS SOME WORK
### WANT TO BE ABLE TO PLACE BAR PLOTS ON A MAP

plot.bars <- function(bars, wid=1, sp=0, title="", bord=NA, color=colors, ax.lab=TRUE, outfile=NULL, type=c("pdf","tiff","png","jpeg"), wd=width, ht=height)
{
	if(is.null(outfile)){
	par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
	barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title) #having things like "border=border" creates a recursive error
	par(lwd=1)
	par(new=T)
	barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA, axisnames=ax.lab)
	}
	
	#plot to an output file if outfile gives a file path
	path <- outfile
	    type <- if (!missing(type)) 
        match.arg(type)
	if(type=="pdf"){
		pdf(sprintf(path), width=wd, height=ht)
		par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
		barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title)
		par(lwd=1)
		par(new=T)
		barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA, axisnames=ax.lab)
		dev.off()
	}
	if(type=="tiff"){
		tiff(sprintf(path), compression="none", units="px", width=wd, height=ht, res=100, antialias="none")
		par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
		barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title)
		par(lwd=1)
		par(new=T)
		barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA, axisnames=ax.lab)
		dev.off()
	}
	if(type=="png"){
		png(sprintf(path), width=wd, height=ht)
		par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
		barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title)
		par(lwd=1)
		par(new=T)
		barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA, axisnames=ax.lab)
		dev.off()
	}
	if(type=="jpeg"){
		jpeg(sprintf(path), width=wd, height=ht, quality=100)
		par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
		barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title)
		par(lwd=1)
		par(new=T)
		barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA, axisnames=ax.lab)
		dev.off()
	}
}


#remove x axis labels by saying 'ax.lab=FALSE' when running plot.bars function

