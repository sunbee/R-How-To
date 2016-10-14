setwd('c:/users/ssbhat3/desktop/r-how-to')
getwd()

library(data.table)
dt <- read.csv('french.csv')
DT <- as.data.table(dt)
DT[, idnat2 := ifelse(idbp %in% "foreign", "foreign", 
                  ifelse(idbp %in% c("colony", "overseas"), "overseas", "mainland" ))]
