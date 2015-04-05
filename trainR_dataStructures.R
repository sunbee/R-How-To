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


# Function Factory

makeTest <- function(code_snippet, expected_outcome, lesson, hint ) {
  function() {
    cat("What is the output of:\t")
    print(code_snippet)
    target <- as.character(expected_outcome)[3]
    actual <- readline(prompt="Type here: ")
    compareStrings(target, actual)
  }
}
f <- makeTest(quote(seq(1, length=5, 7)), quote(e <- c(1.0,2.5,4.0,5.5,7.0)))
checkTrue(f(), "Check your answer, expects c(1,2.5,4,5.5,7) for TRUE.") 

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

