data("USArrests")
head(USArrests)
?USArrests

library(data.table)
DT <- as.data.table(USArrests, keep.rownames=TRUE)

DTm <- melt(DT)
names(DTm) <- c("State", "Crime", "Rate")

DTmu <- melt(DT, id.vars=c("rn", "UrbanPop" ), 
             variable.name='Crime', value.name = "Rate")
names(DTmu)[1] <- "State"

DTmu[, .(ViolentCrime = sum(Rate)), by=State]

DTc <- dcast(DTmu, State + UrbanPop ~ Crime, value.var="Rate")


DTmu[, Decile := cut(UrbanPop, quantile(UrbanPop, probs = seq(0, 1, by=0.1)))]
levels(DTmu$Decile) <- paste0(1:10, "D")

dcast(DTmu, Decile ~ Crime, value.var="Rate", fun.aggregate=sum)
dcast(DTmu, Decile ~ Crime, value.var="Rate", fun.aggregate=mean)
dcast(DTmu, Decile ~ Crime, value.var="Rate", fun.aggregate=sum)


