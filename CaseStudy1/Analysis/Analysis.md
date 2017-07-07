---
title: "Analysis.md"
author: "Festus Yaboah, Chris Havenstein, and Cam Lu"
date: "July 4, 2017"
output: html_document
---

Please set your working directory to the Analysis folder.
```{r setwd, echo=FALSE}
setwd("C:/Users/Chris/Desktop/GIT home/caseStudy1/CaseStudy1/Analysis")
```

Source Makefile.R

```{r makefile}
source("./Data/Makefile.R")

```
## Question 1 on Merged Data: 
## Merge the data based on country shortcode. How many of the IDs match?
```{r CountRows}
nrow(MergeData)
```
## 187 country shortcodes match.


## Question 2 on Merged Data:
## Sort the data frame in ascending order by GDP (so United States is last).
## What is the 13th country in the resulting data frame?

```{r}
MergeData <- MergeData[order(MergeData$GDP),]

MergeData[13,3]
```
## Answer: The 13th Country in the reordered data is Samoa.



