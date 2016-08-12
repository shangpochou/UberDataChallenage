EvaluateSVM <- function(predicted, test){
  
  numOfCorrect = 0
  numOfWrong = 0
  
  truePositives = 0
  falsePositives = 0
  falseNegtives = 0
  actualPositive = 0
 
  for(i in 1: NROW(predicted)){

      if(predicted[i] == test[i]){
        numOfCorrect <- numOfCorrect+1
        
        if(predicted[i] == 1 && test[i]== 1){
          truePositives <- truePositives+1
        }
        
      }else{
        
        numOfWrong <- numOfWrong+1
        
        if(test[i] == 0 &&¡@predicted[i] == 1){
          falsePositives <- falsePositives+1
        }else{
          falseNegtives<- falseNegtives+1
        }
      }  
    }

  acc= numOfCorrect / (numOfWrong+numOfCorrect)
  
  precision = truePositives / (truePositives + falsePositives)
  recall = truePositives / (truePositives + falseNegtives)
  
  f1Score = 2*precision*recall / (precision + recall)
  
  metrics<-c(acc, precision, recall, f1Score)
  
  print(metrics)
  
  return (c(acc, precision, recall, f1Score))
}