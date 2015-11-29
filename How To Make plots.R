# HOW TO: Make plots in R

# Line Charts

# Line Charts - Basic
# Set up data
cars <- c(1, 3, 6, 4, 9)
# Plot data
plot(cars)
# Plot data 
plot(cars, type="o", col="blue")
# Annotate - Add title
title(main="Autos", col.main="red", font.main=4)

# Line charts - overlays
# Set up data
trucks <- c(2, 5, 4, 5, 12)
# Plot data
plot(cars, type="o", col="blue", ylim=c(0,12))
# Overlay data
lines(trucks, type="o", pch=22, lty=2, col="red")
# Annotate - Add title
title(main="Autos", col.main="red", font.main=4)

# Line charts - legend
# Set up data
cars <- c(1, 3, 6, 4, 9)
trucks <- c(2, 5, 4, 5, 12)
# Condition data
g_range <- range(0, cars, trucks)
# Plot - turn off axes and annotation
plot(cars, type="o", col="blue", ylim=g_range, 
     axes=FALSE, ann=FALSE)
# Overlay data
lines(trucks, type="o", pch=22, lty=2, col="red")
# Decorate - customize axes, add box
axis(1, at=1:5, labels=c("Mon", "Tue", "Wed", "Thu", "Fri"))
axis(2, las=1, at=4*0:g_range[2])
# Add box around plot area
box()
# Annotate - Add title
title(main="Autos", col.main="red", font.main=4)
title(xlab="Days", col.lab=rgb(0, 0.5, 0))
title(ylab="Total", col.lab=rgb(0, 0.5, 0))

# Annotate - Add legend
legend(1, g_range[2], c("cars", "trucks"), cex=0.8,
       col=c("blue", "red"), pch=21:22, lty=1:2)

# Line charts - multi-layered
# Set up data
suvs <- c(4, 4, 6, 6, 16)
autos_data <- data.frame(cars =cars, trucks=trucks, suvs=suvs)
# Condition data
max_y <- max(autos_data)
# Plot - minus axes and annotation
plot(autos_data$cars, type="o", col="blue",
     ylim=c(0, max_y), axes=FALSE, ann=FALSE)
# Add overlays
lines(autos_data$trucks, type="o", pch=22, lty=2, col="green" )
lines(autos_data$suvs, type="o", pch=23, lty=3, col="red")
# Decorate - customize axes, add box
axis(1, at=1:5, lab=c("Mon", "Tue", "Wed", "Thu", "Fri"))
axis(2, las=1, at=4*0:max_y)
box()
# Annotate - Add title
title(main="Autos", col.main="red", font.main=4)
title(xlab="Days", col=rgb(0, 0.5, 0), cex.lab=0.8)
title(ylab="Total", col=rgb(0, 0.5, 0), cex.lab=0.8)
# Annotate - Add legend
legend(1, max_y, names(autos_data), cex=0.8, col=c("red", "green", "yellow"), 
       pch=21:23, lty=1:3)
