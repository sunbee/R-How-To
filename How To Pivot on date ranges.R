start <- as.Date("01-01-16", format="%d-%m-%y")
end <- as.Date("01-09-16", format="%d-%m-%y")

getQuarter <- function(x, first=0, y=TRUE, prefix="Q") {
  # x:      Date object 
  # first:  Jan is 0
  # y:      Report year with quarter TODO
  # prefix: Affix symbol for quarter, default 'Q' 
  d <- as.POSIXlt(x);
  q <- floor((d$mon-first+1)/3.03)
  q <- paste0(d$year+1900,'-',prefix,q+1, collapse="")
  q
}
getQuarter(start)
getQuarter(end)

getQuarterV <- Vectorize(getQuarter)
getQuarterV(c(start, end))

getSeries <- function(start, end) {
  # start:  Date object
  # end:    Date object
  s <- seq(from=start, to=end, by="3 months")
  s <- c(s, end)
  unique(s)
}
getSeries(start, end)
getSeries(start, start)
getSeriesV <- Vectorize(getSeries)
unique(getQuarterV(getSeries(start, end)))

library(data.table)
# Load data
#   Obtain data.table from csv file
setwd('c:/Users/ssbhat3/Desktop/R-How-To');
getwd()
d <- read.csv("Products.csv")
D <- as.data.table(d)

# Condition data
#   Format date columns to Date objects
D[, ':=' (Date.Start = as.Date(Date.Start, format="%d-%b-%y"),
  Date.End = as.Date(Date.End, format="%d-%b-%y"))][]
#   Compute the no. of quarters from start, end dates
#     Use:
#       getSeriesV() for dates every quarter given start and end dates
#       getQuarterV() for the fiscal quarter given a date
Quarters <- D[, .(getSeriesV(Date.Start, Date.End))]
Quarters <- lapply(Quarters$V1, function(x) unique(getQuarterV(x)))

# Condition data
#   Expand the table in long form with information upon fiscal quarter
Repeats <- sapply(Quarters, length)
#   Replicate the rows by row. no. using this vector
Names <- D[, rownames(.SD)]
de <-  d[rep(Names, Repeats),]
De <- as.data.table(de)
De[, ':=' (Date.Start = as.Date(Date.Start, format="%d-%b-%y"),
           Date.End = as.Date(Date.End, format="%d-%b-%y"))][]
De[, Quarters := unlist(Quarters)]

# Analyze data for summaries
De[, .(Avg = mean(Cost)), by=c('Product', 'City', 'Quarters')]
