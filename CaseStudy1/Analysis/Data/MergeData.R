###############################################
## MergeData.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created: 7/4/2017
## 
###############################################

## Load in the clean GDP and EdStats_Country csvs.
CleanGDP <- read.csv("./Data/CleanGDP.csv", sep = ",", stringsAsFactors = FALSE)
CleanEDSTATS_Country <- read.csv("./Data/CleanEDSTATS_Country.csv", sep = ",", stringsAsFactors = FALSE)

## REMINDER FOR LATER... Questions might be best suited for the R Markdown.

## clean up the column names in Clean2.R!!!!!
MergeData <- merge(CleanGDP,CleanEDSTATS_Country,by="CountryCode")

write.csv(MergeData, file="./Data/MergeData.csv", row.names = FALSE)

writeLines("\nMergeData.csv has been created from CleanGDP.csv and CleanEDSTATS_Country.csv.")


## Question 1 on Merged Data: 
## Merge the data based on country shortcode. How many of the IDs match?
## MergeData <- merge(CleanGDP,CleanEDSTATS_Country,by="CountryCode")

## Answer: 187 Country shortcodes match.
## paste("The 'CleanGDP.csv' and 'CleanEDSTATS_Country.csv' files have been successfully merged together. There were", nrow(MergeData),"matches on country shortcode.")

## Question 2 on Merged Data:
## Sort the data frame in ascending order by GDP (so United States is last).
## What is the 13th country in the resulting data frame?
## MergeData <- MergeData[order(MergeData$GDP),]

## Answer: The 13th Country in the reordered data is Samoa.
## MergeData[13,3]

