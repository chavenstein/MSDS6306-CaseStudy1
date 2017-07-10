---
title: "README.md"
author: "Festus Yaboah, Chris Havenstein, and Cam Lu"
date: "July 7, 2017"
output: html_document
---

# Introduction:

## MSDS 6306 - Case Study 1

### Goal: 

By using two publicly available data sets, shown in the table below, we want to determine if GDP and income groups by country are related. Since the columns to answer this research question are not contained in one data set alone, we must merge the data from both data sets together.

Data set                     | Link to Data set 
--------------------------- | ---------------
"GDP ranking" data from the World Bank| http://data.worldbank.org/data-catalog/GDP-ranking-table
"Education Statistics" from the World Bank | http://data.worldbank.org/data-catalog/ed-stats


### Process: 

1. Upon initially downloading the GDP and Education data sets, it was determined that some cleaning was required. 

    + Note: This process of downloading the data was performed in the R script files "Gather1.R" and "Gather2.R". These files can be found within the "Analysis/Data/" folder. Other R script files used in the analysis are also included in the "Analysis/Data/" folder.

2. We began the analysis by examining the "GDP.csv" downloaded with "Gather1.R".

    + The "GDP.csv" contained CountryCodes, GDP Rankings, Country long names, and GDP by country.
    + The first column did not include a column name.
    + The third column did not contain any data.
    + The first 5 rows did not contain relevant data.
    + Some countries did not have a GDP recorded, and thus did not have a GDP rank.
    + There were aggregate categories that did not contain GDP Rankings, since they did not pertain to a particular country.
  
3. Cleaning steps were performed on "GDP.csv" using the R script "Clean1.R." 

    + The output of "Clean1.R" was a comma separated value document called "CleanGDP.csv."

4. Next, we examined the education data contained in "EDSTATS_Country.csv."

    + The key columns of interest in "EDSTATS_Country.csv" were "CountryCode", country "Long.Name", "Income.Group".
    + There were country codes that pertained to aggregate categories, as in "GDP.csv." These aggregate categories did have associated income groups. Since they did not contain income groups and did not relate to a single country, they were removed from our clean data set.


5. Cleaning steps were performed on "EDSTATS_Country.csv" using the R script "Clean2.R."

    + The output of "Clean2.R" was a comma separated value document called "CleanEDSTATS_Country.csv."
   
6. Next, the "CleanGDP.csv" and "CleanEDSTATS_Country.csv" files were merged together into a single data set by the column "CountryCode."

    + The merged dataset that was ready for analysis was written to "MergeData.csv."
    + The columns in "MergeData.csv" included: The first four columns (from "CleanGDP.csv") were "CountryCode","Rank", "CountryName", "GDP"; which then were followed with "Income.Group" and all of the other columns originally from "EDSTATS_Country.csv."

### The Analysis:

* An analysis was performed on "MergeData.csv" to answer five questions. These questions for the analysis were answered in the "Analysis.Rmd" file, located in ./CaseStudy1/Analysis/ folder. A conclusion to the analysis is contained in "Analysis.Rmd" -- listed after the answers to all five questions. The best location to view the final analysis with output and the conclusion is by viewing "Analysis.md", located in the same folder.

    + The analysis in "Analysis.Rmd" sources "Makefile.R", which in turn sources, in order: "Gather1.R", "Clean1.R", "Gather2.R", "Clean2.R", and then last "MergeData.R."
    
    + **Please navigate to the ./CaseStudy1/Analysis/ folder to view the analysis.**
    + If you are viewing the analysis in GitHub, please specifically navigate to the file "Analysis.md" in the ./CaseStudy1/Analysis/ folder. **This will allow you to view the output to the R code snippets in GitHub.**

