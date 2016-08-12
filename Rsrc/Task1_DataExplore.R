setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource") 
#install.packages("pastecs")
library(pastecs)

logincounts = read.csv("logincounts.csv")

jpeg('loginCounts.jpg')
plot(logincounts, type="o", col="blue")
dev.off()

stat.desc(logincounts[2], basic=T)

