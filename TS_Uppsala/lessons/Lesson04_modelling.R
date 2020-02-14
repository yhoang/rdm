#
# Build models
#
# We have identified informative variables. 
# What we can do with them? 
# We can build predictive models using machine learning algorithm. 
# We will use Random Forest algorithm 
# We start by installing randomForest package. 
# > install.packages("randomForest")
# Installing package into ‘/Users/rudnicki/Library/R/3.4/library’
# (as ‘lib’ is unspecified)
# próbowanie adresu URL 'https://cran.rstudio.com/bin/macosx/el-capitan/contrib/3.4/randomForest_4.6-12.tgz'
# Content type 'application/x-gzip' length 176377 bytes (172 KB)
# ==================================================
#  downloaded 172 KB
#
#
# The downloaded binary packages are in
# /var/folders/4j/lyt_c98s1b147vfnlq9h2hrc0000gp/T//RtmpUi0OGF/downloaded_packages
# > library(randomForest)
# randomForest 4.6-12
# Type rfNews() to see new features/changes/bug fixes.
# >
#
#
#
# ComputeMCC<-function(Conf){
# TP <- Conf[1,1]
# FN <- Conf[1,2]
# FP <- Conf[2,1]
# TN <- Conf[2,2]
# mcc <- ((TP*TN)-(FP*FN))/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN))
# return(mcc)
#}
#
#
#
#
#> randomForest(x=CN_fast[,IG.2D.full.mdfs$order[1:10]],
#  y=as.factor(CN_response),ntree=500,do.trace = 100) -> result.rf.10
#> randomForest(x=CN_fast[,IG.2D.full.mdfs$order[1:10]],y=as.factor(CN_response),ntree=500,do.trace = 100) -> result.rf.10
#ntree      OOB      1      2
#100:  24.83% 12.15% 60.53%
#200:  25.52% 14.02% 57.89%
#300:  24.83% 14.02% 55.26%
#400:  23.45% 12.15% 55.26%
#500:  23.45% 11.21% 57.89%
#> 
#
#> ComputeMCC(result.rf.10$confusion)
#[1] 0.3150567
#
#> result.rf$err.rate[1:10,]
#OOB         0         1
#[1,] 0.3846154 0.3000000 0.6666667
#[2,] 0.2978723 0.2222222 0.5454545
#[3,] 0.2500000 0.1904762 0.4285714
#[4,] 0.2357724 0.1612903 0.4666667
#[5,] 0.2213740 0.1428571 0.4545455
#[6,] 0.2408759 0.1800000 0.4054054
#[7,] 0.2428571 0.1764706 0.4210526
#[8,] 0.2323944 0.1730769 0.3947368
#[9,] 0.2569444 0.1886792 0.4473684
#[10,] 0.2222222 0.1603774 0.3947368
#> result.rf$confusion
#0  1 class.error
#0 99  8  0.07476636
#1 21 17  0.55263158
#> result.rf$votes[1:10,]
#0          1
#GSM1105179 0.3488372 0.65116279
#GSM1105167 0.9275362 0.07246377
#GSM1105161 0.9183673 0.08163265
#GSM1105287 0.9777778 0.02222222
#GSM1105307 1.0000000 0.00000000
#GSM1105189 0.8870968 0.11290323
#GSM1105301 0.9895288 0.01047120
#GSM1105160 0.9350649 0.06493506
#GSM1105183 0.8135593 0.18644068
#GSM1105211 0.2459016 0.75409836
#




