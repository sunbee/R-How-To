library(RUnit)

# Module: Concatenate with c()

x <- c(2,3,1)       # Data
y <- c(3,1,2)       # Data

x[2]                # Try it!
e <- 3              # What to expect 
a <- e              # Your input
msg <- "Extract an element by index. The order matters. Numbering begins with 1."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

identical(x,y)      # Try it!
e <- FALSE          # What to expect 
a <- e              # Your input
msg <- "Supply elements by order. The order matters."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x <- c(Ramesh=2,Rajan=3,Rekha=1)       # Data
x["Ramesh"]       # Try it!
e <- 2              # What to expect 
a <- e              # Your input
msg <- "Extract an element by name. Use labels to name elememts."
tryCatch(checkEqualsNumeric(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Module: Repeat with rep()

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

# Module: Make a sequence with seq()

seq(1, 9, by=2)     # Try it!
e <- c(1,3,5,7,9)   # What to expect
a <- e              # Your input
msg <- "Create a sequence from 1 to 9 in steps of 2"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

seq(1, 9, length=5) # Try it!
e <- c(1,3,5,7,9)   # What to expect
a <- e              # Your input
msg <- "Create a sequence from 1 to 9 of length 5"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

seq(1, 9, 2)        # Try it!
e <- c(1,3,5,7,9)   # What to expect
a <- e              # Your input
msg <- "Create a sequence from 1 to 9 in steps of 2. List of arguments is from, to, by, length.out"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

seq(1, 9, 5)        # Try it!
e <- c(1,6)         # What to expect
a <- e              # Your input
msg <- "Create a sequence from 1 to 9 in steps of 5. Stays below 9."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

seq(1, length=5, by=2)  # Try it!
e <- c(1,3,5,7,9)   # What to expect
a <- e              # Your input
msg <- "Create a sequence from 1 of length 5 in steps of 2."

msg <- "Don't overwhelm it with all arguments specified."
tryCatch(seq(1, 9, length=5, by=2), 
         error = function(e) print(msg, quote=FALSE))

seq(1, length=5, 2)                 # Try it!
e <- c(1.00,1.25,1.50,1.75,2.00)    # What to expect
a <- e                              # Your input
msg <- "Create a sequence with defined end-points and length and auto-calculated interval. Same as seq(1,2,length=5)"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

seq(1, length=5, 7)                 # Try it!
e <- c(1.0,2.5,4.0,5.5,7.0)         # What to expect
a <- e                              # Your input
msg <- "Create a sequence with defined end-points and length and auto-calculated interval. Same as seq(1,7,length=5)"
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Module: Execute a function on each element of a vector
x <- c(1.2,1,3)

x+2                 # Try it!
e <- c(2.2,3,5)     # What to expect
a <- e              # Your input
msg <- "Operate over all elements of a vector. This is the common behavior of a function in R. An explicit loop is not needed."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Module: Execute a function on each element of a vector
x <- c(1.2,1,3)

x+2                 # Try it!
e <- c(2.2,3,5)     # What to expect
a <- e              # Your input
msg <- "Operate over all elements of a vector. This is the common behavior of a function in R. An explicit loop is not needed."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x>1                         # Try it!
e <- c(TRUE, FALSE,TRUE)    # What to expect
a <- e                      # Your input
msg <- "It is common for a function to operate over the elements of a vector. An explicit loop is not needed."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x+c(1,2)                    # Try it!
e <- c(TRUE, FALSE,TRUE)    # What to expect
a <- e                      # Your input
msg <- "It is common for a function to operate over the elements of a vector. An explicit loop is not needed."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Module: Retrieve contents of a vector by subsetting
# A vector is an ordered collection of  elements.

x <- c(11,30,2)     # Data

x[2]                # Try it!
e <- 30             # What to expect
a <- e              # Your input
msg <- "Retrieve the 2nd element of x, namely 30."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[-2]               # Try it!
e <- c(11,2)        # What to expect
a <- e              # Your input
msg <- "Use negative indexing to exclude elements. x[-2] retrieves all but the second element of x."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[c(TRUE, FALSE,TRUE)]    # Try it!
e <- c(11,2)              # What to expect
a <- e                    # Your input
msg <- "Use TRUE/FALSE for subset selection."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[]                 # Try it!
e <- c(11,30,2)     # What to expect
a <- e              # Your input
msg <- "Obtain all of x. Useful for setting all elements to a value."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[] <- 0            # Try it!
e <- c(0,0,0)       # What to expect
a <- e              # Your input
msg <- "Set all of x to zero."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Module: Subset by position

x <- c(11,30,2,14)  # Data

x[3]                # Try it!
e <- 2              # What to expect
a <- e              # Your input
msg <- "Extract only element at index 3."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

length(x[2:4])      # Try it!
e <- 3              # What to expect
a <- e              # Your input
msg <- "Extract only elements at positions in the specified range."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[c(4,2)][1]        # Try it!
e <- 14             # What to expect
a <- e              # Your input
msg <- "Extract elements in the order specified."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[11]               # Try it!
e <- NA             # What to expect
a <- e              # Your input
msg <- "An out-size index does not throw an error. It returns a missing value."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[0]                # Try it!
e <- numeric(0)     # What to expect
a <- e              # Your input
msg <- "Numeric vector of length zero. Same as: numeric(length=0)."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

length(x[c(4,0,1)])         # Try it!
e <- 2                      # What to expect
a <- e                      # Your input
msg <- "Retrieve a vector of length 0 with index 0."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Module: Subset by exclusion

x <- c(11,30,2,14)  # Data

length(x[-3])       # Try it!
e <- 3              # What to expect
a <- e              # Your input
msg <- "Exclude only element at index 3."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[-(2:3)]           # Try it!
e <- c(11,14)       # What to expect
a <- e              # Your input
msg <- "Exclude elements at positions in the specified range."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[-c(4,2)]          # Try it!
e <- c(11,2)        # What to expect
a <- e              # Your input
msg <- "Exclude elements at 4th and 2nd position."
tryCatch(checkEquals(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

msg <- "Don't mix negative and positive indices."
tryCatch(x[c(-4,1)], 
         error = function(e) print(msg, quote=FALSE))

# Module: Subset by name

x <- c(hema=11, raju=12,p=2,x=14)

x["hema"]           # Try it!
e <- 11             # What to expect
a <- e              # Your input
msg <- "Retrieve element named Hema."
tryCatch(checkEqualsNumeric(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

msg <- "Supply the name as a quoted string or use a variable in the current workspace."
tryCatch(x[hema], 
         error = function(e) print(msg, quote=FALSE))

msg <- "Cannot negate by name."
tryCatch(x[-"hema"], 
         error = function(e) print(msg, quote=FALSE))

x[c("hema", "p")]   # Try it!
e <- c(11,2)        # What to expect
a <- e              # Your input
msg <- "Retrieve elements named hema and p."
tryCatch(checkEqualsNumeric(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

x[x]   # Try it!
e <- c(NA,NA,12,NA) # What to expect
a <- e              # Your input
msg <- "Retrieve elements of x using data in x as indices. Finds data at only one position."
tryCatch(checkEqualsNumeric(a, e, msg), 
         error = function(e) print(msg, quote=FALSE))

# Function Factory

makeTest <- function(code_snippet, expected_outcome, lesson=NULL, hint=NULL ) {
  function() {
    if (!is.null(lesson)) print(lesson)
    cat("What is the output of:\t")
    print(code_snippet)
    target <- as.character(expected_outcome)[3]
    actual <- readline(prompt="Type here: ")
    compareStrings(target, actual)
  }
}
f <- makeTest(quote(seq(1, length=5, 7)), 
              quote(e <- c(1.0,2.5,4.0,5.5,7.0)))
checkTrue(f(), "Check your answer, expects c(1,2.5,4,5.5,7) for TRUE.") 
g <- makeTest(lesson=quote(x <- c(1.2,1,3)), 
              code_snippet=quote(x+2),
              expected_outcome=quote(e <- c(3.2,3,5)))
checkTrue(g(), "Check your answer, expects c(3,2,3,5) for TRUE.") 

compareStrings <- function(target, actual) {
  target <- gsub("\\s+", "", target)  
  actual <- gsub("\\s+", "", actual)
  return(target==actual)
}
# Test:
aa <- quote(e <- c(1, 2.5, 4, 5.5, 7))
bb <- "c(1, 2.5, 4, 5.5, 7)"
checkTrue(compareStrings(as.character(aa)[3], bb), 
          "Compare strings by eliminating whitespaces")

