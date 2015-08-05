tryCatch({
  xxx <- 1
  stop("fails")
}, error = function(e) {
  print("How dare you err!")
  out <- flattenWeatherList(list(time=1435559400,summary="Mostly Cloudy",x=777), weatherMiniTemplate)  
}, warning = function(w) {
  print("How dare you warn!")
})

funTest <- function() {
  tryCatch({
    xxx <- 1
    stop("fails")
  }, error = function(e) {
    print("How dare you err!")
    out <- flattenWeatherList(list(time=1435559400,summary="Mostly Cloudy",x=777), weatherMiniTemplate)  
  }, warning = function(w) {
    print("How dare you warn!")
  })
  
}
ooo <- funTest()

funTest <- function() {
  tryCatch({
    xxx <- pingo()
    stop("fails")
  }, error = function(e) {
    print("How dare you err!")
    out <- flattenWeatherList(list(time=1435559400,summary="Mostly Cloudy",x=777), weatherMiniTemplate)  
  }, warning = function(w) {
    print("How dare you warn!")
  })
  
}
ooo <- funTest()
