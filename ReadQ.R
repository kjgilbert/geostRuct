

## Read Q file in
read.q <- function(qfile, clumpp=FALSE){
	if(clumpp==TRUE){vals <- read.table(qfile)}else{ 
	#if we are using clumpp output directly, it is already formatted, so just skip down to determining K
# these steps read raw structure output
# the vals file created below is the same as the INDIVIDUAL output file from CLUMPP
	qstart <- which(read.table(qfile,sep="\t",blank.lines.skip =F, stringsAsFactors=F)=="Inferred ancestry of individuals:")+1
	qend <- which(read.table(qfile,sep="\t",blank.lines.skip =F, stringsAsFactors=F)=="Estimated Allele Frequencies in each cluster")-3
	nind <- qend-qstart
	vals <- read.table(qfile, skip=qstart, nrows=nind, stringsAsFactors = FALSE, strip.white = TRUE, header=FALSE, na.strings = c("NA","",".","#DIV/0!","#REF!","#VALUE!","#NUM!"))
	qdatstr <- ":"
	selectedCols <- vals[, grep(qdatstr, vals)]  #find column with colons, after this column is the columns where the Q values are stored
	rawcolumn <- tail(names(selectedCols),1)
	column <- which(colnames(vals)==rawcolumn)  #this is the column containing colons, add 1 to it in the next step for starting q values
	firstcol <- column+1
		#this column is where the q value data starts, preceding columns are identifiers of individuals and pops
	}


## Determine K
	k <- sum(sapply(firstcol:ncol(vals),function(x){is.numeric(vals[,x])}))

	#set up population sizes for labels
	q <- vals[order(vals[,3]),]   ## you can sort them by population here (optional)
	q$pops <- as.factor(q[,3])
	popsizes0 <- table(q$pops)
	popsizes <- popsizes0[order(match(levels(q$pops),q$pops))]

	#make matrix of q values for plotting
	bars <<- t(as.matrix(q[,(firstcol-1)+1:k])) #return transpose of matrix	
}