# function getWeather
# Get the weather at any time, anywhere

library(plyr)
library(data.table)

fetchLocations <- function(locations) {
  read.csv(locations)
}

fetchTimeStamps <- function(timeStamps) {
  read.csv(timeStamps, stringsAsFactors=FALSE)
}

base <- "C:/Users/ssbhat3/Desktop/R-HOW-TO/"
locations <- "locations.csv"
locations <- paste0(base, locations)
timestamps <- "timestamps.csv"
timestamps <- paste0(base, timestamps)

loc <- fetchLocations(locations)
tim <- fetchTimeStamps(timestamps)

locTim <- merge(loc, tim)

getWeather <- function(lat, long, timeStamp) {
  baseurl <- "https://api.forecast.io/forecast";
  weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
  
  lat.long.time <- paste(lat, long, timeStamp, sep=",")
  sourceURL <- paste(baseurl, weather_key, lat.long.time, sep="/")
  
  sourceURL
  w <- fromJSON(sourceURL)
  w
}

w <- getWeather(lat="12.9833", long="77.5833", timeStamp="2015-06-29T12:00:00+0530")

