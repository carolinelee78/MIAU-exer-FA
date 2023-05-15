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

Community_Sample <- read_csv("https://raw.githubusercontent.com/carolinelee78/MIAU-exer-FA/main/Exercise_Com_Overall.csv")

MTurk_Sample <- read_csv("https://raw.githubusercontent.com/carolinelee78/MIAU-exer-FA/main/Exercise_MTurk_Overall.csv")

SMU_Sample <- read_csv("https://raw.githubusercontent.com/carolinelee78/MIAU-exer-FA/main/Exercise_SMU_Overall.csv")

# ===================================================================================

df_merge12 <- merge(Community_Sample, MTurk_Sample, by = "Item_No", all.x = TRUE)

Combined_Sample <- merge(df_merge12, SMU_Sample, by = "Item_No", all.x = TRUE)

Combined_Sample_NoNum <- Combined_Sample[,-1]

Combined_Sample$LoadedFactor <- apply(Combined_Sample_NoNum, 1, function(i) paste(colnames(Combined_Sample_NoNum)[ !is.na(i) ], collapse = ", "))





