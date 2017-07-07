###############################################
## Clean2.R
## Fesus Yaboah, Chris Havenstein, and Cam Lu
## Created: 7/3/2017
## Updated: 7/4/2017
###############################################

## This R script file cleans the GDP data by country

## Read in the GDP.csv file that was downloaded from Gather1.R

Educationraw <- read.csv("./Data/EDSTATS_Country.csv", sep = ",", stringsAsFactors = FALSE)



## Look for duplicate CountryCodes
## COUNT <- rle(sort(Educationraw$CountryCode))
## Test <- COUNT[[1]][ match( Educationraw$CountryCode, COUNT[[2]])]
## There were no duplicate CountryCodes

## Look for the number of NAs by column
## na_count <-sapply(Educationraw, function(y) sum(length(which(is.na(y)))))
## na_count <- data.frame(na_count)
## na_count

## Look for the number of nulls/blank values by column
## nulls <-sapply(Educationraw, function(y) sum(length(which(y==""))))
## nulls <- data.frame(nulls)
## nulls

## Create a dataframe that shows how sparse (how much missing values exist) each column in Educationraw is.
## col_sparsity <- na_count
## col_sparsity$nulls <- nulls$nulls
## col_sparsity$na_or_nulls <- na_or_nulls$na_count + na_or_nulls$nulls
## sparsity <- sapply(na_or_nulls$na_or_nulls, function(y) ifelse(y>0,(y/length(Educationraw$CountryCode)),0))
## sparsity <- data.frame(sparsity)
## row.names(sparsity) <- row.names(col_sparsity)
## col_sparsity$sparsity <- sparsity$sparsity

## the na_or_nulls dataframe with sparsity by column
## col_sparsity

## Find the rows with many NAs or nulls.
## nas_by_row <- rowSums(is.na(Educationraw))
## nulls_by_row <- rowSums(Educationraw=="",na.rm = TRUE)
## nas_or_nulls_by_row <- nas_by_row + nulls_by_row
## sparsity_by_row <- nas_or_nulls_by_row/31

## Create a dataframe that shows how sparse each row in Educationraw is.
## row_sparsity <- data.frame(nas_by_row, nulls_by_row, nas_or_nulls_by_row, sparsity_by_row)

## There are a number of rows that have the same sparsity ratio of aproximately 0.83870968.
## row_sparsity

## Get the row indexes of the rows with this sparsity.
## row_sparsity[which(row_sparsity$sparsity_by_row>=0.83870),]

## These rows are aggregrate group rows, they do not specifically describe countries and can be removed.
rows_to_remove <- c(55,56,57,58,61,85,88,113,119,120,121,124,125,136,139,144,153,160,164,182,193,194,218,228)

## Function to remove rows by row index.
removeRows <- function(rowNum, data) {
  newData <- data[-rowNum, , drop = FALSE]
  rownames(newData) <- NULL
  newData
}

## Create the CleanEDSTATS_Country dataframe
CleanEDSTATS_Country <- removeRows(rows_to_remove,Educationraw)


## Report the removed rows to the user.
removed_rows <- Educationraw[rows_to_remove,]
removed_rows <- removed_rows[, c(1,2)]

writeLines("\n")
print("These 24 Aggregate groups that were not Countries have been removed from the EDSTATS_Country dataset:")
print(removed_rows)

## Write the cleaned data to CleanEDSTATS_Country.csv
write.csv(CleanEDSTATS_Country, file="./Data/CleanEDSTATS_Country.csv", row.names = FALSE)


writeLines("\nCleanEDSTATS_Country.csv has been created.")
