# HOW TO Match a pattern on a string

out <- grep("\\d+", c("Elena", "went", "0ver", "there"))
out <- grep("\\d+", c("Elena", "went", "0ver", "there"), value=TRUE)
