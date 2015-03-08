# HOW TO: Tell the weather

# ref: https://developer.forecast.io/docs/v2
#       Generates an output similar to what's at 
#       http://forecast.io/#/f/12.9833,77.5833
library('jsonlite')
library('GetoptLong')

# Weather API
# https://developer.forecast.io/
# uid|pwd: sanjay.bhatikar@gmail.com | Em01an12

baseurl <- "https://api.forecast.io/forecast";
weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
lat.long.los.angeles = "37.8267,-122.423"
lat.long.bangalore = "12.9833,77.5833"
w_bangalore <- fromJSON(paste(baseurl, weather_key, lat.long.bangalore, sep="/"))

c_bangalore <- w_bangalore$currently
c_bangalore$temperature
c_bangalore$summary
c_bangalore$apparentTemperature
qqcat("RIGHT NOW\nTemperature: @{c_bangalore$temperature} deg F, \n@{c_bangalore$summary} - Feels like @{c_bangalore$apparentTemperature} deg F")

h_bangalore <- w_bangalore$hourly
h_bangalore$summary

qqcat("NEXT HOUR\n@{h_bangalore$data$summary[1]}")
qqcat("NEXT 24 HOURS @{h_bangalore$summary}")

d_bangalore <- w_bangalore$daily
d_bangalore$summary

qqcat("NEXT 7 DAYS\n@{d_bangalore$summary}")

