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

# Overlay infomration by grouping - time-series plot
library(nlme)
?Oxboys
ggplot(Oxboys, aes(age, height)) + 
  geom_point()
ggplot(Oxboys, aes(age, height)) + 
  geom_line()
ggplot(Oxboys, aes(age, height, group=Subject)) +
  geom_line()

# Overlay information
jean <- read.csv("http://www.ling.upenn.edu/~joseff/data/jean2.csv")
ay <- subset(jean, VClass %in% c("ay", "ay0"))
ay$VClass <- as.factor(as.character(ay$VClass))
# Reshape data
library(reshape2)
ay.m <- melt(ay, id=c("Time", "RTime", "Word", "VClass"),
             measure=c("F1", "F2"))
# Overlay information - VClass (ay, ay0) and variable (F1, F2)
ggplot(ay.m, aes(RTime, value, color=VClass, linetype=variable)) +
  geom_line()
# Change: Plot each word. This mixes groups :(
ggplot(ay.m, aes(RTime, value, color=VClass, group=Word)) +
  geom_line()
# Change: Represent each word in two categories (F1, F2) by same lty using interaction
ggplot(ay.m, aes(RTime, value, color=VClass, linetype=Word:variable)) +
  geom_line()
# Alt. 
ggplot(ay.m, aes(RTime, value, color=VClass, group=Word:variable)) +
  geom_line()

# Overlay information
# Set up data
phil <- structure(list(Name = structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 
                                          3L, 3L, 3L, 3L, 3L, 3L, 3L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L), 
                                        .Label = c("Bucks County", "Delaware County", "Montgomery County", "Philadelphia County"), class = "factor"), 
                       Gender = structure(c(1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 
                                          2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L),
                                        .Label = c("Female", "Male"), class = "factor"), 
                       value = c(15288L, 43054L, 25788L, 62853L, 33622L, 50792L, 
                                 27184L, 71321L, 43593L, 94877L, 32442L, 54872L, 43751L, 18346L, 
                                 25545L, 87732L, 46656L, 63640L, 39675L, 25468L, 43636L, 34558L, 
                                 59923L, 26979L, 17550L, 27492L, 71404L, 39946L, 50107L, 96580L, 
                                 24957L, 17433L, 31468L, 40585L, 53239L, 21899L, 62542L, 38352L, 
                                 47008L, 31485L), 
                       Level = structure(c(1L, 4L, 2L, 5L, 3L, 3L, 1L, 4L, 2L, 5L, 3L, 5L, 4L, 1L, 2L, 5L, 3L, 4L, 2L, 1L,
                                           4L, 3L, 5L, 2L, 1L, 1L, 4L, 2L, 3L, 5L, 2L, 1L, 3L, 4L, 5L, 1L, 5L, 3L, 4L, 2L), 
                                        .Label = c("LessHigh", "High", "SomeAssoc", "Bachelors", "GradProf"), class = "factor")), 
                                        .Names = c("Name", "Gender", "value", "Level"), 
                                        class = "data.frame", 
                                        row.names = c(3463L, 3465L, 3466L, 3467L, 3468L, 3471L, 3473L, 3475L, 3478L, 3479L, 8741L, 8742L, 8743L, 8746L, 8750L, 8751L, 8752L, 8754L, 8756L, 
                                                      8757L, 22925L, 22926L, 22927L, 22928L, 22929L, 22933L, 22937L, 22938L, 22939L, 22940L, 25844L, 25845L, 25846L, 25847L, 25849L, 
                                                      25854L, 25855L, 25856L, 25858L, 25860L))

ggplot(phil, aes(Level, value, color=Name, shape=Gender)) +
  geom_point() +
  geom_line()
# Group - by county (Name)
ggplot(phil, aes(Level, value, color=Name, shape=Gender, group=Name)) +
  geom_point() + 
  geom_line()
# Group - by gender in each county (Name:Gender)
ggplot(phil, aes(Level, value, color=Name, shape=Gender, group=Name:Gender)) + 
  geom_point() + 
  geom_line()
# Alt.
ggplot(phil, aes(Level, value, color=Name, linetype=Gender, group=Name:Gender)) + 
  geom_point() +
  geom_line()

# Overlay information
philcit <- subset(phil, Name=="Philadelphia County")
# Overlay - stack
ggplot(philcit, aes(Level, value, fill=Gender)) + 
  geom_bar(stat="identity", position="stack")
# Overlay - dodge
ggplot(philcit, aes(Level, value, fill=Gender)) + 
  geom_bar(stat="identity", position="dodge")
# Overlay - fill
ggplot(philcit, aes(Level, value, fill=Gender)) + 
  geom_bar(stat="identity", position="fill")
# Overlay - identity
ggplot(philcit, aes(Level, value, fill="Gender")) + 
  geom_bar(stat="identity", position="identity", alpha=0.3)

# Overlay - stack, dodge, etc
ggplot(ay, aes(F1, fill=VClass)) +
  stat_density(aes(y = ..count..), position="stack", color="black")
ggplot(ay, aes(F1, fill=VClass)) + 
  stat_density(aes(y = ..count..), position="fill", color="black")
ggplot(ay, aes(F1, fill=VClass)) + 
  stat_density(aes(y = ..density..), position="identity", color="black", alpha=0.5)
ggplot(jean, aes(-F2, reorder(VClass, -F2, mean))) + 
  geom_point(position="jitter", alpha=0.3)
ggplot(jean, aes(reorder(VClass, -F1, mean), -F1)) +
  geom_point(position="jitter", alpha=0.5)
ggplot(jean, aes(reorder(VClass, -F1, mean), -F1)) +
  geom_point(position="jitter", alpha=0.5) + 
  geom_boxplot(alpha=0.9)

# Overlay - points, model
donner <- read.csv("http://www.ling.upenn.edu/~joseff/data/donner.csv")
ggplot(donner, aes(AGE, NFATE, color=GENDER)) +
  geom_point(position=position_jitter(height=0.02, width=0)) + 
  stat_smooth(method="glm", family="binomial", formula = y~poly(x,2))

# Make multiple plots
# Each facet is one instance of a categorical variable
ggplot(mpg, aes(displ, hwy)) +
  geom_point() + 
  geom_smooth() + 
  facet_wrap(~year)
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  facet_wrap(~ manufacturer)
# Each facet is one combination of two variables
?tips
library(reshape2)
ggplot(tips, aes(size, tip/total_bill)) + 
  geom_point(position=position_jitter(width=0.2, height=0)) + 
  facet_grid(time ~ sex)
# Decorate - change scales
ggplot(data=gender.comp, aes(Male, Female)) + 
  geom_abline(color="grey80") + 
  geom_point(alpha=0.6) + 
  facet_grid(~ Measure, scales="free")
ggplot(mtcars, aes(mpg, wt)) + 
  geom_point() +
  facet_grid(am ~ vs, scales="free_x")
ggplot(mtcars, aes(mpg, wt)) + 
  geom_point() +
  facet_wrap(am ~ vs, scales="free_x")

