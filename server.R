
library(shiny)
library(tidyverse)
library(kableExtra)
library(DT)



# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  
  # About Page
  output$about <- renderUI(includeHTML("About.html"))
  
  # Data page
  
  getData <- reactive({
    if(input$InternetService=="All types"){
      return(churnData%>% select(input$checkGroup))
    }
    else{
      newData <- churnData %>% filter(InternetService == input$InternetService) %>% select(input$checkGroup) 
      return(newData)
    }
  })
  
  output$table = DT::renderDataTable({
    getData() 
  })
  
  output$downloadData <- downloadHandler(
       filename = function() {
        paste('data-', Sys.Date(), '.csv', sep='')
      },
       content = function(con) {
         write.csv(getData(), con)
       }
     )
  
  
  
  
  
  
  
  
  #output$data <- renderUI(source('data.R', local = TRUE))
  
    
    
    
    
    
    
    
    
    
    
    
    #output$doc <- renderUI(
  #    source('ui2.R', local = TRUE))
 # output$test <- renderUI( paste0('test'))

})
