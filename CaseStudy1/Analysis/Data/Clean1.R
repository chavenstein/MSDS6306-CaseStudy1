###############################################
## Clean1.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created 7/2/2017
## 
###############################################

## This R script file cleans the GDP data by country

## Read in the GDP.csv file that was downloaded from Gather1.R

GDPraw <- read.csv("./Data/GDP.csv", sep = ",", stringsAsFactors = FALSE)

#str(GDP)
#dim(GDPraw)

# Include only rows that have the 217 economies in the dataset.
GDP <- GDPraw[6:223,c(1,2,4,5)]
GDP <- GDP[-196,,drop=FALSE]

names(GDP) <- c("CountryCode", "Rank", "CountryName", "GDP")

# The count of rows that have no Rank, and thus have no GDP score.
writeLines("\n")
cat(paste("The number of Countries with no GDP value listed is:"), sum(GDP$Rank==""))

# Since these 22 rows have no NAs for GDP data, we will remove them.
removed <- GDP[which(GDP$Rank==""),]
GDP <- GDP[which(!GDP$Rank==""),]

# Report the 22 countries with no GDP that were removed from the dataset.
writeLines("These 22 Countries have been removed from the GDP dataset\n")
removed

sapply(GDP, class)

#Remove commas from the GDP comma and change class of vector to numeric
GDP$GDP <- as.numeric(gsub(",", "", GDP$GDP))

#The data appears to be clean writing the clean GDP dataframe to CleanGDP.csv
write.csv(GDP, file="./Data/CleanGDP.csv", row.names = FALSE)

writeLines("\nCleanGDP.csv has been created.")