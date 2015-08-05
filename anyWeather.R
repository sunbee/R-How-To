# function getWeather
# Get the weather at any time, anywhere

# Obtain the necessary functions
wdir <- "c:/Users/ssbhat3/Desktop/R-How-To/"
setwd(wdir)
source('weatherMasterTemplate.R')

# Load R libraries
library(plyr)
library(data.table)
library('jsonlite')

# Set up data for operations
locations <- "locations.csv"
locations <- paste0(wdir, locations)
timestamps <- "timestamps.csv"
timestamps <- paste0(wdir, timestamps)

# Get locations, timestamps for query
loc <- fetchLocations(locations)
tim <- fetchTimeStamps(timestamps)

# Flatten location and time data
locTim <- merge(loc, tim)

# Call the API
DT <- as.data.table(locTim)
ot <- DT[1:3, getWeather(Latitude, Longitude, Timestamp)$current$temperature, by=Locations]
ol <- DT[1:3, getWeather(Latitude, Longitude, Timestamp), by=Locations]
ov <- DT[1:3, list(vecGetWeather(Latitude, Longitude, Timestamp))]
names(ov$V1[[3]]) # Currently, hourly, daily, etc.

oR <- DT[1:3, vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate)]



