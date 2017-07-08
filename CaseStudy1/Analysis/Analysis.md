Analysis.Rmd
================
Festus Yaboah, Chris Havenstein, and Cam Lu
July 7, 2017

### Please set your working directory to the Analysis folder.

Depending on the directory you cloned the "MSDS6306-CaseStudy1" into, the path to the "Analysis" folder should be similar to:

-   ./root/CaseStudy1/Analysis

By modifying "Analysis.Rmd" in the Analysis folder, I set an absolute path to the Analysis folder on my computer.

``` r
setwd("C:/Users/Chris/Desktop/GIT home/root/CaseStudy1/Analysis")
```

Source Makefile.R

``` r
source("./Data/Makefile.R")
```

    ## 
    ## 
    ## The number of Countries with no GDP value listed is: 22These 22 Countries have been removed from the GDP dataset
    ## 
    ## 
    ## CleanGDP.csv has been created.
    ## 
    ## 
    ## [1] "These 24 Aggregate groups that were not Countries have been removed from the EDSTATS_Country dataset:"
    ##     CountryCode                                      Long.Name
    ## 55          EAP          East Asia & Pacific (developing only)
    ## 56          EAS        East Asia & Pacific (all income levels)
    ## 57          ECA        Europe & Central Asia (developing only)
    ## 58          ECS      Europe & Central Asia (all income levels)
    ## 61          EMU                                      Euro area
    ## 85          HIC                                    High income
    ## 88          HPC         Heavily indebted poor countries (HIPC)
    ## 113         LAC    Latin America & Caribbean (developing only)
    ## 119         LCN  Latin America & Caribbean (all income levels)
    ## 120         LDC   Least developed countries: UN classification
    ## 121         LIC                                     Low income
    ## 124         LMC                            Lower middle income
    ## 125         LMY                            Low & middle income
    ## 136         MEA Middle East & North Africa (all income levels)
    ## 139         MIC                                  Middle income
    ## 144         MNA   Middle East & North Africa (developing only)
    ## 153         NAC                                  North America
    ## 160         NOC                           High income: nonOECD
    ## 164         OEC                              High income: OECD
    ## 182         SAS                                     South Asia
    ## 193         SSA           Sub-Saharan Africa (developing only)
    ## 194         SSF         Sub-Saharan Africa (all income levels)
    ## 218         UMC                            Upper middle income
    ## 228         WLD                                          World
    ## 
    ## CleanEDSTATS_Country.csv has been created.
    ## 
    ## MergeData.csv has been created from CleanGDP.csv and CleanEDSTATS_Country.csv.

Question 1 on Merged Data:
--------------------------

### Merge the data based on country shortcode. How many of the IDs match?

``` r
nrow(MergeData)
```

    ## [1] 187

#### 187 country shortcodes match.

Question 2 on Merged Data:
--------------------------

### Sort the data frame in ascending order by GDP (so United States is last).

### What is the 13th country in the resulting data frame?

``` r
MergeData <- MergeData[order(MergeData$GDP),]

MergeData[13,3]
```

    ## [1] "Samoa"

#### Answer: The 13th Country in the reordered data is Samoa.
