# Function components
#   The body: body()
#   The arguments: formals()
#   The environment: environmen  t()

#q What are the components of a function? How to obtain them?
f <- function(x) x^2
f
#a
str(f)
body(f)
formals(f)
environment(f)
#c A function has body, arguments and an environment in which it is defined.


# Primitive functions

#q What type of function has NULL body, arguments, environment? Refer example
formals(sum)
body(sum)
environment(sum)
#a Primitive functions found in base package 
#c Primitive functions operate at a low level for efficiency.

#q Which function tells if a function is a primitive function?
#a use:
is.null(environment(sum))
is.primitive(sum)
#c The `is.primitive()` function tests whether a function is a primitive type.

#q 
objs <- mget(ls("package:base"), inherits=TRUE)
funs <- Filter(is.function, objs)
lens <- sapply(funs, function(x) { length(formals(x)) })
# Which base function has most number of arguments?
# How many base functions have no arguments?
# Adapt the code to find all primitive functions
# a
# Save length of formals to lens, find max length
max(lens)
which(lens == max(lens))
?scan
# Scan lens for 0
which(lens == 0)
sum(lens == 0)
# 
prims <- Filter(is.primitive, funs)
length(prims)

# Lexical scoping
#   Name masking
#   Functions v variables
#   Fresh start
#   Dynamic look-up

# Lexical scoping: Look-up is based on where a function is defined, not where it is called.

#q What does the function return?
f <- function() {
  x <- 1
  y <- 7
  c(x, y)
}
f()
rm(f)
#a A vector with values 1 and 7.
#c A function is given an execution environment. Look-up starts there.

#q What does the function return?
x <- 1
g <- function() {
  y <- 7
  c(x, y)
}
g()
rm(x, g)
#a A vector with values 1 ands 7.
#c Beyond the execution environment, a function looks up the environment where it is defined.

# What does the function return?
x <- 1
h <- function() {
  y <- 7
  i <- function() {
    z <- 9
    c(x, y, z)
  }
  i()
}
h()
rm(x, h)
#a A vector with values 1, 7 and 9.
#c A function can be nested inside another function.
#c Look-up starts with the current function's execution environment.
#c Then proceeds to look up in the environment where defined. 
#c Then, in successive steps, to the Global environment. Then loaded packages.

# Closure

#q What does the function return?
j <- function(x) {
  y <- 4
  function() {
    c(x, y)
  }
}
k <- j(7)
k()
rm(j, k)
#a A numeric vector with contents 7 and 4.
#c A closure presrves the execution environment and data (here 'y') stored therin. 

# Fresh start
#q What does the function return?
rm(a)
j <- function() {
  if (!exists("a")) {
    a <- 1
  } else {
    a <- a + 1
  }
  print(a)
} 
j() # Run twice
rm(j)
#a Returns the same value, 1, every time
#c The execution environment is removed after a function has run. 
#c Hence, fresh start every time.

#q What is the output the second time the function is run?
f <- function() x

x <- 15
f()
x <- 21
f()

#q What does the code return?
`(` <- function(p) {
  if (is.numeric(p) && runif(1) < 0.12) {
    p + 1
  } else {
    p
  }
    
}
replicate(54, (3))
rm("(")
#a The parentheses randomly adds 1 to a numeric argument 12% of the time.
#c The parentheses '()' is a function. It can be over-ridden.


#q What does the code return?
c <- 10
c(c=c)
#a Vector with one named element "c" with value 10
#c Function and variable names in the same environment are kept separate.

#q How does R look for values?

#q What does the function return?
f <- function(x) {
  f <- function(x) {
    f <- function(x) {
      x ^ 2
    }
    f(x) + 1
  }
  f(x) * 2
}
f(10)
#a 202
#c The use of lexical scoping means that look-up happens in the environment where a func is def.

# Function call
# Everything that exists is an object. Everything that happens is a function.

# These are also functions
# Operators: +, -, *
# Flow Control: for, if, while
# Subsetters: [], $
# Curly brace: {}

# Backtick operator

#q Use backticks for the conventional operation.
x <- 10; y <- 5
x + y
#a Use:
`+`(x, y)
#c The operator '+' is also a function

#q Use backticks for the conventional operation
for (i in 1:2) { print(i)}
#a Use
`for`(i, 1:2, print(i))
#c The flow control operator 'for' is also a function

#q Use backticks for the conventional operation
if (i==1) print("yes!") else print("no!")
#a Use:
`if`(i==1, print("yes!"), print("no!"))
#c The flow contron operator 'if' is also a function

#q Use backticks for the conventional operation
x <- 1:12
x[3]
#a Use:
`[`(x, 3)
#c The subsetter '[]' is also a function.

#q Use backticks for the conventional operation
{print(1); print(7); print(9)}
#a
`{`(print(1); print(7); print(9))
#c The curly braces '{}' is also a function.

#q Replace custom 'add()' to add a constant to every element of a vector with native operation.
sapply(1:12, add, 3)
add <- function(x, y) {
  x+y
}
#a Use backticks:
sapply(1:12, `+`, 3)
sapply(1:12, "+", 3) # Use name of the function 
#c The operator "+" is also a function

# Function arguments
# List of arguments
# Default arguments
# Lazy evaluation

# Function arguments
# List of arguments
# Matching
# Exact name, prefix, position

# What does the function evaluate to?
f <- function(abcdefg, bcde, bcdefg) {
  list(a=abcdefg, b=bcde, c=bcdefg)
}
str(f(1, 2, 3))
str(f(2, 3, abcdefg=1))
str(f(2, 3, a=1))
str(f(2, 3, b=1))
#q All of these have the same result. Which ones are unacceptable usage?
mean(1:10)
mean(1:10, trim=0.05)
mean(x=1:10)
mean(1:10, n=T)
mean(1:10, , FALSE)
mean(1:10, 0.05)
mean(, TRUE, x=c(1:10, NA))
#a The last 4 are unacceptable by virtue of being confusing.
#a The third is overkill.
#c Use positional matching for the first one-two arguments as these are most commonly used.
#c Use readable abbreviations for prefix matching. 
#c When a function uses '...', only specify arguments following the three dots by full name.

