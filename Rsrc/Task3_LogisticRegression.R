setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource") 
#install.packages("pastecs")
#install.packages("caret")
library(pastecs)
library(caret)
#uberData = read.csv("uberData.csv")
uberData = read.csv("uberCohortData.csv")

print(NROW(uberData))
uberData<-uberData[complete.cases(uberData),]
print(NROW(uberData))

stat.desc(uberData, basic=T)

#drop unwanted columns
uberData[,c("signup_date","customer_life_time", "last_trip_date", "retention")] <- list(NULL)
#reorder columns
uberData<-uberData[, c("city", "phone", "uber_black_user", "trips_in_first_30_days", "avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "active")]

#uberData<-uberData[, c("avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "level1_retention")]

#normalized data for numeric features.
for(i in 4:10){
  uberData[, i]<-scale(uberData[, i])
}

suffledUberData <- uberData[sample(nrow(uberData)),]

print( floor(nrow(suffledUberData)*9/10) )

numberOfTrainingSet = floor(nrow(suffledUberData)*9/10)

print(numberOfTrainingSet )

trainingSet<-suffledUberData[1:numberOfTrainingSet,]
testSet<-suffledUberData[ (numberOfTrainingSet + 1):nrow(suffledUberData), ]

#make categorical variables as factors in R
trainingSet$city <- factor(trainingSet$city)
trainingSet$phone<- factor(trainingSet$phone)
trainingSet$uber_black_user<- factor(trainingSet$uber_black_user)
trainingSet$active<- factor(trainingSet$active)

model <- glm(active ~ 
               city +
               phone +
               uber_black_user +
               trips_in_first_30_days +
               avg_rating_of_driver +
               avg_rating_by_driver+ 
               avg_dist+ 
               weekday_pct+
               avg_surge+
               surge_pct
             ,family=binomial(link='logit'),data=trainingSet, na.action = na.omit)
summary(model)

#make categorical variables as factors in R
testSet$city <- factor(testSet$city)
testSet$phone<- factor(testSet$phone)
testSet$uber_black_user<- factor(testSet$uber_black_user)
testSet$active<- factor(testSet$active)

fitted.results <- predict(model,newdata=subset(testSet,select=c(1,2,3,4,5,6,7,8,9,10)),type='response')

setwd("D:\\My_Documents\\Java\\UberDataChallenge\\Rsrc")
source("Evaluate.R")

evaluateMatrix = matrix(, nrow = 10, ncol = 5)
print(evaluateMatrix)
for(i in 1 : 10){
  boundary<- (0.1*i)
  #print(boundary)
  curFittedResults<-ifelse(fitted.results > boundary,1,0)
  evaluateMatrix[i, 2:5]<-Evaluate(curFittedResults, testSet)
  evaluateMatrix[i, 1]<-boundary
  
}
print(evaluateMatrix)

setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource")
#jpeg('Evaluation_DecisionBoundary_Raw.jpg')
jpeg('Evaluation_DecisionBoundary_Cohort.jpg')

plot(evaluateMatrix[,1], evaluateMatrix[,2], ylim = c(0,1), xlab="Decision Boundary", ylab="Evaluation Metrics")

lines(evaluateMatrix[,1], evaluateMatrix[,2], col="blue", ylim = c(0,1))
par(new=TRUE)
plot(evaluateMatrix[,1], evaluateMatrix[,3], ylim = c(0,1), xlab="Decision Boundary", ylab="Evaluation Metrics")
lines(evaluateMatrix[,1], evaluateMatrix[,3], col="red", ylim = c(0,1))
par(new=TRUE)
plot(evaluateMatrix[,1], evaluateMatrix[,4], ylim = c(0,1), xlab="Decision Boundary", ylab="Evaluation Metrics")
lines(evaluateMatrix[,1], evaluateMatrix[,4], col="green", ylim = c(0,1))
par(new=TRUE)
plot(evaluateMatrix[,1], evaluateMatrix[,5], ylim = c(0,1), xlab="Decision Boundary", ylab="Evaluation Metrics")
lines(evaluateMatrix[,1], evaluateMatrix[,5], col="yellow", ylim = c(0,1))

legend(0.2,0.3, 
       c("Accuracy", "precision", "recall", "F1 Score"), 
      lty=c(1,1), 
      lwd=c(2.5,2.5),col=c("blue","red", "green", "yellow")) 
dev.off()
