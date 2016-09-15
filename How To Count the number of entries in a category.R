set.seed(1)
mydf <- data.frame(
  Cnty = rep(c("185", "31", "189"), times = c(5, 3, 2)),
  Yr = c(rep(c("1999", "2000"), times = c(3, 2)), 
         "1999", "1999", "2000", "2000", "2000"),
  Plt = "20001",
  Spp = sample(c("Bitternut", "Pignut", "WO"), 10, replace = TRUE),
  DBH = runif(10, 0, 15)
)
mydf

library(data.table)
myDT <- as.data.table(mydf)

myDT[, .N, by=c("Spp", "Cnty")]
