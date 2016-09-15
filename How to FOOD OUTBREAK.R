setwd('C:/Users/ssbhat3/Desktop/R-How-To')
getwd()

library(data.table)
library(ggplot2)
library(Hmisc)

DTfood <- data.table(read.csv("FoodData.csv"))

# NEW WAY
breaks <- c(0, seq(9, 99, by=10), c(149, 199, 249, 299))
DTnoro <- DTfood[, .(Genus.Species, Int = cut2(Illnesses, breaks))][grepl("Norov", Genus.Species), 
                                                          ][, .(Cnt = .N), by = Int]
DTnoro[order(Int)]
DTnoro[, sum(Cnt[as.integer(Int) > 9])/sum(Cnt)]
DTnoro[, {
  g <- ggplot(.SD, aes(x=Int, y=Cnt))
  g + geom_point() + geom_bar(stat="identity", fill="green", alpha=0.7) +
    theme(axis.text.x = element_text(angle=45)) + 
    geom_vline(xintercept = 9)
}]

# OLD WAY
breaks <- c(0, seq(9, 99, by=10), c(149, 199, 249, 299))
DTnoro <- DTfood[, .(Genus.Species, Int = findInterval(Illnesses, breaks))][grepl("Norov", Genus.Species), 
                  ][, .(Cnt = .N), by = Int]
DTnoro[order(Int)]
DTnoro[, sum(Cnt[Int > 9])/sum(Cnt)]

DTnoro[, {
  g <- ggplot(.SD, aes(x=Int, y=Cnt))
  g + geom_point() + geom_bar(stat="identity", fill="green", alpha=0.7) + 
    scale_x_continuous(breaks=1:15, labels=breaks)
}]



