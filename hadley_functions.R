x <- 10
f1 <- function(x) {
  function(){
    x+10
  }
}
f1(1)()
# f1(1) returns a FUNCTION that returns 11. 

`+`(1, `*`(2, 3))
# 2*3 + 1 = 7

f2 <- function(a, b) {
  a * 10
}
f2(10, stop("This is an error!"))
# a*b=10*10=100 so b is never evaluated
b= stop("Go")

# Lexical scoping > Name Masking
f <- function() {
  x <- 1
  y <- 2
  c(x, y)
}
f() # c(1,2) .. looking up the body of the function
rm(f)

x <- 2
g <- function() {
  y <- 1
  c(x, y)
}
g() # c(2,1) .. looking one level up
rm(x, g)

x <- 1
h <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
  i()
}
h() # c(1,2,3) .. lookin up and further up
rm(x, h)

j <- function(x) {
  y <- 2
  function() {
    c(x, y)
  }
}
k <- j(1) # returns a function that returns c(1,2)
k() # c(1,2)
rm(j, k)

# Lexical scoping > Findng functions (or variables)
# Finding functions works the same as finding variables
l <- function(x) x + 1
m <- function() {
  l <- function(x) x * 2
  l(10)
}
m()
#> [1] 20
rm(l, m)

n <- function(x) x / 2
o <- function() {
  n <- 10
  n(n)
}
o() # Where a function is expected, variable objects are ignored in search
#> [1] 5
rm(n, o)

# Lexical scoping > Start afresh
j <- function() {
  if (!exists("a")) {
    a <- 1
  } else {
    a <- a + 1
  }
  print(a)
}
j() # Returns 1 every time the function is run
rm(j)

# Lexical scoping 


