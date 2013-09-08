

qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_6_f"

qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_3_f"

qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_4_f"


#this is a clumpp ind output file:
clumppfile <- "~/Documents/My_Documents/UBC/Research/ReproducibilityGroup/STRUCTURE/Reanalyses/ButterflyFish/CLUMPP_Output/WithPop/K2.indfile"

source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/ReadQ.R', chdir = TRUE)
source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/PlotQ.R', chdir = TRUE)

read.q(qfile)

read.q(clumppfile, clumpp=TRUE)


plot.bars(bars, type="quartz")

#now need to work on sizing the plot
#maybe change how population delinitation lines are drawn





plot.bars(bars, outfile="~/Desktop/sizetest.png", type="png", wd=1000, ht=400)





###################################################################################
## Plot structure results - can be used for CLUMPP output with some modification

## Function for resizing plot window (not essential here, but a useful function)
#resize.win <- function(Width=6, Height=6)  # works for windows
#{   dev.off(); # dev.new(width=6, height=6)
#    windows(record=TRUE, width=Width, height=Height)
#}
#windows(width=6, height=6)


## Select file
qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/GlobalData 2/GlobalData2/Results/GlobalData2_run_4_f"

qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_5_f"

qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_4_f"
qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_6_f"

qfile <- "~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_3_f"

#read.q <- function(qfile){
	## Read in Q and identify K
	qstart <- which(read.table(qfile,sep="\t",blank.lines.skip =F, stringsAsFactors=F)=="Inferred ancestry of individuals:")+1
	qend <- which(read.table(qfile,sep="\t",blank.lines.skip =F, stringsAsFactors=F)=="Estimated Allele Frequencies in each cluster")-3
	nind <- qend-qstart
	qall0 <- read.table(qfile, skip=qstart, nrows=nind, stringsAsFactors = FALSE, strip.white = TRUE, header=FALSE, na.strings = c("NA","",".","#DIV/0!","#REF!","#VALUE!","#NUM!"))
	qdatstr <- ":"
	selectedCols <- qall0[, grep(qdatstr, qall0)]  #find column with colons, after this column is the columns where the Q values are stored
	rawcolumn <- tail(names(selectedCols),1)
	column <- which(colnames(qall0)==rawcolumn)  #this is the column containing colons, add 1 to it in the next step for starting q values
	firstcol <- column+1 ## first column of Q estimates- this may need to be altereddepending on location data and/or labels included in the analysis
	k <- sum(sapply(firstcol:ncol(qall0),function(x){is.numeric(qall0[,x])}))
	## count assumed populations

	## Set up population sizes for labels
	qall <- qall0[order(qall0[,3]),]   ## you can sort them by population here (optional)
	qall$pops <- as.factor(qall[,3])
	popsizes0 <- table(qall$pops)
	popsizes <- popsizes0[order(match(levels(qall$pops),qall$pops))]

	#make matrix of q values for plotting
	bars <- t(as.matrix(qall[,(firstcol-1)+1:k])) #return transpose of matrix
	#return(as.matrix(bars))
#	dat <- bars
#	return(dat)
#}


# Barplots ala Structure/distruct
bars <- t(as.matrix(qall[,(firstcol-1)+1:k]))  #return transpose of matrix
#resize.win(8,3)

colors <- c("khaki", "darkblue", "steelblue2", "darkorange", "green4", "red2", "purple", "yellow")  ## Add more colors if K>6 and change these if you like
bw <- c("black", "gray95", "gray50", "gray25", "gray75", "gray40", "gray85")

#par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)


plot.bars <- function(bars, wid=1, sp=0, title="", bord=NA, color=colors)
{
	par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
	barplot(bars, width=wid, space=sp, names.arg=rep("",ncol(bars)), col=color, border=bord, main=title) #having things like "border=border" creates a recursive error
	par(lwd=1)
	par(new=T)
	barplot(popsizes/popsizes, width=popsizes, space=sp, col=NA)
}


#savePlot(filename = paste(qfile,".png",sep=""), type = "png",device = dev.cur(), restoreConsole = TRUE)
