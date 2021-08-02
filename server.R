
library(shiny)
library(tidyverse)
library(kableExtra)
library(DT)
library(plotly)


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
  
  output$plot <- renderPlotly({
    #get filtered data
    if(input$plots =="cat"){
      if(input$catGraph =="Bar Plot"){
        ggplotly(ggplot(churnData, aes(fill=Churn, x= !!sym(input$catVar))) + 
                   geom_bar(position="dodge", stat="count")) 
        
      }
      else {
        ggplotly(ggplot(churnData, aes(x =!!sym(input$catVar),y=TotalCharges,fill=Churn)) +
          geom_boxplot() +
          facet_grid(.~Churn) )
      }
    } else {
      if(input$numGraph =="Density"){
        ggplotly( ggplot(churnData, aes(!!sym(input$num), fill = Churn)) + geom_density(alpha = 0.2))
      }
      else {
        ggplotly(ggplot(churnData, aes(x=!!sym(input$num), color=Churn)) +
                   geom_histogram(fill="white", alpha=0.5, position="identity") )
      }  
    }
  })
  

  output$summaryName <- renderText({
    if(input$plots=="cat"){
      return(paste0("Categorical Summary For: ",input$catVar," VS Churn"))
    } else {
      return(paste0("Numerical Summary For: ",input$num," VS Churn"))
    }
    
    
  })
    
  
  
  output$summaryTable <- DT::renderDataTable({
    #get filtered data
    if(input$plots =="cat"){
          my_tbl = table(churnData %>% select(Churn,!!sym(input$catVar)))
          printed_tbl = as.data.frame.matrix(my_tbl)
          printed_tbl
    } else {
      
      statsChurn <- churnData %>%
        group_by(Churn) %>%
        summarise(
          Min = min(!!sym(input$num)),
          Max = max(!!sym(input$num)),
          Median = median(!!sym(input$num)),
          Stdev = sd(!!sym(input$num)),
          Mean = mean(!!sym(input$num)))
      statsChurn
      
    }
       
    },options = list(dom = 't'))
  
  
  # Function to get the summary data
  
  
  
  # 
  
  
  
  
  
  
  
  
  
  
  
  
  #getSummaryData <- reactive({
  #  if(input$cat=="cat"){
  #    statsAtemp <- churnData %>%
  #      group_by(Churn) %>%
  #      summarise(
  #        atemp.min = min(MonthlyCharges),
  #        atemp.max = max(MonthlyCharges),
  #        atemp.med = median(MonthlyCharges),
  #        atemp.stdev = sd(MonthlyCharges),
  #        atemp.mean = mean(MonthlyCharges))
  #    
  #    return(statsAtemp)
  #  }
  #  else{
  #    newData <- churnData %>% filter(InternetService == input$InternetService) %>% select(input$checkGroup) 
  #    return(newData)
   # }
  })
  
  #output$data <- renderUI(source('data.R', local = TRUE))
    
    
    
    
    
    #output$doc <- renderUI(
  #    source('ui2.R', local = TRUE))
 # output$test <- renderUI( paste0('test'))

