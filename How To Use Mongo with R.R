# Function consumeREST 
library('jsonlite')
library('rmongodb')

m <- mongo.create()
names <- "database.collection"
mongo.is.connected(m)

o <- '{"Name" : "Sanjay", "email" : "sanjay.bhatikar@gmail.com"}'
bo <- mongo.bson.from.JSON(o);
mongo.insert(m, names, bo)

l <- list("Name"="Ajay", "email"="ajayr@formbuddy.com")
bl <- mongo.bson.from.list(l)
mongo.insert(m, names, bl)

g <- fromJSON("https://api.github.com/repos/hadley/ggplot2/issues")
g$user
g$user$login
bg <- mongo.bson.from.df(g)
mongo.insert(m, names, bg)

if (mongo.is.connected(m)) {
  mongo.get.databases(m)
  mongo.get.database.collections(m, "database")
  mongo.find.one(m, "database.collection")
  mongo.find.all(m, "database.collection")
  mongo.find.one(m, "database.collection", '{"Name" : "Ajay"}')
  mongo.find.one(m, "database.collection", '{"Name" : "Sanjay"}')
  mongo.find.all(m, "database.collection", '{"Name" : "Sanjay"}')
  mongo.distinct(m, "database.collection", 'Name')
  mongo.find.all(m, "database.collection", '{"Name" : { $regex: /w+/i } }')
  
  mongo.drop(m, "database.collection")
  mongo.destroy(m)
  
}
