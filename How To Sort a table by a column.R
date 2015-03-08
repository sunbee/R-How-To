# HOW TO Sort a column by a table
dd <- data.frame(b = factor(c("Hi", "Med", "Hi", "Low"), 
                            levels = c("Low", "Med", "Hi"), ordered = TRUE),
                 x = c("A", "D", "A", "C"), y = c(8, 3, 9, 9),
                 z = c(1, 1, 1, 2))

# SOrt on column
dd_b <- dd[order(dd$b),]
dd_x <- dd[order(dd$x),]
dd_y <- dd[order(dd$y),]
dd_z <- dd[order(dd$z),]
