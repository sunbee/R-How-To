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

oR <- DT[1:3, 
           vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate)]
# Concatenates the outcomes into one long row

oR03 <- DT[1:3, 
         vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate), 
         by=Locations]
# Gives a table with 3 records, one for each 3 unique location

oR07 <- DT[1:7, 
           vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate), 
           by=Locations]
# Same as above, for 7 unique locations

oR13 <- DT[1:13, 
         vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate), 
         by=Locations]
# Same as above, for 13 unique locations

oR14 <- DT[1:14, 
           vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate), 
           by=Locations]
# Fails! When locations are repeated, the outcome is a "long" row from concatenation

oR14 <- DT[1:14, 
           vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate), 
           by=.(Locations, Timestamp)]
# Gives a table with 14 records, one for each unique location

# Now: Appears data are repeated! "foggy nights" at every location. Accurate?
# Do we have all that we need for regression?

oR39 <- DT[, 
           vecGetWeatherRecord(Latitude, Longitude, Timestamp, weatherMasterTemplate), 
           by=.(Locations, Timestamp)]
names(oR39) <- c("Place", "Day", names(weatherMasterTemplate))
