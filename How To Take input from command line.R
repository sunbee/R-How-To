expected = 0;
actual <- fetch();
  
fetch <- function() {
  n=0
  while(n < 1) {
    n <- readline("enter a positive integer: ")
    n <- ifelse(grepl("\\D",n),-1,as.integer(n))
    if(is.na(n)){break}  # breaks when hit enter
  }  
  return(n)
}

# Ref: http://stackoverflow.com/questions/5974967/what-is-the-correct-way-to-ask-for-user-input-in-an-r-program
n=0
while(n < 1) {
  n <- readline("enter a positive integer: ")
  n <- ifelse(grepl("\\D",n),-1,as.integer(n))
  if(is.na(n)){break}  # breaks when hit enter
}

