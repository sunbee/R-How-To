# Test Suite for WeatherForecast()
# Ref: http://forecast.io/#/f/12.9833,77.5833

# Files:
# weatherForecast.R             # Contains functions for testing
# tests_weatherForecast         # THIS FOLDER contains test scripts
# 1.R                           # THIS FILE A set of tests to run
# runTests_weatherForecast.R    # Master File to run all tests

# weatherForecast.R:
#   Function to provide weather for all districts in India

# tests_weatherForecast\1.R
#   1st set of tests
#   This goes in 1.R under folder tests_weatherForecast
#   Follows the naming convention test.* for functions

test.examples <- function() {
  tim <- time.seq(lat=12.9833, long=77.5833, days=1)
  checkEquals(length(tim), 14, "14 formated dates selected for weather forecast")
  checkTrue(grepl('\\d+T\\d+', tim[1]), "T used to seperate date and time")
  checkTrue(grepl('\\d+-\\d+', tim[1]), "- used to seperate year, month, day")
  checkTrue(grepl('\\d+:\\d+', tim[1]), ": used to seperate hour, minute, second")
  
  ret <- call_API(tim)
  
  wea <- weatherForecast(days=2)
  checkEquals(dim(wea)[1], 2, "Two days of daily weather data")
  checkEquals(dim(wea)[2], 2, "One weather variable (summary)")
  checkTrue(grepl("timestamp", colnames(wea)[1]), "Data is time-stamped")
  
  few <- c("summary", "icon", "temperatureMin", "temperatureMax", "humidity")
  wea <- weatherForecast(days=1, selection=few)
  checkEquals(dim(wea)[1], 1, "One day of daily weather data")
  checkEquals(dim(wea)[2], 6, "Five weather variables, time-stamped")

  wea <- weatherForecast(days=21, selection=few)
  checkEquals(dim(wea)[1], 21, "One day of daily weather data")
  checkEquals(dim(wea)[2], 6, "Five weather variables, time-stamped")
  
  few <-  c("summary", "icon", 
              "temperatureMin", "temperatureMinTime", 
              "temperatureMax", "temperatureMaxTime",
              "cloudCover", "humidity")
  wea <- weatherForecast(days=14, selection=few)
  checkEquals(dim(wea)[1], 14, "Two weeks of daily weather data")
  checkEquals(dim(wea)[2], 9, "Eight weather variables")
  checkTrue(grepl("timestamp", colnames(wea)[1]), "Data is time-stamped")
  
  few <-  c("summary", "icon", 
            "temperatureMin", "temperatureMinTime", 
            "temperatureMax", "temperatureMaxTime",
            "cloudCover", "humidity")
  wea <- weatherForecast(days=21, selection=few)
  checkEquals(dim(wea)[1], 21, "Two weeks of daily weather data")
  checkEquals(dim(wea)[2], 9, "Eight weather variables")

  few <-  c("summary", "icon", 
            "temperatureMin", "temperatureMinTime", 
            "temperatureMax", "temperatureMaxTime",
            "cloudCover", "humidity")
  wea <- weatherForecast(days=49, selection=few)
  checkEquals(dim(wea)[1], 49, "Two weeks of daily weather data")
  checkEquals(dim(wea)[2], 9, "Eight weather variables")
}
