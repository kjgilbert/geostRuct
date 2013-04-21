

#create a bar plot from data that has been read in


### THIS FILE NEEDS SOME WORK
### WANT TO BE ABLE TO PLACE BAR PLOTS ON A MAP

plot.bars <- function(bars, wid=1, sp=0, title="", bord=NA, color=colors)
{
	par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
	barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title) #having things like "border=border" creates a recursive error
	par(lwd=1)
	par(new=T)
	barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA)
}


