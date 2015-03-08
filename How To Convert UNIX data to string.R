# HOW TO: Convert UNIX time to human-readable string 

# Ref: http://www.noamross.net/blog/2014/2/10/using-times-and-dates-in-r---presentation-code.html

t <- 1422367985
as.POSIXct(t, origin="1970-01-01")
# "2015-01-27 19:43:05 IST"
as.Date(as.POSIXct(t, origin="1970-01-01"))
# "2015-01-27"
 