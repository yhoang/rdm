#
#
# Lesson 2.
# Basic Analysis 
#
#
# We start by reading the data saved in the previous lesson
#
#
#> load("Important_data_from_FS_lesson01.Rdata")
#
#
# In MyData data.frame data for each patient is stored as a single column. 
# This was convenient for parsing, and joining the data, but now we will switch to analysis. 
# Here we want to have columns corresponding to genetic markers. 
# To this end we transpose the dataframe 
# 
#
#t(MyData) -> MyData.t
#
# Transposition ia a matrix operation and the result is matrix, not dataframe
#
#> is.data.frame(MyData)
#[1] TRUE
#> is.data.frame(MyData.t )
#[1] FALSE
#
# we need to convert the matrix to dataframe
#
#
# as.data.frame(MyData.t )-> MyData.t
#> is.data.frame(MyData.t )
# [1] TRUE
#
# MyData was created by merging 4 datasets. 
# In particular 2 types of microarrays were used - with 44K probes and 105K probes. 
# We should expect that significant batch effects can be present
# We have to remove them 
# We will use Bioconductor library for that
#
# We start by creating vector with one number per sample, corresponding to the batch
#
#
#> batch.effect.mask <- c(rep.int(1,dim(Data.105)[2]-2),rep.int(2,dim(Data.44.1)[2]-2),rep.int(3,dim(Data.44.2)[2]-2),rep.int(4,dim(Data.44.3)[2]-2))
#> batch.effect.mask
#[1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#[49] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#[97] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
#[145] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3
#[193] 3 3 4 4 4 4 4
#> length(batch.effect.mask)
#[1] 199
#> dim(MyData.t)
#[1]   199 38839
#
#
# We will now do two adjustments 
# First without giving a reference batch (all batches are equally important)
# 
# > ComBat(dat=MyData,mod=NULL,batch=batch.effect.mask)-> combat.0
# Found4batches
# Adjusting for0covariate(s) or covariate level(s)
# Standardizing Data across genes
# Fitting L/S model and finding priors
# Finding parametric adjustments
# Adjusting the Data
#
#
# Second one with the largest batch given as reference 
#
# > ComBat(dat=MyData,mod=NULL,batch=batch.effect.mask,ref.batch=1)-> combat.1
# Using batch = 1 as a reference batch (this batch won't change)
#
# Found4batches
# Adjusting for0covariate(s) or covariate level(s)
# Standardizing Data across genes
# Fitting L/S model and finding priors
# Finding parametric adjustments
# Adjusting the Data
    
