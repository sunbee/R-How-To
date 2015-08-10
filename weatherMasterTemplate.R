# Extract day's weather from weather object
getWeatherRecord <- function(lat, long, timeStamp, template) {
  tryCatch({
    we <- getWeather(lat, long, timeStamp)
    out <- flattenWeatherList(we$daily$data, template)  
  }, error = function(e) {
    time <-  as.integer(as.POSIXct(timeStamp))
    out <- template
    out[1,] <- rep(NA, length(out))
    out[1,1] <- as.POSIXct(time, origin="1970-01-01")
    out
  }, finally = function() {
    closeAllConnections()
  })
}
# TEST # wR1 <- getWeatherRecord(lat="12.9833", long="77.5833", timeStamp="2015-06-29T12:00:00+0530", template=weatherMasterTemplate)
# TEST # wR2 <- getWeatherRecord(lat="12.JUNK", long="77.5833", timeStamp="2015-06-29T12:00:00+0530", template=weatherMasterTemplate)

vecGetWeatherRecord <- Vectorize(getWeatherRecord, 
                                 vectorize.args=c("lat", "long", "timeStamp"),
                                 SIMPLIFY=FALSE)

# Template for record of weather data (32 variables)
weatherMasterTemplate <- data.frame(
  time=as.POSIXct(integer(), origin="1970-01-01"), 
  summary=character(),
  icon=character(),
  sunriseTime=as.POSIXct(integer(), origin="1970-01-01"),
  sunsetTime=as.POSIXct(integer(), origin="1970-01-01"),
  moonPhase=numeric(),
  nearestStormDistance=numeric(),
  nearestStormBearing=numeric(),
  precipIntensity=numeric(),
  precipIntensityMax=numeric(),
  precipIntensityMaxTime=numeric(),
  precipProbability=numeric(),
  precipType=character(),
  precipAccumulation=numeric(),
  temperature=numeric(),
  temperatureMin=numeric(),
  temperatureMinTime=as.POSIXct(integer(), origin="1970-01-01"),
  temperatureMax=numeric(),
  temperatureMaxTime=as.POSIXct(integer(), origin="1970-01-01"),
  apparentTemperature=numeric(),
  apprarentTemperatureMin=numeric(),
  apparentTemperatureMinTime=as.POSIXct(integer(), origin="1970-01-01"),
  apparentTemperatureMax=numeric(),
  apparentTemperatureMaxTime=as.POSIXct(integer(), origin="1970-01-01"),
  dewPoint=numeric(),
  windSpeed=numeric(),
  windBearing=numeric(),
  cloudCover=numeric(),
  humidity=numeric(),
  pressure=numeric(),
  visibility=numeric(),
  ozone=numeric()
  )

weatherMiniTemplate <- data.frame(
  time=as.POSIXct(integer(), origin="1970-01-01"), 
  summary=character(),
  icon=character()
)

# Reshape one data point (see API docs) to a row using templated spreadsheet
flattenWeatherList <- function(myList, myTemplate) {
  ret <- lapply(names(myTemplate), function(x) {
    if (is.null(myList[[x]])) {
      appendage <- NA
    } else {
      appendage <- myList[[x]]
    }
    # c(myTemplate[[x]], appendage) # To preserve classes 
    appendage
  })
  do.call(data.frame, setNames(ret, names(myTemplate)))
}

# TEST # out <- flattenWeatherList(list(time=1435559400,summary="Mostly Cloudy",x=777), weatherMiniTemplate)
# TEST # 
out <- flattenWeatherList(w$daily$data, weatherMasterTemplate)
# TEST # out <- flattenWeatherList(list(time=1435559400,summary="Mostly Cloudy",x=777), weatherMasterTemplate)

# Get weather object at a location and at a time
getWeather <- function(lat, long, timeStamp) {
  baseurl <- "https://api.forecast.io/forecast";
  weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
  
  lat.long.time <- paste(lat, long, timeStamp, sep=",")
  sourceURL <- paste(baseurl, weather_key, lat.long.time, sep="/")
  
  sourceURL
  w <- fromJSON(sourceURL)
  w
}

vecGetWeather <- Vectorize(getWeather, SIMPLIFY=FALSE)

# TEST # w <- getWeather(lat="12.9833", long="77.5833", timeStamp="2015-06-29T12:00:00+0530")

# Read files with data upon location and days
fetchLocations <- function(locations) {
  read.csv(locations)
}

fetchTimeStamps <- function(timeStamps) {
  read.csv(timeStamps, stringsAsFactors=FALSE)
}

