environment() # Current environment
# Other environments:
#   globalenv() is the global environment, which is the interactive workspace.
#             The parent is the last package attached with library().
#   baseenv() is the environment of the base package. Its parent 
#             is the empty environment.
#   emptyenv() is the empty environment. It is the ultimate ancestor and does not
#             have a parent.
search()
library("pryr")
library("jsonlite")

e <- new.env()
parent.env(e)
parent.env(environment())

ls(e)
# Treat it like a list
e$a <- 1  
e$b <- 2
e$f <- function(x) { x*x }  # A function is just another variable
ls(e)
e$.a <- 2                   # Names beginning with . are hidden
ls(e)
ls(e, all.names=TRUE)       # Expose the hidden variables

ls.str(e)                   # Verbose

e$c
e$c <- 3
e$c                         # Access using dollar sign $
e[["c"]]                    # Access using double bracket [[ ]]
get("c", envir=e)           # Access using get
get("c")                    # get() follows lexical scoping rules when env. is not set
c <- "three"
get("c")

e <- new.env()
e$a <- 1
e$a <- NULL                 # Sets the value to null, keeps the binding in the env.
ls(e)
rm("a", envir=e)            # Use rm() to remove the binding, value is garbage-collected
ls(e)

x <- 10
exists("x", envir=e)          # Searches all environments starting with e, following lexical scoping rules
exists("x", envir=e, inherits=FALSE)    # Searches only the specified env.

identical(globalenv(), environment())
globalenv() == environment()

# Q: List three ways in which an environment differs from a list
# 1. An environment has a parent and has a pointer to the parent.
# 2. An environment is a bag in the sense of unordered elements.
# 3. Names within an environment are unique
# 4: List elements can be removed by setting to NULL

# Q: If you don't supply an explicit environment, where do ls() and rm() look? Where
#   does <- make bindings?
# 1. ls() searches in the global environment (user-defined values).
# 2. rm() follows the rules of lexical scoping.
# 3. <- makes a binding in the current environment

mySearch <- function(x, envir=environment()) {
  while (!identical(envir, emptyenv())) {
    if (exists(x, envir, inherits=FALSE)) return(envir);
    envir = parent.env(envir)  
  }
}
mySearch("xgq32u863s")
mySearch("x")
p <- 10
mySearch("p")
mySearch("mean")

x <- 5
where("x")
where("mean")

myWhere <- function(name, envir=parent.frame()) {
  if (identical(envir, emptyenv())) {
    stop("Found no ", name, call.=FALSE) 
  } else if (exists(name, envir, inherits=FALSE)) {
    return(envir)
  } else {
    myWhere(name, parent.env(envir))
  }
}
myWhere("MeNa")
myWhere("mean")

# Q: Modify where() to return all environments that contain a binding for name
mySearchAll <- function(x, envir=environment()) {
  all <- vector()
  while (!identical(envir, emptyenv())) {
    if (exists(x, envir, inherits=FALSE)) {
      all <- c(all, envir)
    } ;
    envir = parent.env(envir)  
  }
  all
}
mySearchAll("MeNa")
mySearchAll("x")
p <- 10
mySearchAll("p")
mySearchAll("mean")
c <- 1
mySearchAll("c")

# Q: Write your own get() in the style of where()
myGet <- function(name, envir=environment()) {
  while (!identical(envir, emptyenv())) {
    if (exists(name, envir, inherits=FALSE)) {
      return(envir[[name]])
    } ;
    envir = parent.env(envir)  
  }
}
myGet("MeNa")
myGet("x")
p <- 10
myGet("p")
myGet("mean")

#Q: Write fget() that finds only function objects
fget <- function(funName, env=environment()) {
  while(!identical(env, emptyenv())) {
    if (exists(funName, env, inherits=FALSE) && is.function(env[[funName]])) {
      return(env[[funName]])
    }
    env = parent.env(env)
  }
}
fget("naMeNa")
x <- 9
fget("x")
p <- function(x) { x*x }
fget("p")
fget("mean")

