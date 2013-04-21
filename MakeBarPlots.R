


###################################################################################
## Plot structure results - can be used for CLUMPP output with some modification

## Function for resizing plot window (not essential here, but a useful function)
#resize.win <- function(Width=6, Height=6)  # works for windows
#{   dev.off(); # dev.new(width=6, height=6)
#    windows(record=TRUE, width=Width, height=Height)
#}
#windows(width=6, height=6)

## Set working directory
#setwd("../colbeck.locprior0.AdmCorr10k100k/")   # file path of STRUCTURE results
## Select file
qfile="~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/GlobalData 2/GlobalData2/Results/GlobalData2_run_4_f"

qfile="~/Documents/My_Documents/Taylor_Lab/Data/My Data/Structure/Results/GlobalData_WithSAMS1_11092010_run_5_f"




## Read in Q and identify K
qstart=which(read.table(qfile,sep="\t",blank.lines.skip =F, stringsAsFactors=F)=="Inferred ancestry of individuals:")+1
qend=which(read.table(qfile,sep="\t",blank.lines.skip =F, stringsAsFactors=F)=="Estimated Allele Frequencies in each cluster")-3
nind=qend-qstart
qall0<-read.table(qfile, skip=qstart, nrows=nind, stringsAsFactors = FALSE, strip.white = TRUE, header=FALSE, na.strings = c("NA","",".","#DIV/0!","#REF!","#VALUE!","#NUM!"))
head(qall0)
firstcol=6 ## first column of Q estimates- this may need to be altereddepending on location data and/or labels included in the analysis
k=sum(sapply(firstcol:ncol(qall0),function(x){is.numeric(qall0[,x])}))
## count assumed populations

## Set up population sizes for labels
qall=qall0[order(qall0[,3]),]   ## you can sort them by population here (optional)
qall$pops=as.factor(qall[,3])
popsizes0=table(qall$pops)
popsizes=popsizes0[order(match(levels(qall$pops),qall$pops))]

# Stacked Bar Plot with Colours
bars=t(as.matrix(qall[,(firstcol-1)+1:k]))
resize.win(8,3)
colours=c("blue","green","red","yellow","pink","purple")  ## Add more colours if K>6 and change these if you like
par(fig=c(0,1,0,1),mar=c(2,2,1,1),oma=c(1,0.5,0.5,0.5),xaxs="i",yaxs="i",bg=NA)
barplot(bars, width = 1, space = 0, names.arg = rep("",ncol(bars)), legend.text = NULL, beside = FALSE,
        horiz = FALSE, density = NULL, angle = 45,
        col = colours, border = NA,
        main = NULL, sub = NULL, xlab = NULL, ylab = NULL,
        xlim = NULL, ylim = NULL, xpd = TRUE, log = "",
        axes = TRUE, axisnames = TRUE,
        cex.axis = par("cex.axis"), cex.names = par("cex.axis"),
#        inside = TRUE, plot = TRUE, axis.lty = 0, offset = 0,
        add = FALSE, args.legend = NULL)
par(lwd=1)
par(new=T)
barplot(popsizes/popsizes,width=popsizes,space=0,col=NA)
#savePlot(filename = paste(qfile,".png",sep=""), type = "png",device = dev.cur(), restoreConsole = TRUE)
