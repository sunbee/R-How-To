# Ref: How To Write a unit test

# sample.R:
#   Function to find the factorial of a number
#   This goes in samples.R
factorial <- function(n) {
  if (n == 0) {
    return(1);
  } else {
    return(n*factorial(n - 1));
  }
}
# Thanks!
