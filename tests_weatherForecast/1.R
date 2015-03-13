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
  w <- weatherForecast()
}