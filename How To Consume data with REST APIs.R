# HOW TO: Consume data in R with REST APIs

#Ref: http://cran.r-project.org/web/packages/jsonlite/vignettes/json-apis.html

# Github is an online code repository 
# and has APIs to get live data on almost all activity. 
# Below examples query API for data 
# upon a well known R package(ggplot) and author (Hadley).
library('jsonlite')

hadley_orgs <- fromJSON("https://api.github.com/users/hadley/orgs")
hadley_repos <- fromJSON("https://api.github.com/users/hadley/repos")
gg_commits <- fromJSON("https://api.github.com/repos/hadley/ggplot2/commits")
gg_issues <- fromJSON("https://api.github.com/repos/hadley/ggplot2/issues")

paste(format(gg_issues$user$login), ":", gg_issues$title)

# CitiBike NYC
# A single public API that shows location, status and current availability 
# for all stations in the New York City bike sharing initative.

citibike <- fromJSON("http://citibikenyc.com/stations/json")
stations <- citibike$stationBeanList
colnames(stations)

nrow(stations)

# Ergast
# The Ergast Developer API is an experimental web service 
# which provides a historical record of motor racing data 
# for non-commercial purposes.

res <- fromJSON("http://ergast.com/api/f1/2004/1/results.json")
drivers <- res$MRData$RaceTable$Races$Results[[1]]$Driver
colnames(drivers)

drivers[1:10, c("givenName", "familyName", "code", "nationality")]

# ProPublica
# Below an example from the ProPublica Nonprofit Explorer API
# where we retrieve the first 10 pages of tax-exempt organizations in the USA, 
# ordered by revenue. 
# The rbind.pages function is used to combine the pages into a single data frame.

# Store all pages in a list first
baseurl <- "http://projects.propublica.org/nonprofits/api/v1/search.json?order=revenue&sort_order=desc"
pages <- list()
for(i in 0:10){
  mydata <- fromJSON(paste0(baseurl, "&page=", i), flatten=TRUE)
  message("Retrieving page ", i)
  pages[[i+1]] <- mydata$filings
}

# Combine all pages into one
filings <- rbind.pages(pages)

# Check output
nrow(filings)
filings[1:10, c("organization.sub_name", "organization.city", "totrevenue")]

# NYT APIs
# Register here:      http://developer.nytimes.com/apps/register
# Retrieve keys:      http://developer.nytimes.com/apps/mykeys
# Read documentation: http://developer.nytimes.com/docs

# uid|pwd: sanjay.bhatikar@gmail.com | em01an

# Best-seller lists
baseurl <- "http://api.nytimes.com/svc/books/v2/lists/overview.json?published_date=2013-01-01"
bestseller_key <- "&api-key=17f9f5d23d3e0d1166816d04cb730f5b:3:61044908"
req <- fromJSON(paste0(baseurl, bestseller_key))
bestsellers <- req$results$list
category1 <- bestsellers[[1, "books"]]
subset(category1, select = c("author", "title", "publisher"))

# Articles
#search for articles
baseurl <- "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=obamacare+socialism"
article_key <- "&api-key=2feef70473d4624689b299e2699a840a:1:61044908"
req <- fromJSON(paste0(baseurl, article_key))
articles <- req$response$docs
colnames(articles)

# Weather API
# https://developer.forecast.io/
# uid|pwd: sanjay.bhatikar@gmail.com | Em01an12

baseurl <- "https://api.forecast.io/forecast";
weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
latlong = "37.8267,-122.423"
req <- fromJSON(paste(baseurl, weather_key, latlong, sep="/"))
