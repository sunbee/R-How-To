# HOW TO Do a Venn analysis

x <- c("Sanjay", "Shiela", "Burian", "Kalpita", "Mary")
y <- c("Burian", "Sanjay", "Kalpita", "Jesus", "Shiela")

common <- intersect(y, x)   # Intersection
different <- setdiff(y, x)   # Difference

# Also: Test presence/absence
"Jesus" %in% y
