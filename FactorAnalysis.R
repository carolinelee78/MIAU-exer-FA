# SETUP =============================================================================================================================================

# clear global environment

rm(list=ls())

# detach all libraries

detachAllPackages <- function() {
  basic.packages <- c("package:stats", "package:graphics", "package:grDevices", "package:utils", "package:datasets", "package:methods", "package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:", search()))==1, TRUE, FALSE)]
  package.list <- setdiff(package.list, basic.packages)
  if (length(package.list)>0)  for (package in package.list) detach(package,  character.only=TRUE)
}
detachAllPackages()

# function to load libraries

pkgTest <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[,  "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg,  dependencies = TRUE)
  sapply(pkg,  require,  character.only = TRUE)
}

lapply(c("tidyverse"),pkgTest)
lapply(c("readr"),pkgTest)
library(tidyverse)
library(readr)

# ===================================================================================

Community_Overall_Sample <- read_csv("https://raw.githubusercontent.com/carolinelee78/MIAU-exer-FA/main/Exercise_Com_Overall.csv")

MTurk_Overall_Sample <- read_csv("https://raw.githubusercontent.com/carolinelee78/MIAU-exer-FA/main/Exercise_MTurk_Overall.csv")

SMU_Overall_Sample <- read_csv("https://raw.githubusercontent.com/carolinelee78/MIAU-exer-FA/main/Exercise_SMU_Overall.csv")

# ===================================================================================

ComMTurk_Overall_Sample <- merge(Community_Overall_Sample, MTurk_Overall_Sample, by = "Item_No", all.x = TRUE)

Combined_Overall_Sample <- merge(ComMTurk_Overall_Sample, SMU_Overall_Sample, by = "Item_No", all.x = TRUE)

Combined_Overall_NoPN <- Combined_Overall_Sample[ ,c(1, 5:8, 11:15, 19:23)]

Combined_NoPN_NoNum <- Combined_Overall_NoPN[,-1]

Combined_Overall_NoPN$LoadedFactor <- apply(Combined_NoPN_NoNum, 1, 
                                      function(i) paste(colnames(Combined_NoPN_NoNum)[ !is.na(i) ], 
                                                        collapse = ", "))










