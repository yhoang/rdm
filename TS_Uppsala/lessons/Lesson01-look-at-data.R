# Lesson 1.
# Look at the data
# We work with the neuroblastoma data from the CAMDA neuroblastoma challenge
# First we look at the structure of the single file from the microarray experiment
# You will find few two example files 
# GSM1105244_US22502540_251469818648_1_2_105k_T.txt
# GSM1105244_US22502540_251469818648_1_2_105k_T.txt
setwd("~/ownCloud/workshop_Uppsala/FS")
file.raw.GSM1105244 = read.delim2(file = 'data_txt/GSM1105244_US22502540_251469818648_1_2_105k_T.txt',skip=9)
View(file.raw.GSM1105244)
#
# We can check the summary of the file
#
summary(file.raw.GSM1105244)
# R is great modelling environment, however, reading the data in in the 
# correct format from the text file can be a pain. You allways need to check what is 
# the type of your data as seen by R
#
file.raw.GSM1105244$gBGMeanSignal[1:100]
> file.raw.GSM1105244$gBGMeanSignal[1:100]
#[1] 18.9913 19.181  19.1006 19.6453 19.3185 19.4639 19.8524 19.9727 20.0617 20.5558 19.9287
#[12] 19.7014 19.6508 19.7179 19.8863 19.7008 19.5765 20.1064 19.1992 19.0544 19.5088 19.7165
#[23] 19.5214 19.8055 19.796  19.7235 19.2545 19.7656 19.0272 19.0895 19.5    19.7369 19.2606
#[34] 19.7118 20.1647 19.7613 19.8118 20.6329 19.5373 20.3384 20.3862 19.6074 19.9884 20.4417
#[45] 20.1269 20.1965 20.6185 19.9437 20.2544 20.4517 20.3333 20.4368 20.4178 20.3864 20.4722
#[56] 20.5115 19.8372 20.1977 20.0521 21.0707 21.3031 20.3656 20.2625 20.2331 20.4192 20.4571
#[67] 20.4696 20.2928 20.0575 20.1868 20.365  20.4961 20.5356 19.7915 19.8337 19.9514 19.7739
#[78] 19.3973 19.7481 19.5835 19.9348 19.2758 19.9981 19.5778 20.1914 19.8352 19.115  20.0527
#[89] 20.1301 19.831  20.2657 19.756  19.4708 19.6257 19.356  19.1771 19.6654 19.754  20.1417
#[100] 19.9532
#8747 Levels: 137.516 15.25 15.4848 15.6452 15.871 15.96 155.111 16.0323 16.0571 16.125 ... 84.3333
#> 
is.numeric(file.raw.GSM1105244$gBGMeanSignal)
# [1] FALSE
#
# We may want to check all data
for (i in 1:dim(file.raw.GSM1105244)[2]) {
  print(paste(i," ",names(file.raw.GSM1105244)[i]," ",is.numeric(file.raw.GSM1105244[,i])))
}
#[1] "1   FEATURES   FALSE"
#[1] "2   FeatureNum   TRUE"
#[1] "3   Row   TRUE"
#[1] "4   Col   TRUE"
#[1] "5   SubTypeMask   TRUE"
#[1] "6   ControlType   TRUE"
#[1] "7   ProbeName   FALSE"
#[1] "8   SystematicName   FALSE"
#[1] "9   PositionX   FALSE"
#[1] "10   PositionY   FALSE"
#[1] "11   LogRatio   FALSE"
#[1] "12   LogRatioError   FALSE"
#[1] "13   PValueLogRatio   FALSE"
#[1] "14   gProcessedSignal   FALSE"
#[1] "15   rProcessedSignal   FALSE"
#[1] "16   gProcessedSigError   FALSE"
#[1] "17   rProcessedSigError   FALSE"
#[1] "18   gMedianSignal   FALSE"
#[1] "19   rMedianSignal   FALSE"
#[1] "20   gBGMedianSignal   FALSE"
#[1] "21   rBGMedianSignal   FALSE"
#[1] "22   gBGPixSDev   FALSE"
#[1] "23   rBGPixSDev   FALSE"
#[1] "24   gIsSaturated   TRUE"
#[1] "25   rIsSaturated   TRUE"
#[1] "26   gIsFeatNonUnifOL   TRUE"
#[1] "27   rIsFeatNonUnifOL   TRUE"
#[1] "28   gIsBGNonUnifOL   TRUE"
#[1] "29   rIsBGNonUnifOL   TRUE"
#[1] "30   gIsFeatPopnOL   TRUE"
#[1] "31   rIsFeatPopnOL   TRUE"
#[1] "32   gIsBGPopnOL   TRUE"
#[1] "33   rIsBGPopnOL   TRUE"
#[1] "34   IsManualFlag   TRUE"
#[1] "35   gBGSubSignal   FALSE"
#[1] "36   rBGSubSignal   FALSE"
#[1] "37   gIsPosAndSignif   TRUE"
#[1] "38   rIsPosAndSignif   TRUE"
#[1] "39   gIsWellAboveBG   TRUE"
#[1] "40   rIsWellAboveBG   TRUE"
#[1] "41   SpotExtentX   FALSE"
#[1] "42   gBGMeanSignal   FALSE"
#[1] "43   rBGMeanSignal   FALSE"
#
# Lets look at the other file 
#
file.raw.GSM1105159 = read.delim2(file = 'data_txt/GSM1105159_US22502540_251270010269_44k_R.txt',skip=9)
View(file.raw.GSM1105159)
dim(file.raw.GSM1105159)
for (i in 1:90) print(paste(i," ",names(file.raw.GSM1105159)[i]," ",is.numeric(file.raw.GSM1105159[,i])))
#
#
# We have multiple files, each file may be slightly different.
# A single column ( LogRatio ) in each file carries the interesting signal 
# 
# The data has been already collected in four files, each agggregating data from a series of experiments
set44_1 <- as.data.frame(read.delim2(file = "data_txt/GSE45476-GPL2873_series_matrix.txt", skip = 35, na.strings=c(" "," "," ","NA"), dec = "."))
set44_2 <- as.data.frame(read.delim2(file = "data_txt/GSE45476-GPL16865_series_matrix.txt", skip = 35, na.strings=c(" "," "," ","NA"), dec = "."))
set44_3 <- as.data.frame(read.delim2(file = "data_txt/GSE45476-GPL8355_series_matrix.txt", skip = 35, na.strings=c(" "," "," ","NA"), dec = "."))
set105 <- as.data.frame(read.delim2(file = "data_txt/GSE45478_series_matrix.txt", skip = 30, na.strings=c(" "," "," ","NA"), dec = "."))
# Let's look at the data again
# 
# 
View(set105)
View(set44_1)
View(set44_2)
View(set44_3)
#In particular look at the row 19 of set44_* series
set44_1[19,]
set44_2[19,]
set44_3[19,]
#
# and row 20 of set105 
#
# We can see, that there are two different types of samples associated with chanel2
# It is either "Promega Reference DNA" or "Tumor DNA" 
# !Sample_source_name_ch2 Promega Reference DNA 
# !Sample_label_ch2 Cy5
# Lets check how many variants of each type are present 
#> dim(set44_1)
#[1] 42680    57
#> sum(set44_1[19,]=="Promega Reference DNA")
#[1] 33
#> sum(set44_1[19,]=="Tumor DNA")
#[1] 23
#> dim(set44_2)
#[1] 43934    16
#> sum(set44_2[19,]=="Tumor DNA")
#[1] 0
#> sum(set44_2[19,]=="Promega Reference DNA")
#[1] 15
#> dim(set105)
#[1] 104747    124
#> sum(set105[20,]=="Tumor DNA")
#[1] 0
#> sum(set105[20,]=="Promega Reference DNA")
#[1] 123
#
# we see that there are 24 samples 
#
#> dim(set44_3)
#[1] 42650     6
#> sum(set44_3[19,]=="Promega Reference DNA")
#[1] 4
#> sum(set44_3[19,]=="Tumor DNA")
#[1] 1
# In each case channel 2 is connected with Cy5 label
#> dim(set44_1)
#[1] 42680    57
#> sum(set44_1[29,]=="Cy5")
#[1] 56
#> dim(set44_2)
#[1] 43934    16
#> sum(set44_2[26,]=="Cy5")
#[1] 15
#> dim(set44_3)
#[1] 42650     6
#sum(set44_3[29,]=="Cy5")
#[1] 5
#> dim(set105)
#[1] 104747    124
#> sum(set105[27,]=="Cy5")
#[1] 123

