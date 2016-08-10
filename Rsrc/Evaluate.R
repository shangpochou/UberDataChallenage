Evaluate <- function(inputFittedResults, inputTestSet){
  
  numOfCorrect = 0
  numOfWrong = 0
  
  truePositives = 0
  falsePositives = 0
  falseNegtives = 0
  actualPositive = 0
  
  #print(inputFittedResults)
  #print(inputTestSet$phone)
  
  NROW(inputFittedResults)
  NROW(inputTestSet)
  numOfNa = 0
  for(i in 1: NROW(inputFittedResults)){
    if(!is.na(inputFittedResults[i] )){
      if(inputFittedResults[i] == inputTestSet$active[i]){
        numOfCorrect <- numOfCorrect+1
        
        if(inputTestSet$active[i] == 1 && inputFittedResults[i]== 1){
          truePositives <- truePositives+1
        }
        
      }else{
        
        numOfWrong <- numOfWrong+1
        
        if(inputTestSet$active[i] == 0 &&¡@inputFittedResults[i] == 1){
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
  
  return (c(acc, precision, recall, f1Score))
}