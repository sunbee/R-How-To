setwd("C:/Users/ssbhat3/Desktop/R-How-To")
getwd()

library(data.table)
DT <- data.table(read.csv("FoodBalanceSheets_E_All_Data.csv"))

# Question: Does India need increased corn production to keep up with 
# changing dietary habits and an increasing preference for meat
# among the burgeoning middle-class? 
# Background: As India's middle-class has grown over the decades, 
# consumption of meat has increased. Corn is not part of the native diet in India. 
# However, it has importance as animal feed. Trends over decades are thus of value.
# Analysis: Compare patterns in changing dietary habits with corn production for feed 
# and contrast with China.


Food_Meat <- DT[Country %in% c("India", "China", "United States of America") & 
                  Item %in% c("Meat") & Element %in% c("Food"), 
                .(Country, Item, Element, Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)]
Feed_Corn <- DT[Country %in% c("India", "China", "United States of America") & 
                  Item %in% c("Maize and products") & Element %in% c("Feed"), 
                .(Country, Item, Element, Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)]

DT_FF <- rbind(Food_Meat, Feed_Corn)
DT_FF_long <- melt.data.table(DT_FF, id.vars=c("Country", "Item", "Element"), variable.name="Year", value.name="Qty")
DT_FF_wide <- dcast.data.table(DT_FF_melt, Country+Year ~ Item, value.var="Qty")
old_names <- names(DT_FF_wide)
new_names <- gsub( "Maize and products", "Maize", old_names)
names(DT_FF_wide) <- new_names

# Compare 
# Trends in consumption of meat as food and consumption of corn as feed
# India, China and US 
g <- ggplot(DT_FF_long, aes(Year, Qty, group=Country:Item, color=Item, linetype=Country))
g + geom_line(size=1) + geom_point()
g + geom_line(size=1) + geom_point() + facet_wrap(~Country, scales="free")

# Question: Have dietary habits changed so calories come differently from 
# animal and vegetal products 

Food <- DT[Country %in% c("India", "China") & 
     Item %in% c("Grand Total", "Animal Products", "Vegetal Products"), 
   .(Country, Item, Element, Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)]
Food.Long <- melt.data.table(Food, id.vars=c("Country", "Item", "Element"),
              variable.name="Year", value.name="Qty")
Food.Wide <- dcast.data.table(Food.Long, Country+Year+Item ~ Element, value.var="Qty")
new.names <- c("Country", "Year", "Item", "fat.g", "kcal", "protein.g")
names(Food.Wide) <- new.names

# Compare:
# Trends in kcal over years, from animal and vegetal products
# India, China
Food.Long[grepl("kcal", Element),]
h <- ggplot(Food.Long[grepl("kcal", Element),], 
            aes(Year, Qty, group=Country:Item,
            color=Country, linetype=Item))
h <- h + geom_line(size=1.5)
h
# Conclusion: Uptrend in kcal per capita over decades in both India and China
# Drill down into animal and vegetal consumption patterns.

# Compare: Drill-Down India
# Trend in kcal from animal and vegetal products
Food.Long[grepl("kcal", Element) & Country %in% c("India") & grepl("Products", Item),]
i <- ggplot(Food.Long[grepl("kcal", Element) & 
            Country %in% c("India") & grepl("Products", Item), ],
            aes(Year, Qty, fill=Item))
i + geom_bar(stat="identity", position="fill")
i + geom_bar(stat="identity", position="stack")
# Conclusion: Uptrend in proportion of kcal coming from animal products in India,
# while vegetal products dominate.

# Compare: Drill-Down China
# Trend in kcal from animal and vegetal products
Food.Long[grepl("kcal", Element) & Country %in% c("China") & grepl("Products", Item),]
j <- ggplot(Food.Long[grepl("kcal", Element) & 
            Country %in% c("China") & grepl("Products", Item), ],
            aes(Year, Qty, fill=Item))
j + geom_bar(stat="identity", position="fill")
j + geom_bar(stat="identity", position="stack")
# Conclusion: Uptrend in proportion of kcal coming from animal products in China,
# while vegetal products dominate.

# Question: Have dietary habits changed so calories come differently from 
# protein and fat products 

