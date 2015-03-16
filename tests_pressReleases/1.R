source("c:/Users/ssbhat3/Desktop/R-How-To/pressReleases.R")

# http://news.monsanto.com/news-releases/all/2015/all
# http://news.monsanto.com/news-releases/all/2014/all?page=1
# http://news.monsanto.com/news-releases/all/2011/all?page=4

# Configure source
config_in = list(
  URL=c("http://news.monsanto.com/news-releases/all/2011/all?page=1"),
  fields = list(
    title = list(key="title", selector=".views-field-title a", type="text"),
    date = list(key="date", selector=".views-field-created span", type="text"),
    blurb = list(key="blurb", selector=".views-field-body span", type="text"),
    link = list(key="link", selector=".views-field-title a", type="attr")
))

# Configure target
res <- data.frame(title=character(),
                  date=character()
)
config_out = list(df=res)

o <- scrape_page(config_in, config_out)
