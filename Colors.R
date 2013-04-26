
#default color palettes





#these currently set up to work with bar plots, can probably be made to use with pie charts
colors <- c("khaki", "darkblue", "steelblue2", "darkorange", "green4", "red2", "purple", "yellow")
	#can add more colors if k>8, or can alter defaults as desired
bw <- c("black", "gray95", "gray50", "gray25", "gray75", "gray40", "gray85")
	#black and white color palette option


#make a set of transparent colors as well:
library(scales)
tcolors <- alpha(colors, alpha=0.5)
tbw <- alpha(bw, alpha=0.5)