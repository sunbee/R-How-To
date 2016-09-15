# How To Scrape the www
# Ref: http://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/
# Ref: http://flukeout.github.io/#

library("rvest")
lego_movie <- html("http://www.imdb.com/title/tt1490017/")

vignette("selectorgadget")

rating <- lego_movie %>% html_node("strong span") %>% html_text() %>% as.numeric()
rating

cast <- lego_movie %>% html_nodes("div#titleCast td.itemprop span") %>% html_text()
# In a div container with id="titleCast"
# in a table, with column elements class="itemprop"
# in a span element.
cast

mess <- lego_movie %>% html_nodes("div#boardsTeaser table.boards") %>% html_table()
mess[[1]]
names(mess[[1]]) <- c("Title", "By")
mess[[1]]$Title
mess[[1]]$By

