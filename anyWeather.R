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
locTim <- locTim[1:3,]

# Invoke the API (on vectorized function)
rec <- vecGetWeatherRecord(locTim$Latitude, 
                           locTim$Longitude, 
                           locTim$Timestamp, 
                           weatherMasterTemplate)

# Put blocks together and write out file
out <- do.call(rbind, rec)
out <- cbind(locTim, out)
write.csv(out, file="out.csv", append=TRUE)

