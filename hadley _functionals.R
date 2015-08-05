# Functional

randomize <- function(fun) { fun(runif(1e3)) }
randomize(min)
randomize(sum)
randomize(mean)

# lapply()

lapply2 <- function(x, f, ...) {
  out <- vector("list", length=length(x))
  for (i in seq_along(x)) {
    out[[i]] <- f(x[[i]], ...)
  }
  out
}

ll <- replicate(n=20, expr=runif(sample(1:10, 1)), simplify=FALSE)
unlist(lapply2(ll, length))
unlist(lapply(ll, length))

# A data frame is also a list
unlist(lapply2(mtcars, class))
unlist(lapply(mtcars, class))

mtcars2 <- mtcars
mtcars2[] <- lapply(mtcars[,1:3], function(x) x / mean(x))

# Anonymous function - variation
trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(1e3)
lapply(trims, function(trim) mean(x, trim))

# Q1
# Why are these equiavalent
trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(100)

lapply(trims, function(trim) mean(x, trim=trim))
lapply(trims, mean, x=x)

# See ?mean. Note that x is a named argument.
# See lapply2 for handling of extra arguments.

# Q2
# Apply the function to every column of a data frame.
# Then to every numeric column
scale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
df <- data.frame(a <- runif(10), b <- rnorm(10))
df[] <- lapply(df, scale01)
df <- data.frame(a <- runif(10), b <- rnorm(10), c <- LETTERS[1:10])
df[] <- lapply(df, function(x) {if (is.numeric(x)) { scale01(x)} else x})

# Q3
# Fit each of the models to data mtcars
formulas <- list(
  mpg ~ disp,
  mpg ~ I(1/disp),
  mpg ~ disp + wt,
  mpg ~ I(1/disp)+wt
)

res <- lapply(formulas, lm, data=mtcars)

# Q4
# Fit the model mpg ~ disp to each of the following bootstrap replicates. 
# Then do it without an anonymous function.
bootstraps <- lapply(1:10, function(i) {
  rows <- sample(1:nrow(mtcars), rep = TRUE)
  mtcars[rows, ]
})
out <- lapply(bootstraps, function(x) lm(mpg ~ disp, data=x))
out <- lapply(bootstraps, lm, formula= mpg ~ disp)

# Q5
rsq <- function(mod) summary(mod)$r.squared
unlist(lapply(out, rsq))


# sapply and vapply
# sapply is a thin wrapper around lapply

sapply2 <- function(x, f, ...) {
  out <- lapply2(x, f, ...)
  simplify2array(out)
}

sapply2(out, rsq)

# vapply tests rigorously for output matching specifications

vapply2 <- function(x, f, f.value, ...) {
  out <- matrix(rep(f.value, length(x)), nrow=length(x))
  for (i in seq_along(x)) {
    res <- f(x[[i]], ...)
    stopifnot (
      length(res) == length(f.value),
      class(res) == class(f.value)
    )
    out[i, ] <- res
  }
  out
}
vapply2(out, rsq, numeric(1))
vapply2(mtcars, class, character(1))
vapply2(mtcars, mean, numeric(1))
