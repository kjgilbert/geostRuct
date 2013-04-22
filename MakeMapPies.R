

#dummy data

#my field data, smaller geographic area
dat1 <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_1.csv")
dat11 <- read.table("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_1.txt", header=TRUE)  #need the header specifier unlike the default for reading .csv

#illingworth field data, larger geographic area
dat2 <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_2.csv")
dat22 <- read.table("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_2.txt", header=TRUE)
## NOTE - must not have spaces in column names! otherwise text file messes up, while .csv doesn't



#has more than 2 slices

##FORCE - titles of columns for slices must be s1 - sn...
dat3 <- read.csv("~/Documents/My_Documents/ProgrammingSoftware/R/Pie/DummyData_2.csv")




source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/PlotMap.R', chdir = TRUE)
source('~/Documents/My_Documents/ProgrammingSoftware/R/Pie/geostRuct/PlotPie.R', chdir = TRUE)




plot.map(dat3)

plot.pie(dat3, zoom=0.02, bord=FALSE)