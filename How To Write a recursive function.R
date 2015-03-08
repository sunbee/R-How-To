# HOW TO: Write a recursive function

# rec <- recurse(in) {
#   if (in meets base_condition) {
#     return(modified_in);
#   } else {
#     recurse(modified_in);
#   }
# }

# Example 1:
#   Find the factorial of n
#   n! = n*(n-1)*(n-2)*..*(1)
factorial <- function(n) {
  if (n == 0) {
    return(1);
  } else {
    return(n*factorial(n - 1));
  }
}
factorial(5);

# Example 2:
#   Find that a variable exists
#   Refer: http://adv-r.had.co.nz/Environments.html

where <- function(name, env = parent.frame()) {
  if (identical(env, emptyenv())) {
    # Base case 
    stop("Can't find ", name, call. = FALSE)  
  } else if (exists(name, envir = env, inherits = FALSE)) {
    # Success case
    env    
  } else {
    # Recursive case
    where(name, parent.env(env))    
  }
}
x <- 5;
where("x")
where("doesnt_exist")
where("mean")

f <- function(..., env = parent.frame()) {
  if (identical(env, emptyenv())) {
    # base case .. hit rock bottom
    # Exit with exception
  } else if (success) {
    # success case .. found what we were looking for
    # Exit with result
  } else {
    # recursive case .. keep looking
    # Invoke the function again (and again)
    f(..., env = parent.env(env))
  }
}
