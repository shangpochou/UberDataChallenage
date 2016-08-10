setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource") 
#install.packages("pastecs")
#install.packages("caret")
library(pastecs)
library(caret)
uberData = read.csv("uberDataVer1.csv")
uberData[1-15,]

for(i in 1: nrow(uberData)){
  if(uberData[i,15] ==0){
    print(uberData[i,])
  }
  
}

#drop unwanted columns
uberData[,c("signup_date","customer_life_time","trips_in_first_30_days", "last_trip_date")] <- list(NULL)
#reorder columns
uberData<-uberData[, c("city", "phone", "uber_black_user", "avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "level1_retention")]

#uberData<-uberData[, c("avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "level1_retention")]

#stat.desc(uberData, basic=F)

#normalized data for numeric features.
for(i in 4:9){
  uberData[, i]<-scale(uberData[, i])
}
#for(i in 1:6){
#  uberData[, i]<-scale(uberData[, i])
#}

suffledUberData <- uberData[sample(nrow(uberData)),]

#stat.desc(suffledUberData, basic=F)

trainingSet<-suffledUberData[1:45000,]
testSet<-suffledUberData[45001:50000,]


model <- glm(level1_retention ~.,family=binomial(link='logit'),data=trainingSet, na.action = na.omit)
summary(model)


fitted.results <- predict(model,newdata=subset(testSet,select=c(1,2,3,4,5,6,7,8,9)),type='response')
#fitted.results <- predict(model,newdata=subset(testSet,select=c(1,2,3,4,5,6)),type='response')

fitted.results <- ifelse(fitted.results > 0.5,1,0)

NROW(fitted.results)

numOfCorrect = 0
numOfWrong = 0

truePositives = 0
falsePositives = 0
falseNegtives = 0
actualPositive = 0

for(i in 1: NROW(fitted.results)){
  if(!is.na(fitted.results[i] )){
    if(fitted.results[i] == testSet$level1_retention[i]){
      numOfCorrect <- numOfCorrect+1
      
      if(testSet$level1_retention[i] == 1 && fitted.results[i]== 1){
        truePositives <- truePositives+1
      }
      
    }else{
      numOfWrong <- numOfWrong+1
      
      if(testSet$level1_retention[i] == 0 &&¡@fitted.results[i] == 1){
        falsePositives <- falsePositives+1
      }else{
        falseNegtives<- falseNegtives+1
      }
    }
    
    
  }
}

acc= numOfCorrect / (numOfWrong+numOfCorrect)

precision = truePositives / (truePositives + falsePositives)
recall = truePositives / (truePositives + falseNegtives)

f1Score = 2*precision*recall / (precision + recall)

metrics<-c(acc, precision, recall, f1Score)

print(metrics)

print(fitted.results[1])
attributes(fitted.results)
attributes(testSet)
for(i in 1:)

print(attributes(fitted.results[1]))
is.nan(fitted.results)

misClasificError <- mean(fitted.results != testSet$level1_retention)
print(paste('Accuracy',1-misClasificError))









hist(uberData[,c("phone")])

trainX<-uberData[,c("trips_in_first_30_days")] - mean(uberData[,c("trips_in_first_30_days")])

uberData[,c("trips_in_first_30_days")]<-scale(uberData[,c("trips_in_first_30_days")])
trainX
stat.desc(trainX)
preProcValues <- preProcess(trainX, method = c("center", "scale"))
preProcValues
