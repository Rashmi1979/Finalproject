library(tidyverse)
churnData <- read_csv("Project3Data.csv")
churnData$customerID <- NULL
churnData[churnData =="No internet service"] <- "No"
churnData[churnData =="No phone service"] <- "No"
churnData$tenure <- ifelse(churnData$tenure < 12, 'Less than a year',
                           ifelse(churnData$tenure < 24, '1 to 2 years',
                                  ifelse(churnData$tenure < 36, '2 to 3 years',
                                         ifelse(churnData$tenure < 48, '3 to 4 years',
                                                ifelse(churnData$tenure <= 60, '4 to 5 years','More than 5 years')))))


churnData$SeniorCitizen <- ifelse(churnData$Churn == 1,"Yes","No")