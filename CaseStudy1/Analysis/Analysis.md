Analysis.Rmd
================
Festus Yaboah, Chris Havenstein, and Cam Lu
July 7, 2017

### dfd

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

Question 3 on Merged Data:
--------------------------

### What are the average GDP rankings for the "High income:OECD" and "High income: nonOECD" groups?

#### To proceed, we loaded the package "dplyr". If you do not have dplyr installed. You will need to run the R function for install.packages with dplyr passed as a parameter. This looks like the following, below.

##### install.packages("dplyr")

    ## Warning: package 'dplyr' was built under R version 3.2.5

``` r
#Create a filtered data frame by income group = "High income: OECD".
Filter.Cat.OECD <-c("High income: OECD")
Filtered.OECD <- filter(MergeData,Income.Group %in% Filter.Cat.OECD)

#Create a second filtered data frame by income group = "High income: nonOECD".
Filter.Cat.nonOECD <-c("High income: nonOECD")
Filtered.nonOECD <- filter(MergeData,Income.Group %in% Filter.Cat.nonOECD)

#Find the average rank for both filtered data frames
Average.Rank.OECD =mean(Filtered.OECD$Rank)
Average.Rank.nonOECD =mean(Filtered.nonOECD$Rank)

#output the average ranks to the user

#The average GDP rank for the income group 'High income: OECD' is: 31.9333. 
Average.Rank.OECD
```

    ## [1] 31.93333

``` r
#The average GDP rank for the income group 'High income: nonOECD' is: 101.375.
Average.Rank.nonOECD
```

    ## [1] 101.375

#### The countries in the 'High income: OCED' income group tend to have a Higher GDP on average than the 'High income: nonOCED' income group countries.

Question 4 on Merged Data:
--------------------------

### Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group.

#### To proceed, we loaded the package "ggplot2". If you do not have ggplot2 installed. You will need to run the R function for install.packages with ggplot2 passed as a parameter. This looks like the following, below.

##### install.packages("ggplot2")

    ## Warning: package 'ggplot2' was built under R version 3.2.5

``` r
ggplot(MergeData, aes(x=CountryCode, y=GDP))+geom_bar(aes(fill =MergeData$Income.Group), stat="identity")+ theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())
```

![](Analysis_files/figure-markdown_github/GDPbyIncomeGroup-1.png)

Question 5 on Merged Data:
--------------------------

### Find countries in the top 38 that are in the Lower middle income group.

``` r
#Break GDP into 5 quantiles

MergeData$Quantile <- as.numeric(with(MergeData, cut(GDP,                                 breaks=quantile(GDP, probs=seq(0,1, by=0.2), na.rm=TRUE),                                 include.lowest=TRUE)))

#Get Relevant Columns

MergeData_subset <-MergeData[,c(1,2,5,6,35)]

#Find countries in  the  top 38 that are in the Lower middle income group.

#Create a table of income groups vs the 5 GDP quantile groups
table(MergeData_subset$Income.Group,MergeData_subset$Quantile)
```

    ##                       
    ##                         1  2  3  4  5
    ##   High income: nonOECD  3  7  7  3  4
    ##   High income: OECD     0  0  2  9 19
    ##   Low income            8 16  9  4  0
    ##   Lower middle income  16  7 11 11  7
    ##   Upper middle income  11  7  8 10  8

``` r
#If you know that the 5th quantile is what you are looking for, you can tell that there are 7 countries in the Lower middle income group. However, we wanted to double check that this assumption about the 5th quartile is correct.

#So, we created a subset with rank less than 39 and in the "Lower middle income" group.
Top38subset <- subset(MergeData_subset,Rank < 39 & MergeData_subset$Income.Group=="Lower middle income")

#Here is the count of the countries in the Lower middle income group but are in the top 38 countries for highest GDP.
nrow(Top38subset)
```

    ## [1] 7

