###############################################
## Gather1.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created 7/2/2017
## 
###############################################

## This R script file downloads the GDP data by country

# Download the GDP data from the world bank
URL <- "http://databank.worldbank.org/data/download/GDP.csv"

filepath <- "/Data/GDP.csv"

# Assumes the working directory is /Analysis/Data/
path <- c(getwd(),filepath)
path <- paste(path, collapse = "")


# Download the GDP.csv in its raw form and save it in /Analysis/Data/
download.file(url = URL, destfile = path)