library(tidyverse)
churnData <- read_csv("Project3Data.csv")
churnData$customerID <- NULL
churnData[churnData =="No internet service"] <- "No"
churnData[churnData =="No phone service"] <- "No"
churnData <- na.omit(churnData)

churnData$SeniorCitizen <- ifelse(churnData$Churn == 1,"Yes","No")