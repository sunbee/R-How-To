# rm *.tmp

library("magrittr")
source("C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/MR/mapper.R")
source("C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/MR/reducer.R")

cat("data.txt") %>% emit %>% sort %>% reduce
