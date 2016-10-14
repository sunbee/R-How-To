library(XML)
library(data.table)

url <- "http://www.baseball-reference.com/leagues/MLB/"
data <- readHTMLTable(url2, stringAsFactor = FALSE)

dt <- data$teams_team_wins3000
DT <- as.data.table(dt)

melt(DT, id.vars=c("Year", "G"), variable.name="Team", value="Matches")