``` r
#These countries are:
Top38subset
```

    ##     CountryCode Rank                   Long.Name        Income.Group
    ## 138         PHL   35 Republic of the Philippines Lower middle income
    ## 51          EGY   31      Arab Republic of Egypt Lower middle income
    ## 128         NGA   26 Federal Republic of Nigeria Lower middle income
    ## 165         THA   25         Kingdom of Thailand Lower middle income
    ## 78          IDN   16       Republic of Indonesia Lower middle income
    ## 79          IND    7           Republic of India Lower middle income
    ## 33          CHN    2  People's Republic of China Lower middle income
    ##     Quantile
    ## 138        5
    ## 51         5
    ## 128        5
    ## 165        5
    ## 78         5
    ## 79         5
    ## 33         5

``` r
library(plotly)
```

    ## 
    ## Attaching package: 'plotly'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     last_plot

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

    ## The following object is masked from 'package:graphics':
    ## 
    ##     layout

``` r
p <- plot_ly(  x = MergeData$CountryCode,  y = MergeData$GDP,  type = "bar",  color=MergeData$Income.Group)

p
```

<!--html_preserve-->

<script type="application/json" data-for="27842f2e4b58">{"x":{"visdat":{"278457c0371b":["function () ","plotlyVisDat"]},"cur_data":"278457c0371b","attrs":{"278457c0371b":{"x":["TUV","KIR","MHL","PLW","FSM","STP","TON","DMA","COM","ASM","VCT","VUT","WSM","KNA","MNP","GMB","GRD","GNB","SLB","LCA","SYC","ATG","CPV","DJI","CAF","BLZ","LBR","LSO","GRL","BTN","BDI","GUY","MDV","SUR","SLE","SWZ","VIR","MNE","TGO","BRB","FJI","MRT","MWI","GUM","SOM","GIN","KGZ","LIE","MDA","TJK","NER","COG","HTI","RWA","BEN","BHS","TCD","MDG","GNQ","NAM","ARM","MKD","MLT","MOZ","MNG","BRN","ALB","BFA","MUS","NIC","JAM","MLI","GAB","GEO","SEN","BWA","LAO","ZWE","BIH","PNG","AFG","ZMB","CYP","KHM","ISL","TTO","NPL","HND","EST","CMR","UGA","SLV","YEM","PRY","LVA","BHR","BOL","CIV","TKM","SRB","AZE","JOR","TUN","GHA","LTU","SVN","MAC","TZA","BLR","LBN","HRV","BGR","URY","PAN","CRI","LUX","OMN","UZB","MMR","GTM","KEN","DOM","ETH","LKA","CUB","SVK","AGO","UKR","SDN","ECU","MAR","KWT","HUN","KAZ","QAT","DZA","IRQ","NZL","PER","CZE","GRC","VNM","PRT","BGD","FIN","CHL","COL","PAK","IRL","ZAF","MYS","SGP","PHL","DNK","ISR","HKG","EGY","ARE","NOR","AUT","IRN","NGA","THA","BEL","POL","SWE","ARG","SAU","CHE","NLD","TUR","IDN","MEX","AUS","ESP","RUS","KOR","CAN","BRA","ITA","IND","FRA","GBR","DEU","JPN","CHN","USA"],"y":[34,166,183,293,322,351,395,525,617,641,771,774,786,917,922,965,1016,1126,1202,1379,1427,1449,1617,1727,1756,1765,2101,2200,2220,2237,3007,3446,3591,3621,3669,3727,3765,4173,4400,4588,4632,4635,5442,5734,6217,6299,6551,6664,6750,6952,7509,7834,8023,8376,8583,9047,9601,9991,10179,10267,10547,10900,10949,11015,11160,11400,11927,12115,12164,13231,14027,14045,14214,14333,14765,15275,15903,16289,16560,16929,19469,19551,19802,20017,20047,20989,21144,21517,23137,24204,25528,26797,27318,27441,27677,31859,33806,36165,36180,37745,37848,38655,42063,42690,42739,43991,44803,47431,47433,47537,50425,52395,52420,55188,57436,59948,66293,67220,67430,68763,70529,71584,72374,81322,87133,89552,89633,93270,95584,97802,101445,114041,124343,133657,152469,156080,171489,185017,192094,192925,194559,202616,204565,221415,236785,247028,282463,283660,294054,294841,296359,296966,304905,306143,318744,320912,336297,348743,370557,386428,393436,405083,406840,466366,469509,511000,545866,646438,659827,770845,857749,932259,1045998,1204616,1232088,1283162,1411246,1529760,1796187,1849970,2263523,2465454,2618886,3466757,4939384,11199145,18569100],"color":["Lower middle income","Lower middle income","Lower middle income","Upper middle income","Lower middle income","Lower middle income","Lower middle income","Upper middle income","Low income","Upper middle income","Upper middle income","Lower middle income","Lower middle income","Upper middle income","High income: nonOECD","Low income","Upper middle income","Low income","Low income","Upper middle income","Upper middle income","Upper middle income","Lower middle income","Lower middle income","Low income","Lower middle income","Low income","Lower middle income","High income: nonOECD","Lower middle income","Low income","Lower middle income","Lower middle income","Upper middle income","Low income","Lower middle income","High income: nonOECD","Upper middle income","Low income","High income: nonOECD","Upper middle income","Low income","Low income","High income: nonOECD","Low income","Low income","Low income","High income: nonOECD","Lower middle income","Low income","Low income","Lower middle income","Low income","Low income","Low income","High income: nonOECD","Low income","Low income","High income: nonOECD","Upper middle income","Lower middle income","Upper middle income","High income: nonOECD","Low income","Lower middle income","High income: nonOECD","Upper middle income","Low income","Upper middle income","Lower middle income","Upper middle income","Low income","Upper middle income","Lower middle income","Lower middle income","Upper middle income","Low income","Low income","Upper middle income","Lower middle income","Low income","Low income","High income: nonOECD","Low income","High income: OECD","High income: nonOECD","Low income","Lower middle income","High income: nonOECD","Lower middle income","Low income","Lower middle income","Lower middle income","Lower middle income","High income: nonOECD","High income: nonOECD","Lower middle income","Lower middle income","Lower middle income","Upper middle income","Upper middle income","Lower middle income","Lower middle income","Low income","Upper middle income","High income: OECD","High income: nonOECD","Low income","Upper middle income","Upper middle income","High income: nonOECD","Upper middle income","Upper middle income","Upper middle income","Upper middle income","High income: OECD","High income: nonOECD","Lower middle income","Low income","Lower middle income","Low income","Upper middle income","Low income","Lower middle income","Upper middle income","High income: OECD","Lower middle income","Lower middle income","Lower middle income","Lower middle income","Lower middle income","High income: nonOECD","High income: OECD","Upper middle income","High income: nonOECD","Upper middle income","Lower middle income","High income: OECD","Upper middle income","High income: OECD","High income: OECD","Lower middle income","High income: OECD","Low income","High income: OECD","Upper middle income","Upper middle income","Lower middle income","High income: OECD","Upper middle income","Upper middle income","High income: nonOECD","Lower middle income","High income: OECD","High income: OECD","High income: nonOECD","Lower middle income","High income: nonOECD","High income: OECD","High income: OECD","Upper middle income","Lower middle income","Lower middle income","High income: OECD","High income: OECD","High income: OECD","Upper middle income","High income: nonOECD","High income: OECD","High income: OECD","Upper middle income","Lower middle income","Upper middle income","High income: OECD","High income: OECD","Upper middle income","High income: OECD","High income: OECD","Upper middle income","High income: OECD","Lower middle income","High income: OECD","High income: OECD","High income: OECD","High income: OECD","Lower middle income","High income: OECD"],"alpha":1,"sizes":[10,100],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"type":"category","categoryorder":"array","categoryarray":["AFG","AGO","ALB","ARE","ARG","ARM","ASM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYP","CZE","DEU","DJI","DMA","DNK","DOM","DZA","ECU","EGY","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KNA","KOR","KWT","LAO","LBN","LBR","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MDA","MDG","MDV","MEX","MHL","MKD","MLI","MLT","MMR","MNE","MNG","MNP","MOZ","MRT","MUS","MWI","MYS","NAM","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PLW","PNG","POL","PRT","PRY","QAT","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SOM","SRB","STP","SUR","SVK","SVN","SWE","SWZ","SYC","TCD","TGO","THA","TJK","TKM","TON","TTO","TUN","TUR","TUV","TZA","UGA","UKR","URY","USA","UZB","VCT","VIR","VNM","VUT","WSM","YEM","ZAF","ZMB","ZWE"]},"yaxis":{"domain":[0,1]},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":[{"name":"Collaborate","icon":{"width":1000,"ascent":500,"descent":-50,"path":"M487 375c7-10 9-23 5-36l-79-259c-3-12-11-23-22-31-11-8-22-12-35-12l-263 0c-15 0-29 5-43 15-13 10-23 23-28 37-5 13-5 25-1 37 0 0 0 3 1 7 1 5 1 8 1 11 0 2 0 4-1 6 0 3-1 5-1 6 1 2 2 4 3 6 1 2 2 4 4 6 2 3 4 5 5 7 5 7 9 16 13 26 4 10 7 19 9 26 0 2 0 5 0 9-1 4-1 6 0 8 0 2 2 5 4 8 3 3 5 5 5 7 4 6 8 15 12 26 4 11 7 19 7 26 1 1 0 4 0 9-1 4-1 7 0 8 1 2 3 5 6 8 4 4 6 6 6 7 4 5 8 13 13 24 4 11 7 20 7 28 1 1 0 4 0 7-1 3-1 6-1 7 0 2 1 4 3 6 1 1 3 4 5 6 2 3 3 5 5 6 1 2 3 5 4 9 2 3 3 7 5 10 1 3 2 6 4 10 2 4 4 7 6 9 2 3 4 5 7 7 3 2 7 3 11 3 3 0 8 0 13-1l0-1c7 2 12 2 14 2l218 0c14 0 25-5 32-16 8-10 10-23 6-37l-79-259c-7-22-13-37-20-43-7-7-19-10-37-10l-248 0c-5 0-9-2-11-5-2-3-2-7 0-12 4-13 18-20 41-20l264 0c5 0 10 2 16 5 5 3 8 6 10 11l85 282c2 5 2 10 2 17 7-3 13-7 17-13z m-304 0c-1-3-1-5 0-7 1-1 3-2 6-2l174 0c2 0 4 1 7 2 2 2 4 4 5 7l6 18c0 3 0 5-1 7-1 1-3 2-6 2l-173 0c-3 0-5-1-8-2-2-2-4-4-4-7z m-24-73c-1-3-1-5 0-7 2-2 3-2 6-2l174 0c2 0 5 0 7 2 3 2 4 4 5 7l6 18c1 2 0 5-1 6-1 2-3 3-5 3l-174 0c-3 0-5-1-7-3-3-1-4-4-5-6z"},"click":"function(gd) { \n        // is this being viewed in RStudio?\n        if (location.search == '?viewer_pane=1') {\n          alert('To learn about plotly for collaboration, visit:\\n https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html');\n        } else {\n          window.open('https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html', '_blank');\n        }\n      }"}],"cloud":false},"data":[{"x":["MNP","GRL","VIR","BRB","GUM","LIE","BHS","GNQ","MLT","BRN","CYP","TTO","EST","LVA","BHR","MAC","HRV","OMN","KWT","QAT","SGP","HKG","ARE","SAU"],"y":[922,2220,3765,4588,5734,6664,9047,10179,10949,11400,19802,20989,23137,27677,31859,44803,50425,66293,114041,152469,296966,320912,348743,646438],"type":"bar","name":"High income: nonOECD","marker":{"fillcolor":"rgba(102,194,165,0.5)","color":"rgba(102,194,165,1)","line":{"color":"transparent"}},"xaxis":"x","yaxis":"y","frame":null},{"x":["ISL","SVN","LUX","SVK","HUN","NZL","CZE","GRC","PRT","FIN","IRL","DNK","ISR","NOR","AUT","BEL","POL","SWE","CHE","NLD","AUS","ESP","KOR","CAN","ITA","FRA","GBR","DEU","JPN","USA"],"y":[20047,43991,59948,89552,124343,185017,192925,194559,204565,236785,294054,306143,318744,370557,386428,466366,469509,511000,659827,770845,1204616,1232088,1411246,1529760,1849970,2465454,2618886,3466757,4939384,18569100],"type":"bar","name":"High income: OECD","marker":{"fillcolor":"rgba(252,141,98,0.5)","color":"rgba(252,141,98,1)","line":{"color":"transparent"}},"xaxis":"x","yaxis":"y","frame":null},{"x":["COM","GMB","GNB","SLB","CAF","LBR","BDI","SLE","TGO","MRT","MWI","SOM","GIN","KGZ","TJK","NER","HTI","RWA","BEN","TCD","MDG","MOZ","BFA","MLI","LAO","ZWE","AFG","ZMB","KHM","NPL","UGA","GHA","TZA","MMR","KEN","ETH","BGD"],"y":[617,965,1126,1202,1756,2101,3007,3669,4400,4635,5442,6217,6299,6551,6952,7509,8023,8376,8583,9601,9991,11015,12115,14045,15903,16289,19469,19551,20017,21144,25528,42690,47431,67430,70529,72374,221415],"type":"bar","name":"Low income","marker":{"fillcolor":"rgba(141,160,203,0.5)","color":"rgba(141,160,203,1)","line":{"color":"transparent"}},"xaxis":"x","yaxis":"y","frame":null},{"x":["TUV","KIR","MHL","FSM","STP","TON","VUT","WSM","CPV","DJI","BLZ","LSO","BTN","GUY","MDV","SWZ","MDA","COG","ARM","MNG","NIC","GEO","SEN","PNG","HND","CMR","SLV","YEM","PRY","BOL","CIV","TKM","JOR","TUN","UZB","GTM","LKA","AGO","UKR","SDN","ECU","MAR","IRQ","VNM","PAK","PHL","EGY","NGA","THA","IDN","IND","CHN"],"y":[34,166,183,322,351,395,774,786,1617,1727,1765,2200,2237,3446,3591,3727,6750,7834,10547,11160,13231,14333,14765,16929,21517,24204,26797,27318,27441,33806,36165,36180,38655,42063,67220,68763,81322,89633,93270,95584,97802,101445,171489,202616,283660,304905,336297,405083,406840,932259,2263523,11199145],"type":"bar","name":"Lower middle income","marker":{"fillcolor":"rgba(231,138,195,0.5)","color":"rgba(231,138,195,1)","line":{"color":"transparent"}},"xaxis":"x","yaxis":"y","frame":null},{"x":["PLW","DMA","ASM","VCT","KNA","GRD","LCA","SYC","ATG","SUR","MNE","FJI","NAM","MKD","ALB","MUS","JAM","GAB","BWA","BIH","SRB","AZE","LTU","BLR","LBN","BGR","URY","PAN","CRI","DOM","CUB","KAZ","DZA","PER","CHL","COL","ZAF","MYS","IRN","ARG","TUR","MEX","RUS","BRA"],"y":[293,525,641,771,917,1016,1379,1427,1449,3621,4173,4632,10267,10900,11927,12164,14027,14214,15275,16560,37745,37848,42739,47433,47537,52395,52420,55188,57436,71584,87133,133657,156080,192094,247028,282463,294841,296359,393436,545866,857749,1045998,1283162,1796187],"type":"bar","name":"Upper middle income","marker":{"fillcolor":"rgba(166,216,84,0.5)","color":"rgba(166,216,84,1)","line":{"color":"transparent"}},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1}},"base_url":"https://plot.ly"},"evals":["config.modeBarButtonsToAdd.0.click"],"jsHooks":{"render":[{"code":"function(el, x) { var ctConfig = crosstalk.var('plotlyCrosstalkOpts').set({\"on\":\"plotly_click\",\"persistent\":false,\"dynamic\":false,\"selectize\":false,\"opacityDim\":0.2,\"selected\":{\"opacity\":1}}); }","data":null}]}}</script>
<!--/html_preserve-->
