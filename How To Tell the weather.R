# HOW TO: Tell the weather

# ref: https://developer.forecast.io/docs/v2
#       Generates an output similar to what's at 
#       http://forecast.io/#/f/12.9833,77.5833
library('jsonlite')

# Weather API
# https://developer.forecast.io/
# uid|pwd: sanjay.bhatikar@gmail.com | Em01an12

# Current Forecast
baseurl <- "https://api.forecast.io/forecast";
weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
lat.long.los.angeles = "37.8267,-122.423"
lat.long.bangalore = "12.9833,77.5833"
w_bangalore <- fromJSON(paste(baseurl, weather_key, lat.long.bangalore, sep="/"))

c_bangalore <- w_bangalore$currently
c_bangalore$temperature
c_bangalore$summary
c_bangalore$apparentTemperature

h_bangalore <- w_bangalore$hourly
h_bangalore$summary

d_bangalore <- w_bangalore$daily
d_bangalore$summary

baseurl <- "https://api.forecast.io/forecast";
weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
lat.long.los.angeles = "37.8267,-122.423"
lat.long.bangalore = "12.9833,77.5833"

# Current Forecast
time.day <- Sys.time()
time.seq <- seq(Sys.time(), length=14, by="day")
time.seq <- format(time.seq, format="%Y-%m-%dT%H:%M:%S")
lat.long.time <- paste(lat.long.bangalore, time.seq, sep=",")
f_bangalore <- fromJSON(paste(baseurl, weather_key, lat.long.time[7], sep="/"))

as.POSIXlt(f_bangalore$currently$time, origin="1970-01-01", tz="Asia/Kolkata")
as.POSIXlt(f_bangalore$hourly$data$time, origin="1970-01-01", tz="Asia/Kolkata")
as.POSIXlt(f_bangalore$daily$data$time, origin="1970-01-01", tz="Asia/Kolkata")

n <- c("summary", "icon", 
       "temperatureMin", "temperatureMinTime", 
       "temperatureMax", "temperatureMaxTime",
       "cloudCover", 
       "precipIntensity", "precipProbability", "precipType")

f_bangalore$daily$data[1, n]
