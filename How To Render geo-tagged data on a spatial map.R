# HOW TO Render geo-tagged data on a spatial map
library(maptools)
library(rgeos)

# How To
# Read a shape file (.shp) into familiar R objects
#   Read shp file into spatial object
shpPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/IND_adm/"
shpName = "Ind_Adm2.shp"
shpFile = paste0(shpPath, shpName)
India_map <- readShapePoly(shpFile)
#   Extract lat-long coordinates to list and meta-data to data-frame 
India_table <- India_map@data         # data-frame
India_polygons <- India_map@polygons  # list

# How To
# CRUD - Explore retrieval
#   Data Frame
class(India_table)
dim(India_table)
#   States: 35 Levels: Andaman and Nicobar Andhra Pradesh Arunachal Pradesh Assam ..
as.factor(India_table[["NAME_1"]])
#   Districts: 589 Levels: Adilabad Agra Ahmadabad Ahmednagar Aizawl ..
as.factor(India_table[["NAME_2"]])
#   All coordinates
xy <- coordinates(India_map)
plot(xy)
#   List of objects of class 'Polygons'
class(India_polygons)     # list
length(India_polygons)    # 594
#   List of what .. ?
p <- India_polygons[[1]]  # Objects of class Polygons (plural)
class(p)
#   Each object of class Polygons contains what ..?
pp <- p@Polygons          # list
#   List of what .. ?
class(pp[[1]])            # Objects of class Polygon (singular)
pp[[1]]@area              # Area bounded by polygon
pp[[1]]@coords            # Lat-long coordinates
#   Structure
#   [Polygon] << extract by index << [List] << Use @Polygons << [Polygons] << extract by index << [List]

# How To
# Extract a slice of geospatial data conditioned on name
#   List numeric labels corresponding to selection
state_names <- India_table[["NAME_1"]]
#   Subset the data-frame 
TN_table <- India_table[grep("Tamil", state_names), ]
#   Subset the list using labels 
TN_ids <- rownames(TN_table)  # Index starts at 0
TN_polygons <- India_polygons[as.numeric(TN_ids)+1]
#   Re-do map (Rebuild spatial object)
TN_map <- SpatialPolygonsDataFrame(SpatialPolygons(TN_polygons), data=TN_table)
plot(TN_map)

# How To:
# Read meta-data
dataPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
dataName = "sex_ratio.csv"
dataFile = paste0(dataPath, dataName)
sexRatio <- read.csv(dataFile)
#
TN_table <- TN_table[order(TN_table$NAME_2),]
sexRatio <- sexRatio[order(sexRatio$State),]
# Merge data
tmerge <- merge(TN_table, sexRatio, by.x="NAME_2", all.x=T, by.y="State")
# Update spatial object
TN_map@data <- tmerge;

# Data Munging
intersect(TN_table$NAME_2, sexRatio$State)  # .. what's same
setdiff(TN_table$NAME_2, sexRatio$State)    # .. what's different
# Problems:
# 1. Similar-sounding names spelled different
# 2. Whitespace issues
# 3. Missing data
# Solution:
# 2. Remove leading or trailing whitespace
sexRatio$State <- sapply(sexRatio$State, function (x) sub("\\s+$", "", x))
sexRatio$State
# 1. Use fuzzy matching for normalization
agrep("Tiruchirappalli", "Tiruchchirappalli")
agrep("Tiruchirappalli", TN_table$NAME_2)
# 3. Missing data


library(maptools) 
library(rgeos) 
library(RColorBrewer) 
library(classInt) 
library(ggplot2) 

# Plot sex ratio with three years 1951,1981 and 2011 using ggplot2 
# Setup data 
# Get polygon data using fortify : 
# - fortify generates latitute and longitude as columns in a data frame 
TN_map@data$id <- rownames(TN_map@data)
TN <- fortify(TN_map, region="id")      # Fortify loses data, add id to put back
TN <- merge(TN, TN_map@data, by="id")   # Add back the data lost in fortification

gg <- ggplot(data = TN, aes(x=long, y=lat, group = group, fill=X2011)) +
  geom_polygon()  +
  geom_path(color = "white") +
  coord_equal() +
  scale_fill_gradient(low="white", high="black") +
  theme(legend.position = "none", title = element_blank(),
        axis.text = element_blank())
print(gg)

