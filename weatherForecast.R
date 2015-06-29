# function weatherForecast
# Developed for streamlining greenhouse operations
# Cloudy skies affect the success of lab activity
# with corn from the greenhouse. The script
# generates a weather forecast for a window of time.
# The greenhouse manager takes a call to hold of sowing
# based on the no. of days with cloudy skies
# in the forecase over the next 15 days.

library('jsonlite')

weatherForecast <- function(lat=12.9833, long=77.5833, days=14, selection=c("all", "summary")) {
  # Preparatory
  
  # Set up query paramters in time-window
  lat.long.time <- time.seq(lat, long, days)

  # Acquire data: Obtain weather for specified days
  wal <- call_API(lat.long.time)
  
  # Condition data: Slice to extract specified variables
  out <- select(wal, selection)
  
  return(out)
  
}

time.seq <- function(lat, long, days) {
  time.day <- Sys.time()
  time.seq <- seq(Sys.time(), length=days, by="day")
  time.seq <- format(time.seq, format="%Y-%m-%dT%H:%M:%S")
  lat.long.time <- paste(lat,long, time.seq, sep=",")
  lat.long.time <- paste0(lat.long.time, "?units=si")
  lat.long.time
}

call_API <- function(lat.long.time) {
  baseurl <- "https://api.forecast.io/forecast";
  weather_key <- "46eeedf6b77b5fd07561a80cbe88ae39"
  wal <- data.frame() # Initialize
  for (i in lat.long.time) {
    print(paste(baseurl, weather_key, i, sep="/"))
    f_bangalore <- fromJSON(paste(baseurl, weather_key, i, sep="/"))
    timestamp <- as.POSIXlt(f_bangalore$daily$data$time, 
                            origin="1970-01-01", 
                            tz="Asia/Kolkata")
    timestamp <- as.character(timestamp)
    wln <- data.frame(values=unlist(f_bangalore$daily$data[1,]),
                      keys=names(f_bangalore$daily$data))
    if (sum(dim(wal))==0) {
      wal <- wln 
    } else {
      wal <- merge(wal, wln, by="keys", all=TRUE)
      names(wal) <- c("keys", paste("Day", 1:(dim(wal)[2]-1)))
    }
  }
  wal
}

select <- function(wal, selection) {
  # TO DO grep time in any row of wal and convert to human-readable form
  # Check if sub-setting required
  if (tolower(selection[1])=="all") {
    out <- wal
    rownames(out) <- wal$keys
  } else {
    # Subset rows, remove keys column 
    chosen <- wal$keys %in% selection
    out <- wal[chosen ,]
    rownames(out) <- wal$keys[chosen]
  }
  out$keys <- NULL
  out
}