library(testthat)
Response <- 'c("a",  "x")'      # Response is ALWAYS a string
Answer <- c("a", "x")           # Answer can be an object or pattern
test_that("Response is correct", {
  expect_identical(eval(parse(text=Response)), Answer)
})
#Alt. Just compare strings
test_that("Response is correct", {
  expect_identical(gsub("\\s", "", Response), 'c("a","x")')
})

 
checks_out <- function(Response, Answer, Testfun="expect_equal") {
  stopifnot(!missing(Response), !missing(Answer));
  if (Testfun == "expect_match") {
      Response <- gsub("\\s", "", Response)
    } else { 
      Response <- eval(parse(text=Response))
    }
  test_that("Response is correct", {
    do.call(Testfun, list(Response, Answer))
  })
}

tryCatch (
  {
    checks_out()
    checks_out(Response='c("a",  "x")')
  },
  error = function(e) {
    message("Missing Response or Answer causes exception.")
    message(e)
  }
)
checks_out('c("a",  "x")', c("a", "x"), "expect_identical")
checks_out('`{`(print(3))', 3)
checks_out("force(x)", "force\\(x\\)", "expect_match")

# Sandbox
Response <- 'c("a",  "x")'
eval(parse(text=Response))

Response <- '`{`(print(3))'
eval(parse(text=Response))

Response <- 'h <- function() { 
10 }; h();' 
eval(parse(text=Response))

