# Ref: How To Write a unit test

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
