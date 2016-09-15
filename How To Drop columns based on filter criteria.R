setwd('c:/users/ssbhat3/desktop/R-How-To');
dt <- read.csv("sampleNA.csv")
library(data.table)

DT <- data.table(dt)
DT[, .N, is.na(Var2)]
DT[, sum(is.na(Var2))/length(Var2)]

Theta = 0.3
Drop <- DT[, lapply(.SD, function (x) {sum(is.na(x))/length(x) > Theta} ), .SDcols = 2:4]
Cols.2.Drop <- names(Drop)[which(Drop==TRUE)]
Cols.2.Drop <- "Var2"
DT[, (Cols.2.Drop) := NULL]
