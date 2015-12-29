library(data.table)
library(testthat)

setwd("C:/Users/ssbhat3/Desktop/R-How-To")
eng <- read.csv("english crops 001.csv", skip=1)

test_that("Spreadsheet is loaded into data.frame", {
  expect_is(eng, "data.frame");
  expect_gt(dim(eng)[1], 99);
  }
)

DTeng <- as.data.table(eng)

test_that("Data are stashed in data.table", {
  expect_is(DTeng, "data.table");
  expect_gt(DTeng[, .N], 99);
})

# How did Bishop of Worcestor's manors (where:location) perform (how:yield) across years(when:year) 
# on avg. for barley (what:crop)
DTbar <- dcast.data.table(DTeng[estate.name=="Bishop of Worcester",], estate.name ~ manor.name, 
                 value.var="barley.gross.yield.per.seed.ratio", 
                 fun.aggregate=mean, na.rm=TRUE )

test_that("Bishop's manors have similar yields", {
  expect_equal(DTbar[, Cleeve], 4.03)
  expect_equal(DTbar[, Cleeve], DTbar[, Henbury], tolerance = 0.2)
})

# How many years of data (how much:count) are available for crops (what:crops) across manors (where:location)
DTgrains <- melt.data.table(DTeng, id.vars=c("manor.name", "start.year"), 
                measure.vars=c("wheat.gross.yield.per.seed.ratio", 
                               "oats.gross.yield.per.seed.ratio",
                               "barley.gross.yield.per.seed.ratio",
                               "dredge.gross.yield.per.seed.ratio",
                               "legumes.gross.yield.per.seed.ratio"),
                variable.name = "crop",
                value.name = "yield")

DTgrains[, `:=`(count= sum(!is.na(yield))), by=c("crop", "manor.name") ]
DTna <- dcast.data.table(DTgrains, crop ~ manor.name, value.var="count", fun.aggregate=mean)

test_that("Bourton on the Hill has most years of data available across crops", {
  expect_equivalent(DTna[, which.max(sapply(.SD, sum)), .SDcols=2:6], 2)
})
test_that("Cleeve has the least years of data available across crops", {
  expect_equivalent(DTna[, which.min(sapply(.SD, sum)), .SDcols=2:6], 3)
  
})

