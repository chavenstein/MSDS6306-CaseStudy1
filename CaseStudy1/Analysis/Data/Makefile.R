###############################################
## Makefile.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created 7/2/2017
## 
###############################################

# Gather and clean the data
# Gather the Gross Domestic Product data and create GDP.csv
source("./Data/Gather1.R")
# Clean GDP.csv and create clean_GDP.csv
source("./Data/Clean1.R")

# Gather the educational data and create EDSTATS_Country.csv
source("./Data/Gather2.R")
# Clean FEDSTATS_Country.csv and create Clean_EDSTATS_Country.csv
source("./Data/Clean2.R")

# Merge the cleaned dataframes into one dataframe called MergeData
# create MergeData.csv
source("./Data/MergeData.R")


