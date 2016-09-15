group=c("A","B")
gender=c("female","male")
animal=c("dog","cat")

dt <- expand.grid(group=c("A","B"),gender=c("female","male"),animal=c("dog","cat"))
paste0(dt$group, dt$gender, dt$animal, sep="")

