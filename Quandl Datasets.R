library(data.table)
library(ggplot2)

supercsv <- "https://raw.githubusercontent.com/fivethirtyeight/data/fcf8ae665a36c5929f3c3a94b19e0c92985b6cdd/comic-characters/dc-wikia-data.csv"
DTsuper <- data.table(read.csv(supercsv))

g <- ggplot(DTsuper, aes(x=EYE, y=APPEARANCES))
g + geom_boxplot()
g + geom_point() + geom_smooth()

DTsuper[, .(MEAN = mean(APPEARANCES, na.rm = T)), by=EYE][, 
            EYE := factor(EYE, levels=EYE[order(MEAN)])][, {
              g <- ggplot(.SD, aes(EYE, MEAN));
              g + geom_bar(stat="identity") + theme(axis.text.x = element_text(angle=60));
            }]
# Do blue-eyed villains make more appearances than brown-eyed villains?
# Does the color of the eye affect the no. of appearances?


h <- ggplot(DTsuper, aes(x=APPEARANCES, fill=HAIR))
h + geom_histogram()
h + stat_density(position="identity")


library(Quandl)
DTufo <- data.table(Quandl("NUFORC/SIGHTINGS", collapse="monthly", trim_start="2010-11-30"))
