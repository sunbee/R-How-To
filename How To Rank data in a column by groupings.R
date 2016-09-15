setwd('c:/users/ssbhat3/Desktop/R-How-To')
getwd()

library(data.table)
dt <- read.csv("Sales.csv")
DT <- as.data.table(dt)

DT[, mean(Sales), by=Month]
DT[, mrank := rank(-Sales), by=Month]
