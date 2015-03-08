# Source code
sourcePath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
fname_map = "renderMap.R"
fname_weather = "nationalWeather.R"
sourceMap <- paste0(sourcePath, fname_map)
sourceWeather <- paste0(sourcePath, fname_weather)
source(sourceMap)
source(sourceWeather)

# Source data
# District Map of India
shpPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/IND_adm/"
shpName = "Ind_Adm2.shp"
mapName = paste0(shpPath, shpName)
# Locations with Lat-Long Coordinates
dataPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
dataName = "locations.csv"
reference_locations <- paste0(dataPath, dataName)
# Weather data
weatherPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
weatherName = "weather.csv"
weather_table = paste0(weatherPath, weatherName)

# Operate
  # Obtain weather data table
  we <- nationalWeather(reference_locations)
  # Make file for overlay
  write.csv(we, weather_table, row.names=FALSE)
  # Overlay weather data on map
  renderMap(mapName, weather_table, join.field="Locations", plot.field="T")
