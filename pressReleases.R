library("rvest")

# config_in: 
#   URL: Go here and get data
#   fields: all you need to fetch from single HTML page 
#     key: "Title"
#     selector: "div.special p"
#     type: text, attribute or tag
# config_out: 
#   df: empty df with headers respresenting output
#       headers must have a one-one match with fields in the input config. 

scrape_page <- function(config_in, config_out) {
  URL <- config_in$URL
  html_page <- html(URL)

  out <- list()
  for (name in names(config_in$fields)) {
    dat <- html_page %>% html_nodes(config_in$fields[[name]]$selector) # %>% html_text()
    type = config_in$fields[[name]]$type
    dat = switch(type,
           text = {
             html_text(dat)
           },
           attr = {
             unlist(html_attrs(dat))
           },
           tag = {
             html_tag(dat)
           },
           {
             html_text(dat)
           }
    )
    out[[name]] <- dat
  }
  data.frame(out, stringsAsFactors=FALSE)
}
  
  
scrape2 <- function(config_in, config_out) {

  pages <- vector();
  mon <- paste(config_in$baseURL, config_in$searchYear, "all", sep="/")
  pages <- cbind(pages, mon)
  
  config <- list()
  for (i in pages) {
    dat <- scrape_page(config, config_out) 
  }
  
  res <- rbind(res, dat)
  return(res)
}


refactor <- function() {
  links <- paste0("http://news.monsanto.com", links)
  contents <- vector();
  for (j in links) {
    print(j)
    html_page <- html(j)
    content <- html_page %>% html_nodes(".pane-pr-body p") %>% html_text()
    content <- paste(content, collapse='')
    content <- gsub("\\n\\s+", "", content)
    contents <- c(contents, content)
  }
  
}
  
