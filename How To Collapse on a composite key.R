setwd('c:/Users/ssbhat3/Desktop/R-How-To')
getwd()

library(data.table)
DT <- as.data.table(read.csv("Ensembl.csv"))

DT[, paste0(ALIAS, collapse="|"), by=c("ENSEMBL", "ENTREZID", "SYMBOL")]

