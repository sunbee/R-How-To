# Function renderMap

library(maptools)
library(rgeos)
library(ggplot2)

renderMap <- function(mapName, overlayName, join.field, plot.field) {
  print(mapName)
  print(overlayName)
  print(join.field)
  print(plot.field)
  
  if (!file.exists(mapName)) { stop("You have not provided a shp file") }
  if (!file.exists(overlayName)) { stop("You have not provided a file with data to overlay") }
  
  Map <- createMap(mapName)
  Overlay <- createOverlay(overlayName)
  
  # Merge data
  Map@data <- mergeMO(Map@data, Overlay, join.field)
  
  # Flatten for plot
  DD <- flattenMap(Map);  
  
  # Plot
  plotMap(DD);
  
}

createMap <- function(mapName) {
  readShapePoly(mapName)  
}

createOverlay <- function(overlayName) {
  read.csv(overlayName)
}

mergeMO <- function(M.d, O, place) {
  M.d$id <- as.numeric(rownames(M.d))
  M.dd <- merge(M.d, O, by.x="NAME_2", by.y=place, all.x=T)
  M.dd <- M.dd[order(M.dd$id), ]
  M.dd$id <- NULL
  rownames(M.dd) <- rownames(M.d)
  M.dd
  # merge mixes the order! No good!
  # How to preserve the original order?
}

flattenMap <- function(Map) {
  Map@data$id <- rownames(Map@data)
  DD <- fortify(Map, region="id")
  DD <- merge(DD, Map@data, by="id")
}

plotMap <- function(DD) {
  gg <- ggplot(data=DD, aes(x=long, y=lat, group = group, fill=X2011)) +
    geom_polygon()  +
    geom_path(color = "white") +
    coord_equal() +
    scale_fill_gradient(low="white", high="black") +
    theme(legend.position = "none", title = element_blank(),
          axis.text = element_blank())
  print(gg)
}

# Test Data Set-Up
# Input argument - mapName
shpPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/IND_adm/"
shpName = "Ind_Adm2.shp"
mapName = paste0(shpPath, shpName)
# Input argument - overlayName
dataPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
dataName = "sex_ratio.csv"
overlayName = paste0(dataPath, dataName)

# Tests
renderMap(mapName, overlayName, join.field="State", plot.field="X2001")
renderMap("mapName", overlayName, join.field="State", plot.field="X2001")
renderMap("mapName", "overlayName", "State", "X2001")
M <- createMap(mapName)
O <- createOverlay(overlayName)
class(M) # SpatialPolygonsDataFrame
class(M@polygons) # list
class(M@data) # data.frame
length(M@polygons) # 594
dim(M@data) # 594, 11
class(O) # data.frame
dim(O) # 32, 13
M_ <- mergeMO(M@data, O, place="State")
M@data <- M_;
dim(M_) # 594, 23
names(M_) # grep("X\\d+")
summary(M_$X2001) # Min: 929 | Median: 996 | Max: 1038
summary(M_$X2011) # Min: 946 | Median: 999 | Max: 1031
sum(complete.cases(M_$X2001)) #18
F <- flattenMap(M)
dim(F)
intersect(names(F), names(M@data))
plotMap(F)
