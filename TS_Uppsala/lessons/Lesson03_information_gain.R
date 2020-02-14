#
# Now we introduce another method for identification of relevant variables, 
# that is based on information theory
# 
# We first load the file scripts/CalculateImpVar1D.R 
# and analyse the function implemented there
#
# then we need to install CuCubes package. 
# There is the old version available on CRAN, but here we can use the newest version
# It will be very soon uploaded to CRAN. We will also most likely change the name of 
# the library to MDFS (multi-dimensional feature selection)
#
# install.packages("./installs/CuCubes_0.2.15.tar.gz", 
#     repos = NULL, type="source")
# install.packages("./installs/CuCubes_0.2.15.tar.gz", repos = NULL, type="source")
# Installing package into ‘/Users/rudnicki/Library/R/3.4/library’
# (as ‘lib’ is unspecified)
#* installing *source* package ‘CuCubes’ ...
#** libs
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c datafile.cpp -o datafile.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c discretize.cpp -o discretize.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c discretizedfile.cpp -o discretizedfile.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c mdfs_common.cpp -o mdfs_common.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c mdfs_launcher.cpp -o mdfs_launcher.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c mdfs_scalar.cpp -o mdfs_scalar.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c odfs.cpp -o odfs.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c odfs_common.cpp -o odfs_common.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c odfs_r.cpp -o odfs_r.o
#clang++ -std=gnu++11 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2 -c stats.cpp -o stats.o
#clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o CuCubes.so datafile.o discretize.o discretizedfile.o mdfs_common.o mdfs_launcher.o mdfs_scalar.o odfs.o odfs_common.o odfs_r.o stats.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
#installing to /Users/rudnicki/Library/R/3.4/library/CuCubes/libs
#** R
#** data
#*** moving datasets to lazyload DB
#** preparing package for lazy loading
#** help
#*** installing help indices
#** building package indices
#** testing if installed package can be loaded
#* DONE (CuCubes)
#> 
#
#
# now we load CuCubes library
# library(CuCubes)
#
# Let's explore how the function finds relevant variables
# 
# First we compute maximal information gain for each variable. 
# ComputeMaxInfoGains(
#  acceleration.type = "scalar", dimensions = 1, 
#  divisions = 5,discretizations = 30, range = 0.9, 
# reduce.method = 'max', data = as.matrix(CNVset[,-1]),
# decision = CNVset[,1],seed=13) -> IG.1D.1
# ComputeMaxInfoGains(acceleration.type = "scalar", dimensions = 1, divisions = 5,discretizations = 30, range = 0.9, reduce.method = 'max', data = as.matrix(CNVset[,-1]),decision = CNVset[,1],seed=13) -> IG.1D.1
#
# Lets do the same with different seed
# ComputeMaxInfoGains(
#   acceleration.type = "scalar", dimensions = 1, 
#   divisions = 5,discretizations = 30, range = 0.9, 
#   reduce.method = 'max',data = as.matrix(CNVset[,-1]),
#   decision = CNVset[,1],seed=1335) -> IG.1D.2
# ComputeMaxInfoGains(acceleration.type = "scalar", dimensions = 1, divisions = 5,discretizations = 30, range = 0.9, reduce.method = 'max',data = as.matrix(CNVset[,-1]),decision = CNVset[,1],seed=1335) -> IG.1D.2
#
# Lets plot the results
#> plot(IG.1D.1[order(IG.1D.1)],pch=19,cex=0.2)
#
# Lets check what is correlation between results from two runs
#
#
#cor(IG.1D.1,IG.1D.2) -> cor.res
#cor.res *cor.res
# 
# and plot the results 
#
# plot(IG.1D.1,IG.1D.2,cex=0.3,pch=19)
# We see that the highest scoring values are rather unusual. 
# But we must estimate the statistical parameters of the distribution 
# This is the task for the MDFS function. 
# 
# This function fits theoretical extreme value distribution to the results 
# of IG computations. 
#
# You need to supply the same number of divisions (5 in this case)
# There are three possible choices to model the probability distribution of 
# non-informative variables
# "exp" - the generic distribution with exponential tail
# "lin" - linear function of chi-squared distribution
# "raw" - chi-squared distribution
# The "exp" option is most appropriate for large number of discretisations
# The "lin" is suitable for few discretisations
# The "raw" assumes that the distribution is simply a chi-squared 
# suitable for discrete variables or single discretisation of continuous variable
#
# MDFS(IGs = IG.1D.1, dimensions = 1, divisions = 5, 
#     response.divisions = 1, ig.in.bits = TRUE, ig.doubled = FALSE, 
#     one.dim.mode = "exp", estim.irr.vars.num = TRUE, 
#     min.irr.vars.num = 1000, max.ign.low.ig.vars.num = 100, 
#     max.iterations = 20, acceptable.error = 0.1, 
#     p.adjust.method = "hochberg") -> result.mdfs.1
# 
# MDFS(IGs = IG.1D.1, dimensions = 1, divisions = 5, response.divisions = 1, ig.in.bits = TRUE, ig.doubled = FALSE, one.dim.mode = "exp", estim.irr.vars.num = TRUE, min.irr.vars.num = 1000, max.ign.low.ig.vars.num = 100, max.iterations = 20, acceptable.error = 0.1, p.adjust.method = "hochberg") -> result.mdfs.1
#
# There is a warning that error of the estimated parameter of the distribution is large. 
#
# This does not necessarily mean that there is something wrong with the function
# The data itself does not fit very well to the assumed model - model assumes that variables are either significant or not, 
# however, in this data set, there is a large pool of variables with weak 
# correlations with relevant variables, that are visible as a part of p-p plot 
# that inflects down from the relatively straight line. 
# We can look at the results 
#
# plot(result.mdfs.1)
#
# Now let's open the file CalculateImpVar1D 
# and look how the complete process of identification of relevant 
# features can be performed.
# You may run the function to obtain the list of all relevant variables. 
# var.imp.1D <- CalculateImpVar1D(setTrain = CNVset, typeFeatureSelection = "1D")
# var.imp.1D <- CalculateImpVar1D(setTrain = CNVset, 
#     typeFeatureSelection = "1D")
#
#  
# Now we will try to perform analysis of the same problem using 2D analysis. 
# The 2D analysis for set of variables X involves computation of the following function 
# IGmax(Xi) = max_{Xj}(IG(DEC,Xi|Xj ))  forall Xi in X, and for all Xj in X. 
# This is O(N^2) problem. It would take few hours on a CPU (although it takes only 
# few minutes for the GPU version ).
# We have prepared the special set for the current workshop. 
# It was prepared in the floowing manner. We have performed the analysis previously. 
# We selected roughly 1000 variables with the highest impact and supplemented them with all 
# variables that are not correlated with any of them (correlation coefficien r<0.5). 
# Resulting data has 2961 variables. 
# One should bear in mind that the data set is not the original hence the results 
# are not necessarily biologically meaningful
# We load the smaller dataset
# load("CN_training.Rdata")
#
# there are two new objects in the environment: 
#
# 
# > ls()
#
# "CN_fast"      "CN_response" 
#
# CN_fast is the reduced dataset, 
# CN_response is clinical end_point
#
# igf<-ComputeMaxInfoGains(data=CN_fast,decision=CN_response,dimension=2,divisions=1,discretizations=30,range=0.8)
#
# This may take few minutes on your laptop. It takes nearly 5 minutes on my system. 
#> start.time <- proc.time(); igf <-ComputeMaxInfoGains(data=CN_fast,decision=CN_response,dimension=2,divisions=1,discretizations=30,range=0.8);end.time <-proc.time(); print(end.time-start.time)
# użytkownik     system   upłynęło 
# 282.041      0.566    283.048 
# You may try to test timing for a few smaller subsets first. 
#
# start.time <- proc.time(); igf.100 <-ComputeMaxInfoGains(
#   data=CN_fast[,1:100], decision=CN_response,dimension=2,divisions=1,
#   discretizations=30,range=0.8);end.time <-proc.time(); print(end.time-start.time)
# start.time <- proc.time(); igf.100 <-ComputeMaxInfoGains(data=CN_fast[,1:100], decision=CN_response,dimension=2,divisions=1,discretizations=30,range=0.8);end.time <-proc.time(); print(end.time-start.time)
#
#
# Cols <- c( 100,200,500,1000)
# Timings <- list()
#for ( i in 1:4 ) {
#  start.time <- proc.time(); 
#  igf.tmp <-ComputeMaxInfoGains(data=CN_fast[,1:Cols[i]], decision=CN_response,dimension=2,divisions=1, discretizations=30,range=0.8)
#  end.time <-proc.time();
#  Timings[[i]]<-end.time-start.time
#  print(paste(Cols[i],Timings[[i]][1]))
#}
#
#
