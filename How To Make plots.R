# HOW TO: Make plots in R

# Line Charts

# Line Charts - Basic
#q How to plot a sequence of numbers?
cars <- c(1, 3, 6, 4, 9)
#a Plot data
plot(cars)
#c Use the basic plot command with a sequence of numbers.

#q Reference the basic plot. 
#q ADD a line.
#q CHaNGE the color the plot color to blue.
#a 
plot(cars, type="o", col="blue")
#c Pass parameters - type and col
#c Ref: ?par

#q Refer the plot. (Cont'd)
#q ANNOTATE with title.
#a
title(main="Autos", col.main="red", font.main=4)
#c Use: title()
#c Accepts parameters - main, col.main, font.main
#c Note how the attributes of the title are accessed.

# Overlay Data
#q Refer the plot.
#q Plot cars
#q ADD a line for trucks - dashed, red, square points
cars <- c(1, 3, 6, 4, 9)
trucks <- c(2, 5, 4, 5, 12)
#a 
plot(cars, type="o", col="blue", ylim=c(0,12))
lines(trucks, type="o", pch=22, lty=2, col="red")
#c Use: lines()
#c Ref: ?par
#c Note: Where have we used 'col' before?

#q Refer the plot. (Cont'd)
#q ANNOTATE with title
#a
title(main="Autos", col.main="red", font.main=4)
#c Use: title()
#c Accepts parameters - main, col.main, font.main
#c Note how the attributes of the title are accessed.

# Build plot - axes, box, legend
#q Plot data - and nothing else!
#q Specify the range of the ordinates (y-axis) based on the data for trucks.
cars <- c(1, 3, 6, 4, 9)
trucks <- c(2, 5, 4, 5, 12)
g_range <- range(0, cars, trucks)
#a Plot - turn off axes and annotation
plot(cars, type="o", col="blue", ylim=g_range, 
     axes=FALSE, ann=FALSE)
#c Set axis limits for the ordinates using 'ylim'.
#c Ref: ?par
#c Note that nothing is shown except the plot data.

#q Refer the plot. (Cont'd)
#q ADD a line for trucks - dashed, red, square points
#a
lines(trucks, type="o", pch=22, lty=2, col="red")
#c Use: lines()
#c Ref: ?par

#q Refer the plot. (Cont'd)
#q Decorate - add the axis for ordinates.
#q Set labels for the days of the week (5 weekdays).
#a
axis(1, at=1:5, labels=c("Mon", "Tue", "Wed", "Thu", "Fri"))
#c Use: axis()
#c Ref: ?axis

#q Refer the plot. (Cont'd)
#q Decorate - add the axis of abscissae.
#q Set labels spaced by 4. 
#a
axis(2, las=1, at=4*0:g_range[2])
#c Use: axis()
#c Ref: ?axis
#c Ref: ?par
#c Note the syntax for spacing axis ticks.
#c Note the style of axis labels set with 'las'.

#q Refer the plot. (Cont'd)
#q Decorate - add the box to demarcate the plot area
#a
box()
#c Use: box()

#q Refer the plot. (Cont'd)
#q ANNOTATE with title and axis labels.
title(main="Autos", col.main="red", font.main=4)
title(xlab="Days", col.lab=rgb(0, 0.5, 0))
#q Annotate - label the axis for ordinates 
#a
title(ylab="Total", col.lab=rgb(0, 0.5, 0))
#c Use: title()
#c Note the use of 'xlab' and 'ylab' for labeling axes.
#c Ref: ?par
#c Note how attributes of axis labels are accessed.

#q Refer the plot. (Cont'd)
#q ANNOTATE with legend.
#a
legend(1, g_range[2], c("cars", "trucks"), cex=0.8,
       col=c("blue", "red"), pch=21:22, lty=1:2)
#c Use: legend()
#c Note that there are no checks built-in that assure consistency of legend with plotted data.
#c Note that the legend accepts specifications as vectors.

# Abstract plot decoration 
#q Abstract out colors in a vector for consistency between plotted data and legend. 
#q How will you do it?
#q Data are:
suvs <- c(4, 4, 6, 6, 16)
autos_data <- data.frame(cars =cars, trucks=trucks, suvs=suvs)
#q Use colors - 'blue', 'red', 'forestgreen'
plot_colors <- c("blue", "red", "forestgreen")
#q Code is

# Ans: PULLING IT ALL TOGETHER
#1 Condition data
max_y <- max(autos_data)
#2 Plot - minus axes and annotation
plot(autos_data$cars, type="o", col=plot_colors[1],
     ylim=c(0, max_y), axes=FALSE, ann=FALSE)