#Q: Write fget() that finds only function objects with inherits arg
fget <- function(funName, env=environment(), inherits=TRUE) {
  while(!identical(env, emptyenv())) {
    if (exists(funName, env, inherits=FALSE) && is.function(env[[funName]])) {
      return(env[[funName]])
    }
    if (!inherits) break;
    env = parent.env(env)
  }
}
fget("naMeNa")
x <- 9
fget("x")
p <- function(x) { x*x }
fget("p")
fget("p", inherits=FALSE)

p <- function(x) { x*x }
environment(p)
environment(mean)

# Types of environment
# The enclosing environment determines how the function finds values, 
# the binding environment determines how we find the function.
y <- 1
f <- function(x) { x+y }
environment(f)                  # The enclosing environment of f()
e <- new.env()                  
e$f <- f                        # The binding environment of f()
e$g <- function() 1
ls(e)
ls.str(e)
e$f(1)
e$g()

# package and namespace
# Package functions like var(), sd() have bindings 
# in the package environment 'package:stats'and 
# have the namespace as their enclosing environment, so sd() shall always 
# look for var() in the namespace instead of the search path.
# This avoids 'namespace pollution' issues where a collision
# introduces unexpected behavior that can be hard to debug.
environment(sd)         # Enclosing env., where the function is created - namespace
where("sd")             # Binding env., where the function is found
x <- 1:9
sd(x)                   # sd() uses var() and 
var <- function() 1     # re-casting var() 
sd(x)                   # does not affect the behavior of sd()

# Execution environment
# The parent of the execution environment 
# is the enclosing environment of the function
g <- function(x) {
  if(!exists("a", inherits=FALSE)) {
    message("Defining a")
    a <- 1
  } else {
    a <- a + 1
  }
  a
}
g(10)
g(10)            # Same as above - ephemeral execution env.

# When you define a function within a function, the execution environment 
# of the outer function is no longer ephemeral. 
plus <- function(x) {
  function(y) {
    x+y
  }
}
plus_one <- plus(1)
plus_one(2)
environment(plus)                   # Enclosing env. of plus is global env
environment(plus_one)               # Enclosing env. of plus_one is execution env. of plus
parent.env(environment(plus_one))   # Parent env. plus_one's enclosing env. is global env.

where("plus")                       # Both have bindings in global env.
where("plus_one")

# Calling environment
h <- function() {
  x <- 10
  function() {
    x
  }
}
i <- h()      # Returns the inner (unnamed) function with 'x' in encl. env. set to 10
x <- 11       # This 'x' is in the binding env. - Red herring!
i()           # Looks up the variable 'x' in the enclosing env. and returns 10
parent.frame()

f2 <- function() {
  x <- 10
  function() {
    def <- get("x", environment())    # enclosing environment
    cll <- get("x",parent.frame())    # calling environment
    list(defined=def, called=cll)
  }
}
g2 <- f2()
x <- 20
str(g2())

x <- 0
y <- 10
f <- function() {
  x <- 1
  g()
}
g <- function() {
  x <- 2
  h()
}
h <- function() {
  x <- 3
  x + y
}
f()   # 13

# Q: List the four environments associated with a function. What does each one do?
# Why is the disctinction between enclosing and binding envs. particularly imp?
# They are: enclosing, binding, execution and calling environments.
# The enclosing env. is the parent of the execution env. and that's where the function
# looks up free variables.

f1 <- function(x1) {
  print(parent.frame())   # The calling env. of f1 is the global env.
  print(environment())    # This is the execution env. of f1
  f2 <- function(x2) {
    print(parent.frame()) # The calling env. of f2 is the execution env. of f1
    print(environment())  # This is the execution env. of f2
    f3 <- function(x3) {
      print(parent.frame()) # The calling env. of f3 is the execution env. of f2
      print(environment())  # This is      
      x1 + x2 + x3
    }
    f3(3)
  }
  f2(2)
}
f1(1)