# The labels are switched in 24 cases. 
# We need to change polarity (sign) for these samples
# one more problem with the data 
# Data files for single matrix contain probe names, here we have only numbers. 
# Finally - all values are stored as factors - this is because columns are not uniformly numerical
# We need to convert all columns to numerical values. 
# there are two methods for that 
# We can either do this for the datasets that are already in the memory, or we can read 
# appropriate range of raws into R and.  
# Lets takcle the third problem first. 
data105[104746:104747,1:4]
# X.Sample_title             NB78             NB79             NB80
# 104746                   105072 2.266333452e-002 1.853094204e-002 2.688997522e-002
# 104747 !series_matrix_table_end  
# We need to skip more rows, and read only required rows, without the last one. 
# We start with set105 
#> dim(set105)
#[1] 104747    124

# We have skipped 30 lines previously,now we need to skip 44 more lines (43 numbered lines + header line)
#
> read.table(file='data_txt/GSE45478_series_matrix.txt',skip=74,nrows=104702,na.strings=c(" ","NA"), dec = ".",header=TRUE) -> newData105
# We may check whether new table is numeric
#> is.numeric(newData105[,2])
#[1] TRUE
#
# One column is
#
# Lets check it for all columns
# > vector("logical",length=124)-> test.numeric
#> for (i in 1:124) test.numeric[i]<- is.numeric(newData105[,i])
#> sum(test.numeric)
#[1] 124
#
# Fine - now lets move to three other matrices
#
# for set44_1 we need to skip 35+46 = 81 lines
# 
#> dim(set44_1)
#[1] 42680    57
#> set44_1[42680,1:5]
#X.Sample_geo_accession GSM1105163 GSM1105164 GSM1105165 GSM1105166
#42680 !series_matrix_table_end  
#> vector("logical",length=57)->test.numeric.1
#
# We need to read 42680-46 - 1 rows (46 more skipped at the beginning and the last line) 
#
newData44_1 <- read.delim2(file = "data_txt/GSE45476-GPL2873_series_matrix.txt", nrows=42633, skip = 81, na.strings=c(" "," "," ","NA"), dec = "."))
#> for (i in 1:57) test.numeric.1[i]<- is.numeric(newData44_1[,i])
#> sum(test.numeric.1)
#[1] 57
#
# Success! 
#
# Lets move on to set44_2
#
#> dim(set44_2)
#[1] 43934    16
#
#> set44_2[41:50,1:2]
#X.Sample_geo_accession        GSM1105220
#41     !Sample_data_row_count             43890
#42 !series_matrix_table_begin                  
#43                     ID_REF        GSM1105220
#44                          1 -9.156921303e-003
#45                          2  0.000000000e+000
#46                          3 -5.593963850e-002
#47                          4  3.580816570e-002
#48                          5 -1.561600439e-001
#49                          6  6.683649294e-003
#50                          7  8.708640932e-002
#
#
#> set44_2[43934,1:5]
#X.Sample_geo_accession GSM1105220 GSM1105221 GSM1105222 GSM1105223
#43934 !series_matrix_table_end                                            
#> 
# we need to remove 43 more rows and read 43934 - 43 - 1 =  43890 rows

