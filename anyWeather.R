# function getWeather
# Get the weather at any time, anywhere

library(plyr)

fetchLocations <- function(locations) {
  read.csv(locations)
}

fetchTimeStamps <- function(timeStamps) {
  read.csv(timeStamps)
}

getWeather <- function(lat, long, timeStamp) {
  baseurl <- "https://api.forecast.io/forecast";
  weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
  
  lat.long.time <- paste(lat, long, timeStamp, sep=",")
  sourceURL <- paste(baseurl, weather_key, lat.long.time, sep="/")
  
  out <- fromJSON(sourceURL)
}

w <- getWeather(lat="12.9833", long="77.5833", timeStamp="2015-06-29T12:00:00+0530")
