setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource") 
#install.packages("pastecs")
#install.packages("caret")
library(pastecs)
library(caret)
uberCohortData = read.csv("uberCohortData.csv")
#uberData[1-15,]

stat.desc(uberCohortData, basic=F)


#drop unwanted columns
uberCohortData[,c("signup_date","customer_life_time","trips_in_first_30_days", "last_trip_date", "retention")] <- list(NULL)
#reorder columns
uberCohortData<-uberCohortData[, c("city", "phone", "uber_black_user", "avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "active")]

#uberData<-uberData[, c("avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "level1_retention")]

#stat.desc(uberData, basic=F)

#normalized data for numeric features.
for(i in 4:9){
  uberCohortData[, i]<-scale(uberCohortData[, i])
}
#for(i in 1:6){
#  uberData[, i]<-scale(uberData[, i])
#}

suffledUberCohortData <- uberCohortData[sample(nrow(uberCohortData)),]
print(nrow(suffledUberCohortData))
#stat.desc(suffledUberCohortData, basic=F)

suffledUberCohortData[complete.cases(suffledUberCohortData),]

print( floor(nrow(suffledUberCohortData)*9/10) )

numberOfTrainingSet = floor(nrow(suffledUberCohortData)*9/10)

print(numberOfTrainingSet )

trainingSet<-suffledUberCohortData[1:numberOfTrainingSet,]
testSet<-suffledUberCohortData[ (numberOfTrainingSet + 1):nrow(suffledUberCohortData), ]

#print(nrow(testSet))

model <- glm(active ~.,family=binomial(link='logit'),data=trainingSet, na.action = na.omit)
summary(model)


fitted.results <- predict(model,newdata=subset(testSet,select=c(1,2,3,4,5,6,7,8,9)),type='response')
#fitted.results <- predict(model,newdata=subset(testSet,select=c(1,2,3,4,5,6)),type='response')

fitted.results <- ifelse(fitted.results > 0.5,1,0)
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

plot(evaluateMatrix[,1], evaluateMatrix[,2], ylim = c(0,1))

lines(evaluateMatrix[,1], evaluateMatrix[,2], col="blue", ylim = c(0,1))
par(new=TRUE)
plot(evaluateMatrix[,1], evaluateMatrix[,3], ylim = c(0,1))
lines(evaluateMatrix[,1], evaluateMatrix[,3], col="red", ylim = c(0,1))
par(new=TRUE)
plot(evaluateMatrix[,1], evaluateMatrix[,4], ylim = c(0,1))
lines(evaluateMatrix[,1], evaluateMatrix[,4], col="green", ylim = c(0,1))
par(new=TRUE)
plot(evaluateMatrix[,1], evaluateMatrix[,5], ylim = c(0,1))
lines(evaluateMatrix[,1], evaluateMatrix[,5], col="yellow", ylim = c(0,1))
require(ggplot2)


ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=y1), colour="red") +  # first layer
  geom_line(aes(y=y2), colour="green")  # second layer

output<-Evaluate(fitted.results, testSet)










NROW(fitted.results)
setwd("D:\\My_Documents\\Java\\UberDataChallenge\\Rsrc") 
kk<-testF(4)




  
  numOfCorrect = 0
  numOfWrong = 0
  
  truePositives = 0
  falsePositives = 0
  falseNegtives = 0
  actualPositive = 0
  
  print(fitted.results)
  #fitted.results
  
  NROW(fitted.results)
  NROW(testSet)
  numOfNa = 0
  for(i in 1: NROW(fitted.results)){
    if(!is.na(fitted.results[i] )){
      if(fitted.results[i] == testSet$active[i]){
        numOfCorrect <- numOfCorrect+1
        
        if(testSet$active[i] == 1 && fitted.results[i]== 1){
          truePositives <- truePositives+1
        }
        
      }else{
        
        numOfWrong <- numOfWrong+1
        
        if(testSet$active[i] == 0 &&¡@fitted.results[i] == 1){
          falsePositives <- falsePositives+1
        }else{
          falseNegtives<- falseNegtives+1
        }
      }  
    }else{
      numOfNa <- numOfNa+1
    }
  }
  #print(numOfWrong+numOfCorrect)
  #3017
  #print(numOfNa)
  #7
  #print(truePositives)
  acc= numOfCorrect / (numOfWrong+numOfCorrect)
  
  precision = truePositives / (truePositives + falsePositives)
  recall = truePositives / (truePositives + falseNegtives)
  
  f1Score = 2*precision*recall / (precision + recall)
  
  metrics<-c(acc, precision, recall, f1Score)
  
  print(metrics)
  
  return metrics