# newData44_2 <- read.delim2(file = "data_txt/GSE45476-GPL16865_series_matrix.txt", skip = 79, nrows=43889,na.strings=c(" "," "," ","NA"), dec = ".")
# 
#  dim(newData44_2)
#[1] 43889    16
#> for (i in 1:16) print(is.numeric(newData44_2[,i]))
#
# Success
#
# Move on to set44_3
#
#> data44_3[44:50,1:2]
#X.Sample_geo_accession        GSM1105159
#44     !Sample_data_row_count             42603
#45 !series_matrix_table_begin                  
#46                     ID_REF        GSM1105159
#47                          1 -1.629518539e+000
#48                          2  2.317342178e-001
#49                          3  6.471637486e-002
#50                          4  6.767955881e-002
#
#
#> dim(data44_3)
#[1] 42650     6
#
#> data44_3[42650,]
#X.Sample_geo_accession GSM1105159 GSM1105160 GSM1105161 GSM1105162 GSM1105168
#42650 !series_matrix_table_end                                                       
#
# We skip 35 + 46 lines and read 42650 - 46 -1 = 42303 rows
#
#> newData44_3 <- read.delim2(file = "data_txt/GSE45476-GPL8355_series_matrix.txt", skip = 81, nrows= 42303, na.strings=c(" "," "," ","NA"), dec = ".")
#> for ( i in  1:6) print(is.numeric(newData44_3[,i]))
#
# Success
#
# Now - let's extract headers from the set* files
#
#
#> set44_1[1:46,] -> header44_1
#> set44_2[1:44,] -> header44_2
#> set44_3[1:46,] -> header44_3
#> set105[1:44,] -> header105
#
# And lets check alterntive way of conversion of data that we already have in
# We simply copy a proper data set to a object (we may remove the original later)
# data105<-set105[45:104746,]
# 
# Lets see what is inside
#> data105[1:10,2]
#[1] 4.621185791e-002  -7.000959677e-002 -3.650715666e-001 -1.322347622e-001 -1.208781247e-001
#[6] 1.071723744e-001  1.001886844e-001  2.735540557e-002  -1.148209716e-001 -6.906562336e-002
#103437 Levels:  -1.000009822e-001 -1.000061136e-001 -1.000150216e-001 -1.000276381e-001 ... 
#We followed the "Agilent Oligonucleotide Array-Based CGH for Genomic DNA Analysis protocol”, 
#v. 5.0 (Agilent Technologies). Briefly, 2 ug of sample and reference genomic DNAs 
#(for reference were used Human Genomic DNA: male Cat G1471, female Cat G1521, Promega, 
#Madison, WI) were separately digested with AluI/RsaI restriction enzyme mix (Promega). 
#Fragmented DNA was labeled by direct enzymatic incorporation of fluorescent tags. 
#Genomic DNA was labeled with Cy3-dUTP or Cy5-dUTP (Perkin Elmer) using the Random-Primed 
#Bioprime DNA Labeling kit (Invitrogen Life Technologies). 
#Briefly, 50 ul reaction mix containing dATP, dGTP and dTTP (120 ueach), 
#dUTP (60 uM) and Cy3-dUTP (60 uM) or Cy5-dUTP (60 uM) was incubated with 
#Klenow Fragment (40 units) at 37°C for 2 hrs. Unincorporated nucleotides were 
#removed on Microcon YM-30 filters (Millipore) according to the manufacturer’s 
#protocol. Dye incorporations ... <truncated>
#
# factors still
#
# Simple conversion won't help 
#> as.numeric(data105[1:10,2])
#[1] 84338 42155 28243  8385  5722 54345 52355 75969  4125 41821
#
# we  need to convert factors to characters first
#
#> as.numeric(as.character(data105[1:10,2]))
#[1]  0.04621186 -0.07000960 -0.36507157 -0.13223476 -0.12087812  0.10717237  0.10018868  0.02735541
#[9] -0.11482097 -0.06906562
#> as.numeric(as.character(data105[1:10,2]))==newData105[1:10,2]
#[1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
#> 
# be careful to do it by columns. Conversion by rows will not work
#
#> as.numeric(as.character(data105[1,1:10]))
#[1]    42 84338 17270 22502 12828 75926 57262 90420 26350 19115
# 
#> for (i in 1:124) data105[,i]<-as.numeric(as.character(data105[,i]))
#> for (i in 1:124) print(paste(i,sum(data105[,i]==newData105[,i])))
#[1] "1 104702"
#[1] "2 104702"
#[1] "3 104702"
#[1] "4 104702"
# ...
# [1] "122 104702"
#[1] "123 104702"
#[1] "124 104702"
#
# We have converted now lets deal the sign issue 
#
# First we find which mask
#
#> ConversionMask.1<-vector("logical",length=dim(header44_1)[2])
#> for (i in 1:(length(ConversionMask.1))) if (header44_1[19,i]=="Tumor DNA") {ConversionMask.1[i] <- TRUE}
#> ConversionMask.2<-vector("logical",length=dim(header44_2)[2])
#> for (i in 1:(length(ConversionMask.2))) if (header44_2[19,i]=="Tumor DNA") {ConversionMask.2[i] <- TRUE}
#> ConversionMask.3<-vector("logical",length=dim(header44_3)[2])
#> for (i in 1:(length(ConversionMask.3))) if (header44_3[19,i]=="Tumor DNA") {ConversionMask.3[i] <- TRUE}
#> 

