require(data.table)
teamid <- c(1, 2, 3)
member <- c("a,b", "", "c,g,h")
leader <- c("c", "d,e", "")
dt <- data.table(teamid, member, leader)

crew <- dt[, .(strsplit(member, ","))]
crew <- unlist(crew)
leads <- dt[, .(strsplit(leader, ","))]
leads <- unlist(leads)

dt_long <- data.table(people=c(crew, leads), status = rep(c("crew", "leader"), c(length(crew), length(leader))))