# Compare: India
# Trend in kcal from from protein and fat 
Food.Long[grepl("g/", Element) & 
            Country %in% c("India") & grepl("Grand", Item), ]
k <- ggplot(Food.Long[grepl("g/", Element) & 
            Country %in% c("India") & grepl("Grand", Item), ], 
            aes(Year, Qty, fill=Element))
k + geom_bar(stat="identity", position="fill")
k + geom_bar(stat="identity", position="stack")
# Conclusion: Fat is uptrending in how Indians are getting kcal 

# Compare: China
# Trend in kcal from from protein and fat 
Food.Long[grepl("g/", Element) & 
            Country %in% c("China") & grepl("Grand", Item), ]
k <- ggplot(Food.Long[grepl("g/", Element) & 
            Country %in% c("China") & grepl("Grand", Item), ], 
            aes(Year, Qty, fill=Element))
k + geom_bar(stat="identity", position="fill")
k + geom_bar(stat="identity", position="stack")
# Conclusion: Fat is uptrending in how Chinese are getting kcal. 
# Net consumption of fat and protein (g per capita) has almost quadrupled!

# OLDE #
# Trends in meat consumption in India over decades
# Meat as food - gross consumption
DT[Country %in% c("India") & Item %in% c("Meat") & Element %in% c("Food"), 
   .(Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)][, 
    plot(as.numeric(.SD), type="b")]
DT[Country %in% c("India", "China") & Item %in% c("Meat") & Element %in% c("Food"), 
    .(Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)][, {
      plot(as.numeric(.SD[2]), type="o", pch=22, ylim=range(.SD), lty=2, col="blue");
      lines(as.numeric(.SD[1]), type="o", pch=21, lty=3, col="forestgreen");
      legend("topleft", c("China", "India"), lty=3:2, 
             col=c("forestgreen", "blue"), pch=21:22);
      title(main="Trend in gross consumption of meat for food over decades")}]
# Meat as food - per capita consumption
DT[Country %in% c("India", "China") & Item %in% c("Meat") & 
     Element %in% c("Food supply quantity (kg/capita/yr)"), 
   .(Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)][ , {
     plot(as.numeric(.SD[2]), type="o", pch=22, ylim=range(.SD), lty=2, col="blue");
     lines(as.numeric(.SD[1]), type="o", pch=21, lty=3, col="forestgreen");
     legend("topleft", c("China", "India"), lty=3:2, 
            col=c("forestgreen", "blue"), pch=21:22);
     title(main="Trend in per capita consumption of meat for food over decades")}]

# Corn production for feed
# Maize as feed
DT[Country %in% c("India") & Item %in% c("Maize and products") & Element %in% c("Feed"), 
   .(Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)][, 
    plot(as.numeric(.SD), type="b")]
# Maize gross production and utilization as feed
DT[Country %in% c("India") & Item %in% c("Maize and products") & 
     Element %in% c("Feed", "Production"), 
   .(Y1961, Y1971, Y1981, Y1991, Y2001, Y2011)][, {
     plot(as.numeric(.SD[2]), type="o", pch=22, ylim=range(.SD), lty=2, col="blue");
     lines(as.numeric(.SD[1]), type="o", pch=21, lty=3, col="forestgreen");
     legend("topleft", c("China", "India"), lty=3:2, 
            col=c("forestgreen", "blue"), pch=21:22)}]

# Plot - Per-capita consumption of meat v. utilization of corn as feed


# Question: Do Chinese consume more vegetables than Indians?
# Background: It is commonly held that most Indians are vegetarian and most Chinese
# are non-vegetarian. However, Chinese use vegetables in preparation of meat dishes.
# So consumption patterns may run counter to intution.
# Analysis

# Question: Do commonly held views about different dietary habits hold up?
#   Indians get protein from pulses and Americans from meat
#   Indians get carbs from rice and Americans from potato
#   Americans have a fat-rich diet 
# Background:
# Analysis:
# Compare the dietary protein intake per-capita (absolute and percentage) from pulses 
# and meat. Likewise, compare kcal intake per-capita from rice and potato.
# Compare the net protein/fat ratio across food items for the two (or more) countries.
# United States?
# Make a table to show per-capita protein intake coming from food categories:
#   

