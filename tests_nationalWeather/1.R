# Test Suite for nationalWeather()
# Ref: http://forecast.io/#/f/12.9833,77.5833

# Files:
# nationalWeather.R             # Contains functions for testing
# tests_nationalWeather         # THIS FOLDER contains test scripts
# 1.R                           # THIS FILE A set of tests to run
# runTests_nationalWeather.R    # Master File to run all tests

# nationalWeather.R:
#   Function to provide weather for all districts in India

# tests\1.R
#   1st set of tests
#   This goes in 1.R under folder tests_nationalWeather
#   Follows the naming convention test.* for functions

test.examples <- function() {
  # Test Data Set-Up
  # Input argument - locations
  dataPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
  dataName = "locations.csv"
  reference_locations <- paste0(dataPath, dataName)
  
  r <- fetchLocations(reference_locations)
  checkEquals(dim(r)[1], 13, msg="13 locations to analze")
  checkEquals(dim(r)[2], 3, msg="Locations specified by lat-long coordinates")
  
  w <- getWeather(lat=12.9833, long=77.5833)
  checkEquals(length(w), 4, msg="Obtained 4 parcels of information")
  checkIdentical(w$now$name, "RIGHT NOW", "Got weather right now")
  checkTrue(!is.null(w$now$data$temperature), "Got temperature")
  checkTrue(!is.null(w$now$data$apparentTemperature), "Got apparent temperature")
  checkTrue(!is.null(w$now$data$summary), "Got summary")
  checkIdentical(w$next_hour$name, "NEXT HOUR", "Got weather for next hour")
  checkTrue(!is.null(w$next_hour$data$summary), "Got summary for next hour")
  checkIdentical(w$next_day$name, "NEXT 24 HOURS", "Got weather for next day")
  checkTrue(!is.null(w$next_day$data$summary), "Got summary for next day") 
  checkIdentical(w$next_week$name, "NEXT 7 DAYS", "Got weather for next hour")
  checkTrue(!is.null(w$next_week$data$summary), "Got summary for next hour")
  
  l <- nationalWeather(reference_locations)
  checkEquals(dim(l)[1], 13, msg="13 locations specified")
  checkEquals(dim(l)[2], 9, msg="weather for location with lat-long coordinates")
}
  
