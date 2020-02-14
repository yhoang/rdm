CalculateImpVar1D = function(typeFeatureSelection,setTrain){
  
  #
  # We start by computing information gain for all variables. 
  # This is general function that can perform  multi-dimensional exhaustive search
  # Here it is called only in 1D. 
  # Check manual for parameters
  # 
  IGs0<-ComputeMaxInfoGains(acceleration.type = "scalar", dimensions = 1, divisions = 5,
                            discretizations = 30, range = 0.9, reduce.method = 'max',
                            data = as.matrix(setTrain[,-1]),
                            decision = setTrain[,1])
  length.IGs = length(IGs0)
  # we get marker names from columns (skipping the first one )
  gene.names<-names(as.data.frame(setTrain[,-1]))
  # and created dataframe containing IGs and corresponding variable names 
  completeIG = as.data.frame(cbind(gene.names,IGs0))
  # and assing names to columns
  names(completeIG) = c('marker_name','IGs_max')
  
  # now we set parameters for the computations of p-values for IGs
  # minimal number of variables that are considered random
  val.min.irr.vars.num = min(length.IGs%/%2,30)
  # maximal number of variables with small IG that are ignored in computing the distribution  
  val.max.ign.low.ig.vars.num = val.min.irr.vars.num%/%3 
  # and call the function to estimate the parameters of irrelevant variables 
  # and assign p-values to all IGs. 
  res = MDFS(IGs = IGs0, dimensions = 1, divisions = 5, response.divisions = 1, 
             ig.in.bits = TRUE, ig.doubled = FALSE, one.dim.mode = "exp", estim.irr.vars.num = TRUE, 
             min.irr.vars.num = val.min.irr.vars.num,
             max.ign.low.ig.vars.num = val.max.ign.low.ig.vars.num,
             max.iterations = 20, acceptable.error = 0.05, p.adjust.method = "hochberg") 
  
  indexImp <- RelevantVariables(res,level = 0.05)
  result <- as.data.frame(cbind(cbind(unlist(res[[4]][indexImp]), unlist(res[[5]][indexImp])), unlist(IGs0[indexImp])))
  row.names(result) <- NULL 
  names(result) <- c('Pvalue',"adjustPvalue",'IGmax')
  nameVar <- gene.names[indexImp]
  var.imp <- cbind(nameVar,result)
  return(var.imp)
}
