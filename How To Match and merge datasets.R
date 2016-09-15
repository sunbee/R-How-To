setwd('c/users/ssbhat3/Desktop/R-How-To')
getwd()

library(data.table)
PDR <- as.data.table(read.csv("PDRatings.csv"));
PDT <- as.data.table(read.csv("PDTable.csv"));

PDTm <- melt.data.table(PDT, id.vars=c("PD_month"), 
                        variable.name = "PDRating",
                        value.name = "PD")

PDTm[, PDRating := sub("X", "", PDRating)]      # X6    becomes 6
PDTm[, PDRating := sub("5.", "5+", PDRating)]   # 5.    becomes 5+
PDTm[, PDRating := sub("6.$", "6-", PDRating)]  # 6.    becomes 6-
PDTm[, PDRating := sub("7.$", "7-", PDRating)]  # 7.    becomes 7-
PDTm[, PDRating := sub("6..1", "6+", PDRating)] # 6..1  becomes 6+
PDTm

setkey(PDR, PDRating, PD_month)
setkey(PDTm, PDRating, PD_month)

merge(PDR, PDTm, all.x=TRUE)
