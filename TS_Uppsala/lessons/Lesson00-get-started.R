# Lesson 0
# Preparation of work environment
# 
# Before we begin we need to install all required tools
#
# R (instruction from the Bioconductor site)
#
#Install R
#
# Download the most recent version of R. 
# The R FAQs and the R Installation and Administration Manual contain detailed instructions 
# for installing R on various platforms (Linux, OS X, and Windows being the main ones).
# Start the R program; on Windows and OS X, this will usually mean double-clicking on the 
# R application, on UNIX-like systems, type “R” at a shell prompt.
# As a first step with R, start the R help browser by typing help.start() in the R command window. 
# $ For help on any function, e.g. the “mean” function, type ? mean.

#
# Install RStudio from https://www.rstudio.com/products/rstudio/download/#download
#
# 
# Install Bioconductor Packages
#
#Use the biocLite.R script to install Bioconductor packages. 
#To install core packages, type the following in an R command window:
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()
# Install specific packages, e.g., “GenomicFeatures” and “AnnotationDbi”, with
biocLite(c("GenomicFeatures", "AnnotationDbi"))
The biocLite() function (in the BiocInstaller package installed by the biocLite.R script) 
  R.has arguments that change its default behavior; type ?biocLite for further help.

# 
# Install/start Bioconductor
source("https://bioconductor.org/biocLite.R")
#
# upgrade to newest versions of packages
biocLite()
#
#
# install required libraries
#
install.packages("dplyr")
install.packages("qdapRegex")
biocLite("sva")
#
# load required libraries
#
library(qdapRegex)
library(dplyr)
library(sva)
#
#
# 