#> newData44_1 -> data44_1
#> for(i in 1:length(ConversionMask.1)) {if (ConversionMask.1[i]) {data44_1[,i]<-data44_1[,i]* (-1)}}
#> data44_1[1,]/newData44_1[1,]
#> sum(data44_1[1,]/newData44_1[1,])
#[1] 11
#> sum(data44_1[1,]/newData44_1[1,]== -1)
#[1] 23
#
#
##> newData44_2 -> data44_2
#> for(i in 1:length(ConversionMask.2)) {if (ConversionMask.2[i]) {data44_2[,i]<-data44_2[,i]* (-1)}}
#> data44_2[1,]/newData44_2[1,]
#> sum(data44_2[1,]/newData44_2[1,])
#[1] 11
#> sum(data44_2[1,]/newData44_2[1,]== -1)
#[1] 23
#
#
#> newData44_2 -> data44_2
#> for(i in 1:length(ConversionMask.2)) {if (ConversionMask.2[i]) {data44_2[,i]<-data44_2[,i]* (-1)}}
#> data44_2[1,]/newData44_2[1,]
#ID_REF GSM1105220 GSM1105221 GSM1105222 GSM1105223 GSM1105224 GSM1105225 GSM1105226 GSM1105227 GSM1105228
#1      1          1          1          1          1          1          1          1          1          1
#GSM1105229 GSM1105230 GSM1105231 GSM1105232 GSM1105233 GSM1105234
#1          1          1          1          1          1          1
#
#
#> newData44_3 -> data44_3
#> for(i in 1:length(ConversionMask.3)) {if (ConversionMask.3[i]) {data44_3[,i]<-data44_3[,i]* (-1)}}
#> data44_3[1,]/newData44_3[1,]
#ID_REF GSM1105159 GSM1105160 GSM1105161 GSM1105162 GSM1105168
#1      1         -1          1          1          1          1
#
#
#
# Finally - lets assign probe names to rows. 
# This will allow us to merge all datasets using probe names as a common key. 
# The probe names are available in the files generated in the single experiments 
# We have three series of matrices with ~44K probes and one series with 105K probes. 
#> read.delim2(file="data_txt/GSM1105165_US22502540_251275013178_44k_T.txt",skip=9,na.strings = c(" "," "," ","NA"), dec = ".") -> raw44_1
#> read.delim2(file="data_txt/GSM1105234_US22502540_251328224481_44k_T.txt",skip=9,na.strings = c(" "," "," ","NA"), dec = ".") -> raw44_2
#> read.delim2(file="data_txt/GSM1105160_US22502540_251270010382_44k_T.txt",skip=9,na.strings = c(" "," "," ","NA"), dec = ".") -> raw44_3
#> read.delim2(file="data_txt/GSM1105244_US22502540_251469818648_1_2_105k_T.txt",skip=9,na.strings = c(" "," "," ","NA"), dec = ".") -> raw105
#> dim(raw105)
#[1] 104702     43
#> dim(newData105)

