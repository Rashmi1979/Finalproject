
library(shiny)
library(tidyverse)
library(kableExtra)
library(DT)
library(plotly)
library(rpart)
library(randomForest)
library(caret)
library(party)


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

  
  output$trainSize <- renderText({ 
    trDa <- as.numeric(input$trDataSize)
    tsDa <- 100 - trDa
    
    updateSliderInput(session,"tstDataSize",value = tsDa )
    return (paste0("Train Data set size: ",input$trDataSize,"%"))
  })
  
  output$cvSize <- renderText({ return (paste0("CV value: ",input$cv))})
  output$predictors <- renderText({ paste0(input$predGroup,sep=',') })
  
  
  observeEvent(input$runModels, {
    
    
    set.seed(123)  
    modelData <- churnData %>% select(input$predGroup)
    modelData = modelData %>%  mutate_if(is.character,as.factor)
    modelData$Churn <- as.factor(churnData$Churn)
    
    #create the train and test datasets
    trPer <- input$trDataSize / 100
    train <- sample(1:nrow(modelData), size = nrow(modelData)*trPer)
    test <- dplyr::setdiff(1:nrow(modelData), train)
    churnDataTrain <- modelData[train, ]
    churnDataTest <- modelData[test, ]
  
    
    glmFit <- train(Churn ~ ., data=churnDataTrain, method= "glm", family = "binomial",
                    preProcess=c("center","scale"), 
                    trControl = trainControl(method="cv", number= input$cv))
    
    predlm <- predict(glmFit, newdata = dplyr::select(churnDataTest,-Churn))
    #lmRM <- postResample(predlm, churnDataTest$Churn)
    glmCM <- confusionMatrix(predlm,churnDataTest$Churn)
    glmMC <- 1 - sum(diag(glmCM$table)/sum(glmCM$table))
    
    output$glmSummary <- renderPrint({summary(glmFit)})
    output$glmRMSE <- renderText({paste0("Misclassification Rate: ", glmMC)})
    
  
  
    # Classification tree
    trFit <- ctree(formula = Churn ~ ., data=churnDataTrain)
    trPred <- predict(trFit,  newdata = dplyr::select(churnDataTest,-Churn))
    
    trCM <- confusionMatrix(trPred,churnDataTest$Churn)
    trMC <- 1 - sum(diag(trCM$table)/sum(trCM$table))
    
    output$trSummary <- renderPrint({summary(trFit)})
    output$trRMSE <- renderText({paste0("Misclassification Rate: ", trMC)})
    
    
    
    # Random forest
    rfFit <- train(Churn ~ ., data=churnDataTrain, method= "rf",
                   trControl = trainControl(method="cv", number= input$cv),
                   tuneGrid = data.frame(mtry = 1:5))
      
      
    rfPred <- predict(rfFit,  newdata = dplyr::select(churnDataTest,-Churn))
    #rfRM <- postResample(rfPred, churnDataTest$Churn)
    rfCM <- confusionMatrix(rfPred,churnDataTest$Churn)
    rfMC <- 1 - sum(diag(rfCM$table)/sum(rfCM$table))
    
    output$rfSummary <- renderPrint({summary(rfFit)})
    output$rfRMSE <- renderText({paste0("Misclassification Rate: ", rfMC)})
    
    
  
  })
  
  
  
})
  




  #output$data <- renderUI(source('data.R', local = TRUE))
    
    
    
    
    
    #output$doc <- renderUI(
  #    source('ui2.R', local = TRUE))
 # output$test <- renderUI( paste0('test'))

