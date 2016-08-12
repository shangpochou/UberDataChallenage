setwd("D:\\My_Documents\\Java\\UberDataChallenge\\resource") 
#install.packages("pastecs")
#install.packages("caret")
#install.packages("e1071")
library(pastecs)
library(caret)
library(e1071)
uberData = read.csv("uberData.csv")
#Using another dataset
#uberData = read.csv("uberCohortData.csv")

print(NROW(uberData))
uberData<-uberData[complete.cases(uberData),]
print(NROW(uberData))

stat.desc(uberData, basic=F)

#drop unwanted columns
uberData[,c("signup_date","customer_life_time", "last_trip_date", "retention")] <- list(NULL)
#reorder columns
uberData<-uberData[, c("city", "phone", "uber_black_user", "trips_in_first_30_days", "avg_rating_of_driver", "avg_rating_by_driver", "avg_dist", "weekday_pct", "avg_surge", "surge_pct", "active")]


#normalized data for numeric features.
for(i in 4:10){
  uberData[, i]<-scale(uberData[, i])
}

suffledUberData <- uberData[sample(nrow(uberData)),]
print(nrow(suffledUberData))



numberOfTrainingSet = floor(nrow(suffledUberData)*9/10)


trainingSet<-suffledUberData[1:numberOfTrainingSet,]
testSet<-suffledUberData[ (numberOfTrainingSet + 1):nrow(suffledUberData), ]



#Generate small training set for SVM
trainingSet<-trainingSet[sample(1000),]

#make categorical variables as factors in R
trainingSet$city <- factor(trainingSet$city)
trainingSet$phone<- factor(trainingSet$phone)
trainingSet$uber_black_user<- factor(trainingSet$uber_black_user)
trainingSet$active<- factor(trainingSet$active)

tune.control(random = FALSE, nrepeat = 1, repeat.aggregate = mean,
             sampling = c("cross", "fix", "bootstrap"), sampling.aggregate = mean,
             sampling.dispersion = sd,
             cross = 10, fix = 2/3, nboot = 10, boot.size = 9/10, best.model = TRUE,
             performances = TRUE, error.fun = NULL)

mytunedsvm <- tune.svm(active~
                         city +
                         phone +
                         uber_black_user +
                         trips_in_first_30_days+
                         avg_rating_of_driver +
                         avg_rating_by_driver+ 
                         avg_dist+ 
                         weekday_pct+
                         avg_surge+
                         surge_pct,
                       data = trainingSet,
                       gamma = 2^(-4:1), 
                       cost = 2^(-4:1)) 

summary(mytunedsvm)
jpeg('SVM_Performance_Raw.jpg')
#jpeg('SVM_Performance_Cohort.jpg')
plot(mytunedsvm)
dev.off()
mytunedsvm$best.parameter$gamma
mytunedsvm$best.parameter$cost

svmModel<-svm(active~
                city +
                phone +
                uber_black_user +
                trips_in_first_30_days+
                avg_rating_of_driver +
                avg_rating_by_driver+ 
                avg_dist+ 
                weekday_pct+
                avg_surge+
                surge_pct,
              data = trainingSet,
              gamma = mytunedsvm$best.parameter$gamma, 
              #cost = 900)
              cost = mytunedsvm$best.parameter$cost )

summary(svmModel)

testSet$city <- factor(testSet$city)
testSet$phone<- factor(testSet$phone)
testSet$uber_black_user<- factor(testSet$uber_black_user)
testSet$active<- factor(testSet$active)


predictedResult<-predict(svmModel, newdata = testSet)
(predictedResult)

setwd("D:\\My_Documents\\Java\\UberDataChallenge\\Rsrc")
source("EvaluateSVM.R")

evaluateVector<-EvaluateSVM(predictedResult, testSet$active)
