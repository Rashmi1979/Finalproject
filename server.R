
library(shiny)
library(tidyverse)
library(kableExtra)
library(DT)

churnData <- read_csv("Project3Data.csv")
churnData$customerID <- NULL
churnData[churnData =="No internet service"] <- "No"
churnData[churnData =="No phone service"] <- "No"
churnData$tenure <- ifelse(churnData$tenure < 12, 'Less than a year',
                           ifelse(churnData$tenure < 24, '1 to 2 years',
                                  ifelse(churnData$tenure < 36, '2 to 3 years',
                                         ifelse(churnData$tenure < 48, '3 to 4 years',
                                                ifelse(churnData$tenure <= 60, '4 to 5 years','Greater than 5 years')))))


churnData$SeniorCitizen <- ifelse(churnData$Churn == 1,"Yes","No")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # About Page
  output$about <- renderUI(includeHTML("About.html"))
  

  output$table = DT::renderDataTable({
    churnData 
  })
  
  
  #output$data <- renderUI(source('data.R', local = TRUE))
  
    
    
    
    
    
    
    
    
    
    
    
    #output$doc <- renderUI(
  #    source('ui2.R', local = TRUE))
 # output$test <- renderUI( paste0('test'))

})
