#Create your own appication key at https://dev.twitter.com/apps
consumer_key =    "ZoonEQtCPpBqEJasG1gSw"  
consumer_secret = "fSgVvHbs4W3vLUSSlQrGEfnWhXTnLvBXe69CJpZ4";

# Who is tweeting about Monsanto, how, and where?
# Who are the influencer?
# 
#Use basic auth
library(httr)
library(RCurl)
library(stringr)
library(data.table)
library(igraph)
secret <- RCurl::base64(paste(consumer_key, consumer_secret, sep = ":"));
req <- POST("https://api.twitter.com/oauth2/token",
            add_headers(
              "Authorization" = paste("Basic", secret),
              "Content-Type" = "application/x-www-form-urlencoded;charset=UTF-8"
            ),
            body = "grant_type=client_credentials"
);

#Extract the access token
token <- paste("Bearer", content(req)$access_token)

# HACK
# Refer to Twitter Search API here: https://dev.twitter.com/rest/public/search
# Refer Query Operators for options to modify search
# Search on twitter.com/search
# Grab the URL and plug in api.twitter.com, i.e. ..
# Replace 1 with 2
#   https://twitter.com/search?q=
#   https://api.twitter.com/1.1/search/tweets.json?q=

# Query: @Monsanto :)
url <- "https://api.twitter.com/1.1/search/tweets.json?q=%40Monsanto%20%3A)&count=15"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$statuses$text, 1, 100)
tweets$statuses$user$screen_name

# Get thousands of tweets
# Pre-Process
#   IO
    url <- "https://api.twitter.com/1.1/search/tweets.json?q=Monsanto&count=500"
    TweeDT <- data.table();
#   Meta
    N = 15         # No. of iterations
    iter = 0      # current iteration
    max_id = "0"  # Paging
# Loop
while (iter < N) {
  # Prep
  if (max_id != "0") {
    maxBit <- paste0("max_id=", max_id)
    useUrl <- paste(url, maxBit, sep="&")
  } else {
    useUrl <- url;
  }
  # Do
  print(useUrl)
  Sys.sleep(1)
  req <- GET(useUrl, add_headers(Authorization = token))
  if (req$status_code != 200) next;
  json <- content(req, as="text")
  tweets <- fromJSON(json)
  # 
  dt <- data.table(twit=tweets$statuses$text, user=tweets$statuses$user$screen_name,
                   num_id=tweets$statuses$id, str_id=tweets$statuses$id_str)
  TweeDT <- rbind(TweeDT, dt)
  # Wrap
  iter = iter + 1
  max_id <- dt[, str_id[.N]]
}
# Post-Process
UR <- TweeDT[, RT := grepl("(RT|via)\\s", twit)][RT==TRUE, 
            .(user, originator = str_match(twit, "(RT|via)\\s+@(\\w+\\b)")[,3])]

URC <- UR[, Complete := complete.cases(.SD)][Complete==TRUE, ][, Complete := NULL]

# Graph
netWork <- graph.edgelist(as.matrix(URC))
vLabels <- get.vertex.attribute(netWork, "name", index=V(netWork))
gLayout <- layout.fruchterman.reingold(netWork)
plot(netWork, layout=gLayout)
par(bg="gray15", mar=c(1,1,1,1.5))
plot(netWork, layout=gLayout,
     vertex.size=10,
     vertex.color="gray25",
     vertex.label=vLabels,
     vertex.label.family="sans",
     vertex.label.cex=0.5,
     vertex.label.color=hsv(h=0, s=0, v=0.95, alpha=0.5),
     vertex.shape="none",
     edge.width=3,
     edge.arrow.size=0.8,
     edge.arrow.width=0.3
     )

# Sandbox

# TWeets from Bangalore
# lat=  12.8700323
# long= 77.5978142
# q=&geocode=12.8700323,77.5978142,49km
url <- "https://api.twitter.com/1.1/search/tweets.json?q=Monsanto&geocode=12.8700323,77.5978142,117mi"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$statuses$text, 1, 100)

# Near a place
# HACK 
# Use Advanced Search here: https://twitter.com/search-advanced?lang=en&lang=en
# Who is talking about friends near Bangalore?
url <- "https://api.twitter.com/1.1/search/tweets.json?q=friends&geocode=12.8700323,77.5978142,117km"
# What is Bangalore a-tweeter about?
url <- "https://api.twitter.com/1.1/search/tweets.json?q=&geocode=12.8700323,77.5978142,117km&count=500"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$statuses$text, 1, 100)

# What are people saying about Monsanto?
# One page
url <- "https://api.twitter.com/1.1/search/tweets.json?q=Monsanto&count=500"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$statuses$text, 1, 100)
tweets$statuses$user$screen_name

# What (else) are people saying about Monsanto? 
# Pagination - One more page
url <- "https://api.twitter.com/1.1/search/tweets.json?q=Monsanto&count=500&max_id=650659744303173632"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$statuses$text, 1, 100)
tweets$statuses$user$screen_name

DT <- data.table(twit=tweets$statuses$text, user=tweets$statuses$user$screen_name,
                 num_id=tweets$statuses$id, str_id=tweets$statuses$id_str)
DT[, RT := grepl("(RT|via)\\s", twit)][RT==TRUE, 
      .(twit, user, originator = str_match(twit, "(RT|via)\\s+@(\\w+\\b)")[,3])]
DT[, str_id[.N]] # Max id

# Other:
str_match("Go @home now", "@(\\w+\\b)")

# Search - Various primitive
# What is Sanjay saying?
url <- "https://api.twitter.com/1.1/statuses/user_timeline.json?count=10&screen_name=sanjaybhatikar"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$text, 1, 100)

# Who is saying what about Monsanto?
url <- "https://api.twitter.com/1.1/search/tweets.json?q=@Monsanto"
req <- GET(url, add_headers(Authorization = token))
json <- content(req, as = "text")
tweets <- fromJSON(json)
substring(tweets$statuses$text, 1, 100)
tweets$statuses$user$screen_name
