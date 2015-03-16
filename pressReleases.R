library("rvest")

sourceWWW <- "http://news.monsanto.com/news-releases/all/2014/all"

mon2014 <- list()
mon2014$page01 <- html(sourceWWW)

titles<- mon2014$page01 %>% html_nodes(".views-field-title a") %>% html_text()
dates<- mon2014$page01 %>% html_nodes(".views-field-created span") %>% html_text()
blurbs <- mon2014$page01 %>% html_nodes(".views-field-body span") %>% html_text()
blurbs <- gsub("\\n\\s+", "", blurbs)
prURLs <- mon2014$page01 %>% html_nodes(".views-field-title a") %>% html_attrs()
prURLs <- paste0("https://monsanto.com", prURLs)

out <- data.frame(title <- titles, date <- dates, blurb <- blurbs, prURL <- prURLs)
out$title <- titles
out$date <- dates
out$blurb <- blurbs
out$prURL <- prURLs