#2 OVERLAY data
lines(autos_data$trucks, type="o", pch=22, lty=2, col=plot_colors[2])
lines(autos_data$suvs, type="o", pch=23, lty=3, col=plot_colors[3])
#3 DECORATE - add axes and box
axis(1, at=1:5, lab=c("Mon", "Tue", "Wed", "Thu", "Fri"))
axis(2, las=1, at=4*0:max_y)
box()
# Annotate - add title
title(main="Autos", col.main="red", font.main=4)
title(xlab="Days", col=rgb(0, 0.5, 0), cex.lab=0.8)
title(ylab="Total", col=rgb(0, 0.5, 0), cex.lab=0.8)
# Annotate - add legend
legend(1, max_y, names(autos_data), cex=0.8, col=plot_colors, 
       pch=21:23, lty=1:3)
  
# Decorate 
#q Refer: 'autos_data'
#q Refer: R margins 
#q http://research.stowers-institute.org/efg/R/Graphics/Basics/mar-oma/
#q Trim excess margin space from default settings.
#q Default: 
      old_mar <- par()$mar
#q Trim: 
      new_mar <- c(4.2, 3.8, 0.2, 0.2)
#q Do it how?
#a
par(mar=new_mar)
#c A figure has a margin enclosing the plot area on all sides.
#c The margin typically houses - axis ticks, tick labels, axis labels, title
#c Ref: ?par
#c Note the way to access margin settings with 'mar'.
#c Note: Reset with old_mar

#q Refer the plot. (Cont'd)
#q Plot the data for cars as follows
#q  Plot a line
#q  Color it blue (1st element of the array 'plot_colors')
#q  Set appropriate axis limits for ordinates
#q  Switch off axes and keep annotation
#q  Label the abscissa 'Days'
#q  Label the ordinate 'Total'
#q  Scale label fonts to 0.8
#q  Set line width to 2
plot_colors<- c(rgb(r=0, g=0, b=0.9), "red", "forestgreen")
#a
plot(autos_data$cars, type="l", col=plot_colors[1])
plot(autos_data$cars, type="l", col=plot_colors[1], ylim=range(autos_data))
plot(autos_data$cars, type="l", col=plot_colors[1], ylim=range(autos_data), axes=FALSE)
plot(autos_data$cars, type="l", col=plot_colors[1], ylim=range(autos_data), axes=FALSE, ann=F)
plot(autos_data$cars, type="l", col=plot_colors[1], ylim=range(autos_data), axes=FALSE, 
     xlab="Days", ylab="Total")
plot(autos_data$cars, type="l", col=plot_colors[1], ylim=range(autos_data), axes=FALSE, 
     xlab="Days", ylab="Total", cex.lab=0.8, lwd=2)
#c Shows plot construction in steps,  adding a new layer of information or decoration every time.
#c Ref: ?par
#c Note how attributes of plot elements are set 
#c    axis (limits, label color, label font size) 
#c    plotted data (style - shape, thickness)

#q Refer the plot. (Cont'd)
#q Decorate - add axis tick labels for abscissae at 45 degrees slant
#q These are the days of the week
axis(1, labels=FALSE)
days=c("Mon", "Tue", "Wed", "Thu", "Fri")
#a
text(axTicks(1), par("usr")[3]-2, srt=45, labels=days, xpd=T, cex=0.8)
#c Use: text() 
#c Insert annotation in the margins, as follows.
#c  x coordinates - use tick mark locations, computed with 'axTicks()' 
#c  y coordinate - go two lines below the box, computed with 'par("usr")'
#c  label - set the axis tick labels with 'labels' using data in 'days'
#c  angle - set the slant with 'srt'
#c  placement - clip to margins (outside plot area) with 'xpd'
#c Note the contrast with 'las' which is simpler and constrained to offer only 4 options.
#c Ref: ?par

#q Refer the plot. (Cont'd)
#q Decorate - add axis for ordinates and box to demarcate the plot area
#q  Orient the axis tick labels for ordinates as horizontal display
#q  Maintain consistency of font size among ordinates and abscissae 
#q  Add a box to demarcate plot area
#a  
axis(2, las=1, cex.axis=0.8)
box()
  
#q Refer the plot. (Cont'd)
#q Overlay data - trucks, suvs
#q Decorate - 
#q  Use thicker dashed line in red for trucks
#q  Use thicker dotted line in green for suvs
#a
lines(autos_data$trucks, type="l", col=plot_colors[2], lty=2, lwd=2)
lines(autos_data$suvs, type="l", col=plot_colors[3], lty=3, lwd=2)
#c Customize overlays
#c Ref: ?par
#c Note the means to specify line type and width

#q Refer the plot. (Cont'd)
#q Decorate - add legend
#q  Place it in the top-left corner
#q  Remove border
#q  Make font-size consistent with axis tick labels
#a
legend("topleft", names(autos_data), col=plot_colors, lty=1:3, cex=0.8, lwd=2, bty="n")
#c Use: legend()
#c Takes sets of 3 (recycled as needed)
#c  3 labels, with 'names()'
#c  3 colors, with 'plot_colors'
#c  3 line-types, with 'lty'
#c  3 line-widths, with 'lwd' (recycled)
#c Note the use of 'bty' to turn off the legend's border.

# Is it possible to access plot properties (par settings) via plot handle? Unit testing for plots. 

