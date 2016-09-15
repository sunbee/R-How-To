# HOW TO Strip leading or trailing whitespaces from text

x <- c("Sanjay", "Smita ", "Shiela  Ki ", " Shilpa")

# Remove:
#   Any whitespace
xs <- sapply(x, function (x) sub("\\s+", "", x))
#   Trailing whitespace
xs <- sapply(x, function (x) sub("\\s+$", "", x))
#   Leading whitespace
xs <- sapply(x, function (x) sub("\\s+$", "", x))

