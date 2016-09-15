setwd("c:/Users/ssbhat3/Desktop/R-How-To")
getwd()

# Source: http://www.fec.gov/disclosurep/PDownload.do
library(data.table)
library(testthat)
library(ggplot2)

DTcand <- data.table(read.csv("P00000001-ALL_.csv", header=TRUE, stringsAsFactors=FALSE))
str(DTcand)

uniqueCand <- DTcand[, unique(cand_nm)]

test_that("Spreadsheet is loaded into table that meets parameters", {
  expect_equal(length(uniqueCand), 21)
  expect_true(grepl("Trump", paste0(uniqueCand, collapse="; ")))
  expect_true(grepl("Carson", paste0(uniqueCand, collapse="; ")))
  expect_true(grepl("Rubio", paste0(uniqueCand, collapse="; ")))
})

# Who (who:candidates) received how much (how much:dollars) in campaign contributions?
# Who (who:candidates) are the 20% who received 80% (how much:dollars) of campaign contributions?
# Who (who:candidates) received how much (how much:dollars) in campaign contributions and where (where:state)?
# CUBE: Who (who:candidates) spent how much (how much:dollars) where (where:state) and when (when:fiscal quarter) 

DTgross <- DTcand[, .(GrossReceipt = sum(contb_receipt_amt)), by = cand_nm]
setorder(DTgross, -GrossReceipt)

test_that("Candidates have received over USD 100 M", {
  expect_gt(DTgross[, sum(GrossReceipt)], 100000000)
})

DTgross[, CumSum := cumsum(GrossReceipt) ]
DTgross[, `:=`(Pareto = CumSum < 0.8 * sum(GrossReceipt))]
Pareto <- DTgross[Pareto==TRUE, cand_nm ]

test_that("Pareto has Clinton and Sanders among top fund-raisers and not Trump", {
  expect_true(grepl("Hillary", paste0(Pareto, collapse="; ")), 1)
  expect_true(grepl("Sanders", paste0(Pareto, collapse="; ")), 1)
  expect_true(!grepl("Trump", paste0(Pareto, collapse="; ")), 1)
})

DTcand[, `:=`(Date = as.Date(contb_receipt_dt, format="%d-%b-%y"))][, 
            `:=`(Month=format(Date, "%B"))]
DTmon_wide <- dcast.data.table(DTcand[grepl("-15", contb_receipt_dt), ], 
                               cand_nm ~ Month, 
                               value.var="contb_receipt_amt",
                               fun.aggregate=sum, 
                               na.rm=TRUE)
DTmon_long <- melt.data.table(DTmon_wide, 
                              id.vars="cand_nm", 
                              variable.name="Month", 
                              value.name="CampaignDollars")
DTmon_long[, Month := factor(Month, levels=month.name)]
setorder(DTmon_long, Month)
  
g <- ggplot(DTmon_long, aes(x=Month, y=CampaignDollars, group=cand_nm, color=cand_nm))
g + geom_line() + geom_point()

h <- ggplot(DTmon_long[cand_nm %in% Pareto,], 
            aes(x=Month, y=CampaignDollars, group=cand_nm, fill=cand_nm))
h + geom_line(size=1.5) + geom_point()
h + geom_bar(aes(reorder(Month, CampaignDollars, sum)), position="stack", stat="identity")
h + geom_area(position="fill", stat="identity", alpha=0.7) + theme(legend.position="top")
h + geom_area(position="stack", stat="identity", alpha=0.75) + theme(legend.position="top")

month_sum <- DTmon_long[, sum(CampaignDollars), by=Month][which.max(V1), Month]
month_med <- DTmon_long[, median(CampaignDollars), by=Month][which.max(V1), Month]
cand_lead <- DTmon_long[, sum(CampaignDollars), by=cand_nm][which.max(V1), cand_nm]
janu_lead <- DTmon_long[Month %in% "January", 
                        sum(CampaignDollars), by=cand_nm][which.max(V1), cand_nm]

test_that("Campaign leaderboard: Top-grossing candidate - Hillary; Top-grossing month - June, 
          First off the mark - Rand Paul", {
  expect_equal(as.character(month_sum), "June");
  expect_equal(as.character(month_med), "June");
  expect_match(cand_lead, "Hillary")
  expect_match(janu_lead, "Rand")
})

