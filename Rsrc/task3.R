setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource") 
#install.packages("pastecs")
library(pastecs)
uberData = read.csv("uberData.csv")

uberData


stat.desc(uberData, basic=F)
uberData[,2]
hist(uberData[,2], xlim = c(0,60), breaks =60)

hist(uberData[, 7])

hist(uberData[, 13])
hist(uberData[, 14])

y<-uberData[,c("trips_in_first_30_days")]

#x<-uberData[,c("city")]
#x<-uberData[,c("signup_date")]
#x<-uberData[,c("last_trip_date")]
#x<-uberData[,c("phone")]

#x<-uberData[,c("avg_surge")]
#x<-uberData[,c("surge_pct")]

#x<-uberData[,c("avg_rating_of_driver")]
#x<-uberData[,c("avg_rating_by_driver")]

#x<-uberData[,c("uber_black_user")]
#x<-uberData[,c("customer_life_time")]

#x<-uberData[,c("avg_dist")]
x<-uberData[,c("weekday_pct")]

jpeg('weekday_pct.jpg')
plot(x, y,xlab="weekday_pct",ylab="trips_in_first_30_days", col = "blue", pch=4, cex=0.2)
abline( lm(y ~ x), lwd = 2, col="red")
lm(y ~ x)
dev.off()


colnames(uberData)[1]
uberData[,c("signup_date","last_trip_date")] <- list(NULL)




plot(uberData[,c("signup_date")], uberData[,c("trips_in_first_30_days")],xlab="signup_date",ylab="trips_in_first_30_days", col = "blue", pch=4, cex=0.2)
abline(lm(uberData[,c("trips_in_first_30_days")] ~ uberData[,c("signup_date")]), lwd = 2, col="red")
lm(uberData[,c("trips_in_first_30_days")] ~ uberData[,c("signup_date")])




plot(uberData[,c("surge_pct")], uberData[,c("trips_in_first_30_days")],xlab="surge_pct",ylab="trips_in_first_30_days", col = "blue", pch=4, cex=0.2)
abline(lm(uberData[,c("trips_in_first_30_days")] ~ uberData[,c("surge_pct")]), lwd = 2, col="red")
lm(uberData[,c("trips_in_first_30_days")] ~ uberData[,c("surge_pct")])

plot(uberData[,c("city")], uberData[,c("trips_in_first_30_days")],xlab="city",ylab="trips_in_first_30_days", col = "blue", pch=4, cex=0.2)
abline(lm(uberData[,c("trips_in_first_30_days")] ~ uberData[,c("city")]), lwd = 2, col="red")
lm(uberData[,c("trips_in_first_30_days")] ~ uberData[,c("city")])








plot(uberData[,c("last_trip_date")], uberData[,c("trips_in_first_30_days")],xlab="last_trip_date",ylab="trips_in_first_30_days")
plot(uberData[,c("surge_pct")], uberData[,c("trips_in_first_30_days")],xlab="surge_pct",ylab="trips_in_first_30_days")
plot(uberData[,c("city")], uberData[,c("trips_in_first_30_days")],xlab="city",ylab="trips_in_first_30_days")
plot(uberData[,c("avg_surge")], uberData[,c("trips_in_first_30_days")],xlab="avg_surge",ylab="trips_in_first_30_days")
plot(uberData[,c("weekday_pct")], uberData[,c("trips_in_first_30_days")],xlab="weekday_pct",ylab="trips_in_first_30_days")
plot(uberData[,c("avg_rating_of_driver")], uberData[,c("trips_in_first_30_days")],xlab="avg_rating_of_driver",ylab="trips_in_first_30_days")
plot(uberData[,c("avg_rating_by_driver")], uberData[,c("trips_in_first_30_days")],xlab="avg_rating_by_driver",ylab="trips_in_first_30_days")


fit <- glm(uberData[,c("level1_retention")]~uberData[,c("trips_in_first_30_days")],data=uberData,family=binomial())
summary(fit)
