###############################################
## Gather2.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created 7/2/2017
## 
###############################################

# Download the Education data
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "

filepath <- "/Data/EDSTATS_Country.csv"

# Assumes the working directory is /Analysis/Data/
path <- c(getwd(),filepath)
path <- paste(path, collapse = "")


# Download the GDP.csv in its raw form and save it in /Analysis/Data/
download.file(url = URL, destfile = path)