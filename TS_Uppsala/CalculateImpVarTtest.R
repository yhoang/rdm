CalculateImpVarTtest <- function(setTrain,typeVariationTtest){
  x1=setTrain[setTrain$OS_bin == 0,][,-1]
  y1=setTrain[setTrain$OS_bin == 1,][,-1]
  if (typeVariationTtest == "equal"){
    do.Ttest <- function(i,x,y){
      dataPart <- t.test(x1[,i], y1[,i], var.equal = T, alternative = c("two.sided"))
      p.dataPart <- dataPart$p.value
    }
    
  }else if (typeVariationTtest == "noequal"){
    do.Ttest <- function(i,x,y){
      dataPart <- t.test(x[,i], y[,i], var.equal = F, alternative = c("two.sided"))
      p.dataPart <- dataPart$p.value
    }
  }  
  no.feat <- ncol(x1) 
  Pvalue <- sapply(1:no.feat, do.Ttest, x = x1, y = y1)
  adjustPvalue <- p.adjust(Pvalue, method = "hochberg")
  result<-as.data.frame(cbind(Pvalue,adjustPvalue))  
  names(result) <- c("Pvalue","adjustPvalue")
  row.names(result) <- NULL 
  nameVar <- colnames(x1)
  var.imp0 <- cbind(nameVar,result)
  var.imp1 <- var.imp0[which(adjustPvalue < 0.05),] 
  var.imp <- var.imp1[order(var.imp1$adjustPvalue,decreasing = F),]
  return(var.imp)
}
