# function weatherForecast

library('jsonlite')

weatherForecast <- function(lat=12.9833, long=77.5833, days=14, selection=c("summary")) {
  # Preparatory
  baseurl <- "https://api.forecast.io/forecast";
  weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
  # Set up time-window
  tim <- time.seq(days)
  lat.long.time <- paste(lat,long, tim, sep=",")
  lat.long.time <- paste0(lat.long.time, "?units=si")
  # Acquire data: Obtain weather for specified days
  # Condition data: Slice to extract specified variables
  out <- matrix(nrow=0, ncol=length(selection)+1)
  colnames(out) <- c("timestamp", selection)
  for (i in lat.long.time) {
    f_bangalore <- fromJSON(paste(baseurl, weather_key, i, sep="/"))
    timestamp <- as.POSIXlt(f_bangalore$daily$data$time, 
                            origin="1970-01-01", 
                            tz="Asia/Kolkata")
    timestamp <- as.character(timestamp)
    out <- rbind(out, c(timestamp, f_bangalore$daily$data[1, selection]))  
  }
  # Analyze data: None 
  # Format data: Convert to data-frame and name
  out
}

time.seq <- function(days) {
  time.day <- Sys.time()
  time.seq <- seq(Sys.time(), length=days, by="day")
  time.seq <- format(time.seq, format="%Y-%m-%dT%H:%M:%S")
  time.seq
}