# Ref: How To Write a unit test


fetch <- function() {
  n=0
  while(n < 1) {
    n <- readline("enter a positive integer: ")
    n <- ifelse(grepl("\\D",n),-1,as.integer(n))
    if(is.na(n)){break}  # breaks when hit enter
  }  
  return(n)
}

# tests\1.R:
#   1st set of tests
#   This goes in 1.R under folder tests
#   Follows the naming convention test.* for functions
test.examples <- function() {
  checkEquals(6, factorial(3));
  checkEqualsNumeric(6, factorial(3));
  checkIdentical(6, factorial(3));
  checkTrue(TRUE, "It works");
  checkException(factorial('a'));
}

test.deactivate <- function() {
  DEACTIVATED("Deactivating this test function.")
}
