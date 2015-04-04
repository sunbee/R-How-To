library(RUnit)
x <- c(7,1,3)       # Data

x                   # Try it!
e <- c(7,1,3)       # What to expect 
a <- e              # Your input
msg <- "Use c() to concatenate values of same type into a vector"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

rep(x,2)            # Try it!
e <- c(7,1,3,7,1,3) # what to expect
a <- e              # Your input
msg <- "Use rep() to repeat"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

rep(x,c(3,2,1))     # Try it!
e <- c(7,7,7,1,1,3) # what to expect
a <- e              # Your input
msg <- "Use rep() to repeat with copies"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

msg <- "Copies must match the vector copied"
tryCatch(rep(x,c(3,2)), 
         error = function(e) print(msg, quote=FALSE))



