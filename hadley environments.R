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
exists(x, envir=e)          # Searches all environments starting with e, following lexical scoping rules
exists(x, envir=e, inherits=FALSE)    # Searches only the specified env.

identical(globalenv(), environment())
globalenv() == environment()

# Q: List three ways in which an environment differs from a list
# 1. An environment has a parent and has a pointer to the parent.
# 2. An environment is a bag in the sense of unordered elements.
# 3. Names within an environment are unique

# Q: If you don't supply an explicit environment, where do ls() and rm() look? Where
#   does <- make bindings?
# 1. ls() follows the regular scoping rules.
# 2. rm() follows the regular scoping rules.
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