#[1] 104702    124
#> sum(newData105[,1]==raw105[,2])
#[1] 104702
#> names(newData105)[1:5]
#[1] "ID_REF"     "GSM1105244" "GSM1105245" "GSM1105246" "GSM1105247"
#> names(raw105)[1:7]
#[1] "FEATURES"    "FeatureNum"  "Row"         "Col"         "SubTypeMask" "ControlType" "ProbeName"  
#
# We see that "ID_REF"  field from newData105 is identical to  "FeatureNum" from raw105. 
# Also - feature number is not trivial - it is not equal to row number. 
# 
# Each feature number corresponds to ProbeName (but not vice versa - some the number of unique probe names is smaller than number )
#
#> length(raw44_3$FeatureNum)
#[1] 42603
#  > length(unique(raw44_3$FeatureNum))
#[1] 42603
# length(unique(raw44_3$ProbeName))
#[1] 40032
#
# We will now assign ProbeName field from single experiment to row names in the aggregate data frames
#
#> dim(newData44_1)[1]
#[1] 42633
#> dim(raw44_1)[1]
#[1] 42633
#> sum(newData44_1[,1]==raw44_1[,2])
#[1] 42633
#
#> dim(newData44_2)[1]
#[1] 43890
#> dim(raw44_2)[1]
#[1] 43890
#> sum(newData44_2[,1]==raw44_2[,2])
#[1] 43890
#
#> dim(newData44_3)[1]
#[1] 42303
#> dim(raw44_3)[1]
#[1] 42603
#> sum(newData44_3[,1]==raw44_3[1:42303,2])
#[1] 42303
#
#> newData105$ProbeName <- raw105$ProbeName
#> newData44_1$ProbeName <- raw44_1$ProbeName
#> newData44_2$ProbeName <- raw44_2$ProbeName
#> newData44_3$ProbeName<-raw44_3$ProbeName[1:42303]
#
#
#
#> Common.Names<-intersect(newData105$ProbeName,newData44_1$ProbeName)
#> length(Common.Names)
#[1] 39119
#> Common.Names<-intersect(Common.Names,newData44_2$ProbeName)
#> length(Common.Names)
#[1] 39115
#> Common.Names<-intersect(Common.Names,newData44_3$ProbeName)
#> length(Common.Names)
#[1] 38839
#> Mask44_1 <- newData44_1$ProbeName %in% Common.Names
#> Mask44_2 <- newData44_2$ProbeName %in% Common.Names
#> Mask44_3 <- newData44_3$ProbeName %in% Common.Names
#> Mask105 <- newData105$ProbeName %in% Common.Names
#> sum(Mask105)
#[1] 40104
#> sum(Mask44_1)
#[1] 39540
#> sum(Mask44_2)
#[1] 39579
#> sum(Mask44_3)
#[1] 39536