#q How to call a function given a list of arguments with `do.call()`
args <- list(1:12, na.rm=TRUE)
# How to call mean?
#a Do this
do.call(mean, args)
#c This is the same as `mean()` with the list of arguments.

#q What does the call to `do.call()` return?
args <- list(1:12, na.rm=TRUE)
do.call("mean", args)
#a Returns 5.5
#c The function `do.call()` can accept a function name as string.

# Default arguments

#q What does the function return?
f <- function(a=7, b=9) {
  c(a, b)
}
f()
#a Returns a vector with elements 7 and 9
#c The arguments defined in a function call assume default values

# Default arguments
# Lazy evaluation

#q What does the function return?
h <- function(a=7, b=d) {
  d <- (a^2) + 4
  c(a, b)
}
h()
#a Returns a vector with elements 7 and 53
#c A default argument can be defined in the body of the function. Bad idea thougH! (Why?)

# Default arguments
# Missing arguments
#q How to determine if an argument is missing. What does the function return?
i <- function(a, b) {
  c(missing(a), missing(b))
}
i()
i(a=7)
i(b=9)
i(7, 9)
#a Returns (TRUE, TRUE), (FALSE, TRUE), (TRUE, FALSE) and (FALSE, FALSE) respectively.
#c Use `missing()` to detect whether the function call specified an argument 

# Lazy evaluation
# Closure

#q What does the function evaluate to? 
f <- function(x) {
  10
}
f(stop("This is an error!"))
# And how to force evaluation of an argument?
f <- function(x) {
  # Insert here
}
#a Evaluates to 10. To force evaluation
x
force(x)
#c Use `force(x)` or simply `x` to force evaluation

# Lazy evaluation
# Closure

#q What does this return?
add <- function(x) {
  function(y) x + y  
}
adders <- lapply(1:10, add)
adders[[1]](13)
adders[[10]](13)

add <- function(x) {
  force(x)
  function(y) x + y  
}
adders2 <- lapply(1:10, add)
adders2[[1]](13)
adders2[[10]](13)

# Lazy evaluation
# Lazy by default

#q What does x evaluate to?
f <- function(x=ls()) {
  a <- 9
  x
}
f()
#a Shows variables 'a' and 'x' in the function's execution environment.
#c Default arguments are evaluated inside the function. 
#c The evaluation of an expression happens in the current (function's) environment.

# Lazy evaluation
# Laziness is a virtue

#q Test that 'x' is not null and greater than 0. Can you do it without lazy evaluation?
x <- NULL
if (!is.null(x) && x > 0) { 
  # Do stull with x 
}
# Implement as follows
`&&` <- function(x, y) {
  if (!x) return(FALSE)
  if (!y) return(FALSE)
  
  TRUE
}
a <- NULL
!is.null(a) && a > 0  # First
a > 0 and !is.null(a) # Second
#a First eturns FALSE. Second throws an error.
#c Without lazy evaluation, both x and y would always be evaluated.

#q How to use laziness to eliminate a conditional 'if' statement
if(is.null(a)) stop("a is null")
#a
!is.null(a) || stop("a is null")
#c Lazy evaluation means the the RHS is never evaluated unless the LHS evaluates to FALSE
#c This is a more conceptual example of laziness.

# Arguments
# The special argument '...'

#q How does `plot()` accept arguments used to set plot attributes with `par()`?
#q This is illustrated below.
par(col="black")
plot(1:5, col="red")
plot(1:5, type="o", cex=5, pch=20)
#a Plot uses the special argument '...' to accept these arguments.
#c The special argument's flexibility is a double-edged sword. 
#c It can result in proliferation of arguments in a function's interface.

#q How to get the arguments passed to a function using special argument '...'?
#q Hint: Use list
f <- function(...) {
  # Enter code here
  
}
f(a=1, b=3)
#a Use:
names(list(...))
#c Use `list(...)` to access the arguments passed.


#q What will this do? 
sum(1, 2)
sum(1, 2, NA, na.mr=TRUE)
#a Returns NA
#c Ref ?sum. The function uses the '...' special argument.
#c Thus, the typo goes unrecognized. This is a price to pay for using the special argument.

# Arguments

#q Clarify the following list of odd function calls. (Repair them.)
set.seed(9)
x <- sample(replace=TRUE, 20, x=c(1:10, NA))
set.seed(7)
y <- runif(min=0, max=1, 20)
cor(m="k", y=y, u="p", x=x)
#a
set.seed(9)
x <- sample(c(1:10, NA), 20, replace=TRUE)
set.seed(7)
y <- runif(20, min=0, max=1)
cor(x, y, method="kendall", use="pairwise.complete.obs")
#c Refer arguments of a function. Arguments are determined by name and position.
#c The argument names and values may be partial or complete. R shall match.
#c An argument may have a default value. Need not be specified unless value changed.

# Lazy Evaluation

#q What does this function return?
f1 <- function(x={y <- 1; 2}, y=0) {
  x + y
}
f1()
#a 3
#c Lazy evaluation means an assignment is evaluated only when needed.
#c Thus y is assigned when x is requested, taking value 1. 

#q What does this function return?
f2 <- function(x=z) {
  z <- 100
  x
}
f2()
#a 100
#c Lazy evaluation means an assignment is evaluated only when needed
#c Thus x is evaluated when needed for return.

