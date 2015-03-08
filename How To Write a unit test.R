# HOW TO: Write a unit test

# Ref: http://www.johnmyleswhite.com/notebook/2010/08/17/unit-testing-in-r-the-bare-minimum/

# Files:
# sample.R   Containts functions for testing
# tests       Contains test scripts
# 1.R         A set of tests
# run_tests.R Master file to run all tests

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

# run_tests.R 
#   Master file to run all tests

library('RUnit');

source('sample.R');

test.suite <- defineTestSuite("testing 1-2-3", 
                              "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/tests", 
                              testFileRegexp = '^\\d+\\.R');
test.result <- runTestSuite(test.suite);
printTextProtocol(test.result);



