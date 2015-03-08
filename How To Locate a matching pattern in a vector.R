# HOW TO Locate a matching pattern in a vector

out <- grep("\\d+", c("Elena", "went", "0ver", "there"))
out <- grep("\\d+", c("Elena", "went", "0ver", "there"), value=TRUE)
