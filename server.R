#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/0
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # About Page
  output$about <- renderUI(includeHTML("About.html"))
  
  # Data page
  output$data <- renderUI(source('data.R', local = TRUE))
  
    
    
    
    
    
    
    
    
    
    
    
    #output$doc <- renderUI(
  #    source('ui2.R', local = TRUE))
 # output$test <- renderUI( paste0('test'))

})
