# Test Suite for consumeREST()
# Ref: http://www.johnmyleswhite.com/notebook/2010/08/17/unit-testing-in-r-the-bare-minimum/

# Files:
# consumeREST.R                         # Containts functions for testing
# tests_competitorIntelligence          # THIS FOLDER Contains test scripts
# 1.R                                   # THIS FILE A set of tests
# runTests_competitorIntelligence.R     # Master file to run all tests

# renderMap.R:
#   Function to render geo-spatial overlays

# tests\1.R:
#   1st set of tests
#   This goes in 1.R under folder tests
#   Follows the naming convention test.* for functions
test.examples <- function() {
  # Test Data Set-Up
  # Input argument - mapName
  shpPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/IND_adm/"
  shpName = "Ind_Adm2.shp"
  mapName = paste0(shpPath, shpName)
  # Input argument - overlayName
  dataPath = "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/"
  dataName = "sex_ratio.csv"
  overlayName = paste0(dataPath, dataName)
  
  M <- createMap(mapName)
  checkEquals("SpatialPolygonsDataFrame", class(M)[1], msg="Failed to load.")
  checkTrue(is.list(M@polygons), "List of shapes of class polygons")
  checkTrue(is.data.frame(M@data), "Data stashed in a data.frame")  
  checkEquals(594, length(M@polygons), "594 shapes representing districts of India")
  checkEquals(594, dim(M@data)[1], "594 rows of data associated with each district")
  checkEquals(11, dim(M@data)[2], "various descriptors including names of districts and states") 
  
  O <- createOverlay(overlayName)
  checkTrue(is.data.frame(O), "Data upon sex ratio by district")
  checkEqualsNumeric(32, dim(O)[1], "32 districts in Tamil Nadu") 
  checkEqualsNumeric(13, dim(O)[2], "Data from census years") 
  
  M_ <- mergeMO(M@data, O, place="State")
  M@data <- M_;
  checkEqualsNumeric(594, dim(M_)[1], "Left join on map data") 
  checkEqualsNumeric(23, dim(M_)[2], "Left join has added columns")
  checkEqualsNumeric(12, sum(grepl("X\\d+", names(M_))),"Appended data is for 12 census events")
  checkEqualsNumeric(929, summary(M_$X2001)["Min."], "Sex ratio Min: 929")
  checkEqualsNumeric(1038, summary(M_$X2001)["Max."], "Sex ratio Max: 1038")
  checkEqualsNumeric(996, summary(M_$X2001)["Median"], "Sex ratio Median: 996")
  checkEqualsNumeric(946, summary(M_$X2011)["Min."], "Sex ratio Min: 946")
  checkEqualsNumeric(1031, summary(M_$X2011)["Max."], "Sex ratio Max: 1031")
  checkEqualsNumeric(999, summary(M_$X2011)["Median"], "Sex ratio Median: 999")
  checkEqualsNumeric(18, sum(complete.cases(M_$X2001)), "18 districts match")
  
  F <- flattenMap(M)
  checkEqualsNumeric(784623, dim(F)[1], "784623 lat-long pairs to plot in district-level map of India")
  checkEqualsNumeric(30, dim(F)[2], "30 associated variables, including district and state names and overlay data")
  plotMap(F)
  
  # Tests
  renderMap(mapName, overlayName, join.field="State", plot.field="X2001")
  checkException(renderMap("mapName", overlayName, join.field="State", plot.field="X2001"))
  checkException(renderMap("mapName", "overlayName", "State", "X2001"))
  
}

test.deactivation <- function() {
  DEACTIVATED("Deactivating this test function.")
}

# run_tests.R 
#   Master file to run all tests