#
# Lets take a look at results
# To this end we check correlations between corrected and raw data, as
# well as between two methods of correction
# 
# We will look from both perspectives - individual genes and objects
#
# First we define few useful variables
#> correlations.0.raw.genes <- vector("numeric",dim(MyData)[1])
#> correlations.1.raw.genes <- vector("numeric",dim(MyData)[1])
#> correlations.1.raw.objects <- vector("numeric",dim(MyData)[2])
#> correlations.0.raw.objects <- vector("numeric",dim(MyData)[2])
#> correlations.0.1.objects <- vector("numeric",dim(MyData)[2])
#
# Then we create transposed versions of adjusted matrices
# Wwe already have the transposed version of MyData form the previous lesson. 
# If not we may create it in the same way
# 
#> t(combat.1) -> combat.1.t
#> t(combat.0) -> combat.0.t
#> dim(combat.1)
#[1] 38839   199
#> dim(MyData)
#[1] 38839   199
#> for (i in 1:199) {
#  + correlations.1.raw.objects[i] <- cor(MyData[,i],combat.1[,i])
#  + correlations.0.raw.objects[i] <- cor(MyData[,i],combat.0[,i])
#  + correlations.0.1.objects[i] <- cor(combat.1[,i],combat.0[,i])
#  + }
#> summary(correlations.0.1.objects)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.9212  0.9768  0.9847  0.9799  0.9883  0.9962 
#> summary(correlations.0.raw.objects)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.8713  0.9512  0.9813  0.9677  0.9874  0.9962 
#> summary(correlations.1.raw.objects)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.6274  0.8938  1.0000  0.9445  1.0000  1.0000 
#> 
#> for (i in 1:38839) {
#  + correlations.1.raw.genes[i] <- cor(MyData.t[,i],combat.1.t[,i])
#  + correlations.0.raw.genes[i] <- cor(MyData.t[,i],combat.0.t[,i])
#  + correlations.0.1.genes[i] <- cor(combat.1.t[,i],combat.0.t[,i])
#}
# > summary(correlations.0.1.genes)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.9691  0.9992  0.9996  0.9994  0.9998  1.0000 
# > summary(correlations.0.raw.genes)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.7502  0.9505  0.9744  0.9642  0.9873  0.9998 
# > summary(correlations.1.raw.genes)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.6893  0.9400  0.9690  0.9566  0.9846  0.9998 
# >
#
# We can watch histograms instead
#
#> hist(correlations.0.1.genes,breaks = 500)
#> hist(correlations.0.raw.genes,breaks = 500)
#> hist(correlations.1.raw.genes,breaks = 500)
#
# Now we switch to the cleaned and adjusted data from the CAMDA neuroblastoma challenge
# This is the subset of the same data that we have worked so far, but limited to 145 
# subjects for whom the clinicla endpoint is known
# > load("CNV.Rdata")
#
#> ls(pattern="CNV")
#[1] "CNVset"
#> 
# The data is transposed - each row holds a complete record for a single subject. 
# Each column is a vector, holding data for all objects
# This setup is more convenient for modelling since R naturally uses columns in dataframes 
# as vector variables. 
#
#
#> CNVset[1:10,1:5]
#OS_bin  (-)3xSLv1 A_14_P122148  A_14_P113625 A_14_P103559
#GSM1105179      1 0.75751590   0.09772830 -0.0009319973  -0.05213376
#GSM1105167      0 0.00000000   0.11079480  0.0515082000  -0.19931270
#GSM1105161      0 0.39861620   0.08371334  0.1654334000  -0.01880219
#GSM1105287      0 0.00000000   0.02073065  0.1697223000   0.02487332
#GSM1105307      0 0.00000000   0.05553635  0.1055900000   0.09980719
#GSM1105189      0 0.00000000   0.04480577 -0.0126158600  -0.25267710
#GSM1105301      0 0.00000000   0.05161414  0.1520014000  -0.02786254
#GSM1105160      0 0.03264452   0.55806870  0.2030911000   0.12123830
#GSM1105183      0 0.34381110   0.10462190 -0.0098656960  -0.06507628
#GSM1105211      0 0.43069990   0.03191284 -0.0711156300  -0.08944219
#> 
# The first column holds the clinical end-point - overall survival of the patient. 
#
# The overall distribution is following
# summary(unlist(CNVset[,2:dim(CNVset)[2]]))
#
#        Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
# -2.6330430 -0.0698338  0.0000000 -0.0004566  0.0683068  3.0019580 
#
#> hist(unlist(CNVset[,2:dim(CNVset)[1]]),breaks = 1000)
#
# We look for variables (genetic markers) that are different for two classes of patients
# survivers and non-survivers
# survivers are class 0, non-survivers class 1. 
#
# We use t-test for that
#
#> x1 <- CNVset[CNVset$OS_bin == 0,2]
#> x2 <- CNVset[CNVset$OS_bin == 1,2]
#> t.test(x1,x2,var.equal = F, alternative = "two.sided")
#
#Welch Two Sample t-test
#
#data:  x1 and x2
#t = 0.39594, df = 55.049, p-value = 0.6937
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.1053324  0.1572030
#sample estimates:
#  mean of x   mean of y 
#0.028693174 0.002757882 
#
# Let's define function that will help us explore 
# the data in a more automatic way
# We start with dividing the dataset into two sparts split on decision variables
#
#> x0 <- CNVset[CNVset$OS_bin == 0,-1]
#> x1 <- CNVset[CNVset$OS_bin == 1,-1]
#
#  then a specialised do.Ttest function
# 
#> do.Ttest <- function(i,y1,y2) { t.test(y1[,i],y2[,i],var.equal=FALSE,alternative="two.sided")}
#
# We may explore few more points
#> do.Ttest(2,x0,x1)
#
#Welch Two Sample t-test
#
#data:  y1[, i] and y2[, i]
#t = -0.16022, df = 64.441, p-value = 0.8732
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.03934824  0.03350463
#sample estimates:
#  mean of x  mean of y 
#0.06748039 0.07040219 
#
#> do.Ttest(3,x0,x1)
#
#Welch Two Sample t-test
#
#data:  y1[, i] and y2[, i]
#t = 3.2096, df = 69.507, p-value = 0.002012
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  0.02474446 0.10599424
#sample estimates:
#  mean of x  mean of y 
#0.07843063 0.01306127 
#
#> do.Ttest(4,x0,x1)
#
#Welch Two Sample t-test
#
#data:  y1[, i] and y2[, i]
#t = -0.01446, df = 69.231, p-value = 0.9885
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.04743574  0.04675298
#sample estimates:
#  mean of x   mean of y 
#-0.07327331 -0.07293193 
#
#> do.Ttest(5,x0,x1)
#
#Welch Two Sample t-test
#
#data:  y1[, i] and y2[, i]
#t = -0.27333, df = 61.178, p-value = 0.7855
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.03345007  0.02540478
#sample estimates:
#  mean of x   mean of y 
#0.000465192 0.004487833 
#
#  We have seen that we have found somethin with p-value lower than 0.05 for i=3
# 
# We may look at it
#> plot(x=x0.x,y=x0[,3],xlim=c(0,1))
#> points(x=x1.x,y=x1[,3])
#
#
# lets put some other value - let it be 7200
#> do.Ttest(7200,x0,x1)
#
#Welch Two Sample t-test
#
#data:  y1[, i] and y2[, i]
#t = 6.1269, df = 69.189, p-value = 4.837e-08
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  0.06867888 0.13499191
#sample estimates:
#  mean of x  mean of y 
#0.0708375 -0.0309979 
#> plot(x=x0.x,y=x0[,7200],xlim=c(0,1))
#> points(x=x1.x,y=x1[,7200])
#
#
# Lets first open the file CalculateImpVarTtest.R from the scripts directory 
#
# After analysis of this function we may use it
#
#> source("./scripts/CalculateImpVarTtest.R")
#> var.imp.tt <- CalculateImpVarTtest(setTrain = CNVset, typeVariationTtest = "noequal")
#> var.imp.tt
#nameVar       Pvalue adjustPvalue
#7200  A_14_P137247 4.836886e-08  0.001891948
#17890 A_14_P125544 2.067227e-07  0.008085751
#24890 A_14_P131197 6.037537e-07  0.023614619
#28911 A_14_P126579 7.434081e-07  0.029076179
#32077 A_14_P117576 8.629765e-07  0.033751876
#
#




