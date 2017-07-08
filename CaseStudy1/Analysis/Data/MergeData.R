###############################################
## MergeData.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created: 7/4/2017
## 
###############################################

## Load in the clean GDP and EdStats_Country csvs.
CleanGDP <- read.csv("./Data/CleanGDP.csv", sep = ",", stringsAsFactors = FALSE)
CleanEDSTATS_Country <- read.csv("./Data/CleanEDSTATS_Country.csv", sep = ",", stringsAsFactors = FALSE)

## Merge the CleanGDP and CleanEDSTATS_Country dataframes together.
MergeData <- merge(CleanGDP,CleanEDSTATS_Country,by="CountryCode")

## Write the merged dataframe to "MergeData.csv".
write.csv(MergeData, file="./Data/MergeData.csv", row.names = FALSE)

## Then, report to the user that MergeData.csv was written successfully.
writeLines("\nMergeData.csv has been created from CleanGDP.csv and CleanEDSTATS_Country.csv.")


