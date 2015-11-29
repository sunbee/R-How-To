# How To: Make cool plots

library(ggplot2)

# Set up data 
?mpg
summary(mpg)
# Plot data
p <- ggplot(mpg, aes(displ, hwy))
p + geom_point()

# Add overlay
p + geom_point() + geom_line()

# Overlay data to show more information
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_line(aes(color=factor(cyl)))

# Overlay data to show more information
ggplot(mpg, aes(displ, hwy, color=factor(cyl))) +
  geom_point() + 
  geom_line()

# Source data
source("https://www.ling.upenn.edu.~joseff/rstudy/data/coins.R")
coins <- structure(list(coin = structure(1:6, 
                  .Label = c("dollar", "half_dollar", "quarter", "dime", "nickel", "penny"), 
                  class = "factor"), 
                  value = c(1, 0.5, 0.25, 0.1, 0.05, 0.01), N = c(1, 0, 248, 868, 665, 1421), 
                  Mass.g = c(8.1, 11.34, 5.67, 2.268, 5, 2.5), 
                  Diameter.mm = c(26.5, 30.61, 24.26, 17.91, 21.21, 19.05), 
                  Thickness.mm = c(2, 2.15, 1.75, 1.35, 1.95, 1.55)), 
                  .Names = c("coin", "value", "N", "Mass.g", "Diameter.mm", "Thickness.mm"), 
                  row.names = c(NA, -6L), 
                  class = "data.frame")
summary(coins)
# Plot data - simple plot
ggplot(coins, aes(coin, value)) + 
  geom_point()
# Plot data - barplot
ggplot(coins, aes(coin, value)) + 
  geom_bar(stat="identity")
# Plot data - simple plot, custom mapping
ggplot(coins, aes(coin, value*N)) + 
  geom_point()
# Plot- barplot, custom mapping
ggplot(coins, aes(coin, value*N)) +
  geom_bar(stat="identity")
# Overlay data to show more information with color
ggplot(coins, aes(coin, value*N)) + 
  geom_bar(stat="identity", aes(fill=coin))
# Overlay data to show more information wih color
ggplot(coins, aes(coin, value*N)) + 
  geom_bar(stat="identity", aes(color=coin))

# Make a plot and show fitted model
p + geom_point() + geom_smooth()
p + geom_point() + geom_smooth(method="lm")
library(MASS)
p + geom_point() + geom_smooth(method="rlm")
# Or, equivalently
p + geom_point() + stat_smooth()
p + geom_point() + stat_smooth(method="lm")
p + geom_point() + stat_smooth(method="rlm")
# Or, customize further
p + geom_smooth() + stat_smooth(geom="ribbon", color="gray", alpha=0.45) 
# Add overlays - errorbars
p + stat_smooth(geom="point")
p + stat_smooth(geom="point") + stat_smooth(geom="errorbar")

# Stat and Geoms
# Fit a smooth line .. *_smooth()
p + geom_point(stat="smooth")
# Or equivalently
p + stat_smooth(geom="point")
# Try this
p + stat_smooth(geom="line") + stat_smooth(geom="errorbar")
p + geom_errorbar(stat="smooth") + geom_line(stat="smooth") 

p + geom_point(stat="smooth")

# Make a boxplot .. *_boxplot()
summary(mpg)
ggplot(mpg, aes(class, hwy)) + geom_boxplot()
# Or, equivalently
ggplot(mpg, aes(class, hwy)) + stat_boxplot()
ggplot(mpg, aes(class, hwy)) + stat_boxplot() + geom_point(aes(color="red", size=4))

# Statistical Transformation - stat_summary()
summary(diamonds)
ggplot(diamonds, aes(cut, price)) + stat_summary(fun.y=median, geom="point")
ggplot(diamonds, aes(cut, price)) + stat_summary(fun.y=median, geom="bar")
# Customize the transformation function
median.quartile <- function(x) {
  out <- quantile(x, probs=c(0.25, 0.5, 0.75))
  names(out) <- c("ymin", "y", "ymax")
  return(out)
}
ggplot(diamonds, aes(cut, price)) + stat_summary(fun.data=median.quartile, geom="pointrange")
# Or, choose from available methods
library("Hmisc")
ggplot(diamonds, aes(cut, price)) + stat_summary(fun.data = median_hilow, conf.int=0.5 )

# Overlay data to show more information - confidence intervals
ggplot(mpg, aes(reorder(class, hwy, mean), hwy)) + 
  stat_summary(fun.y=mean, geom="bar") +
  stat_summary(fun.data=mean_cl_boot, geom="pointrange")

# Overlay information by grouping
# Group by color 
ggplot(mpg, aes(displ, hwy, color=factor(cyl))) + 
  geom_point() + 
  stat_smooth(method="lm")
# Group by shape
ggplot(mpg, aes(displ, hwy, shape=factor(cyl))) + 
  geom_point() +
  stat_smooth(method="lm")
# Group by size
ggplot(mpg, aes(displ, hwy, size=factor(cyl))) + 
  geom_point() + 
  stat_smooth(method="lm")
# Group by two variables
ggplot(mpg, aes(displ, hwy, color=factor(cyl), shape=factor(year), linetype=factor(year))) + 
  geom_point() + 
  geom_smooth(method="lm")

# Overlay information by grouping - boxplot
ggplot(mpg, aes(reorder(class, hwy, median), hwy, fill=factor(year))) + 
  geom_boxplot()

# Overlay infomration by grouping - line plot
library(nlme)
?Oxboys
ggplot(Oxboys, aes(age, height)) + 
  geom_point()
ggplot(Oxboys, aes(age, height)) + 
  geom_line()
ggplot(Oxboys, aes(age, height, group=Subject)) +
  geom_line()


  