# We have redundant rows in all sets. But first let us trim all sets to contain just the rows which have ProbeName field in common
# Data.44.1 <- newData44_1[Mask44_1,]
# Data.44.2 <- newData44_2[Mask44_2,]
# Data.44.3 <- newData44_3[Mask44_3,]
# Data.105 <- newData105[Mask105,]
#
#  
#
#> length(unique(Data.44.1$ProbeName))
#[1] 38839
#> length(unique(Data.44.2$ProbeName))
#[1] 38839
#> length(unique(Data.44.3$ProbeName))
#[1] 38839
#> length(unique(Data.105$ProbeName))
#[1] 38839

#
# Data.105 <- Data.105[!duplicated(Data.105$ProbeName),]
# Data.44.1 <- Data.44.1[!duplicated(Data.44.1$ProbeName),]
# Data.44.2 <- Data.44.2[!duplicated(Data.44.2$ProbeName),]
# Data.44.3 <- Data.44.3[!duplicated(Data.44.3$ProbeName),]
#> dim(Data.105)
#> dim(Data.44.1)
#> dim(Data.44.2)
#> dim(Data.44.3)
#
# All datasets contain data for the same subset of unique probes. 
# However, it is in different order in these sets
#
#> sum(Data.44.1$ProbeName[1:10] %in% Data.44.2$ProbeName[1:10])
#[1] 9
#> sum(Data.44.1$ProbeName[1:10] %in% Data.44.3$ProbeName[1:10])
#[1] 10
#> sum(Data.44.2$ProbeName[1:10] %in% Data.44.3$ProbeName[1:10])
#[1] 9
#> sum(Data.44.1$ProbeName[1:10] %in% Data.105$ProbeName[1:10])
#[1] 0
#
# We need to reorder them using ProbeName as a key before merging
#
#> Data.44.1<- Data.44.1[order(Data.44.1$ProbeName),]
#> Data.44.2<- Data.44.2[order(Data.44.2$ProbeName),]
#> Data.44.3<- Data.44.3[order(Data.44.3$ProbeName),]
#> Data.105<- Data.105[order(Data.105$ProbeName),]
#> sum(Data.44.1$ProbeName == Data.44.2$ProbeName)
#[1] 38839
#> sum(Data.44.1$ProbeName == Data.44.3$ProbeName)
#[1] 38839
#> sum(Data.44.1$ProbeName == Data.105$ProbeName)
#[1] 38839

#
# Now we are ready to join all datasets into one
# We skip two columns in each set - first that contains now irrelevant ID_REF field, 
# and redundant ProbeName field that is identical in all sets
#
# MyData <- cbind.data.frame(Data.105[,2:(dim(Data.105)[2]-1)],Data.44.1[,2:(dim(Data.44.1)[2]-1)],Data.44.2[,2:(dim(Data.44.2)[2]-1)],Data.44.3[,2:(dim(Data.44.3)[2]-1)])
# 
# Finally  we add the ProbeNames as row names in our final dataset. 
# row.names(MyData)<- Data.44.1$ProbeName
# 
# We now want to save it for later use
# save(MyData,file = "MyPreciousData.Rdata") 
#
# Maybe its not the best name - you will certainly forget what's inside after three months
# save(MyData,file = "JointDatasets_from_FS_lesson_01.Rdata")
# 
# Better, but maybe you want to save some more information? 
#
# # save(MyData,header105,header44_1,header44_2,header44_3,file="Important_data_from_FS_lesson01.Rdata")
#
#  THE END