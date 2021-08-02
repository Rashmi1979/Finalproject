
library(shiny)
library(shinyjs)
library(shinythemes)
library(plotly)


# Main UI page
ui <- navbarPage(
    
    "Project 3: Customer Churn  ",
    theme = shinytheme("flatly"),
    
    # Tab About
    tabPanel(
        "About",
        fluidPage(uiOutput("about"))
    ),
    
    # Tab Data
    tabPanel(
        "Data",
        fluidPage(
            sidebarLayout(
                sidebarPanel(
                    downloadButton('downloadData', 'Download'),
                    h3("Subseting dataset:"),
                    selectInput("InternetService", "Choose Internetsevice type", choices=c("All types" ,"DSL", "Fiber optic", "No")),
                    checkboxGroupInput("checkGroup", 
                                       label = ("Columns to select"),
                                       choices = colnames(churnData),
                                       selected=c('gender','tenure','SeniorCitizen','Partner','Dependents','InternetService','MonthlyCharges','Churn')),
                    width = 3
                ),
                mainPanel(
                    DT::dataTableOutput("table")
                )
            )
        )
    ),
    
    #Tab - Data Exploration
    tabPanel(
        "Data Exploration",
        fluidPage(
            sidebarLayout(
                sidebarPanel(
                    radioButtons("plots", "Data type:",
                                 c("Categorical" = "cat",
                                   "Numeric" = "num")),
                    conditionalPanel(condition = "input.plots=='cat'",
                                     selectInput("catVar", "Choose Categorical Variable", choices=c("InternetService" ,"PaymentMethod", "Contract")),
                                        selectInput("catGraph", "Choose Plot Type", choices=c("Bar Plot" ,"Box plot"))),
                    conditionalPanel(condition = "input.plots=='num'",
                        selectInput("num", "Choose Numberic Variable", choices=c("Tenure"="tenure" ,"TotalCharges", "MonthlyCharges")),
                        selectInput("numGraph", "Choose Plot Type", choices=c("Density" ,"Histogram")))
                    
                    , width = 3
                ),
                mainPanel(
                    h3("Plot:"),
                    plotlyOutput("plot"),
                    hr(style="1px solid #000000"),
                    h3("Summary Table:"),
                    tags$b(textOutput("summaryName")),
                    DT::dataTableOutput("summaryTable")
                )
            )
        )
    ),
    #tab Modeling
    tabPanel(
        "Modeling",
        tabsetPanel(
          type = "tabs",
          tabPanel(
            "Modeling Info",
            
            #You should explain these three modeling approaches, the benefits of each,
            #and the drawbacks of each. You should include some type of math type in the explanation
            #(you???ll need to include mathJax).
            
            
            withMathJax(),
            helpText('An irrational number \\(\\sqrt{2}\\)
           and a fraction $$1-\\frac{1}{2}$$'),
            ),
          tabPanel(
            "Model Fitting",
            fluidPage(
              sidebarLayout(
                sidebarPanel(
                  useShinyjs(),  
                  #Scrollable input
                  h4("Select Model data"),
                  sliderInput("trDataSize", "Train data percentage:",
                              min = 1, max = 100, value = 70, step = 1),
                  
                  disabled(sliderInput("tstDataSize", "Test data percentage:",
                              min = 1, max = 100, value = 30, step = 1)),
                  
                  numericInput("cv", "Cross Validation:", 10, min = 1, max = 100),
                  checkboxGroupInput("predGroup", 
                                     label = ("Select Predictors below:"),
                                     choices = c('gender', 'SeniorCitizen', 'Partner', 'Dependents', 'tenure', 'PhoneService',
                                                 'MultipleLines', 'InternetService', 'OnlineSecurity','OnlineBackup', 
                                                 'DeviceProtection', 'TechSupport', 'StreamingTV', 'StreamingMovies', 'Contract', 
                                                 'PaperlessBilling', 'PaymentMethod', 'MonthlyCharges', 'TotalCharges'),
                                      selected= c( 'Partner', 'Dependents', 'tenure', 'PhoneService',
                                                 'MultipleLines', 'InternetService','Contract', 
                                                 'PaperlessBilling', 'PaymentMethod', 'TotalCharges')),
                  
                  
                  width = 3
                ),
                mainPanel(
                  h4("Model Inputs:"),
                  tags$b(textOutput('trainSize')),
                  tags$b(textOutput('cvSize')),
                  tags$b('Predictors :'),
                  textOutput('predictors'),
                  hr(style="1px solid #000000"),
                  actionButton("runModels","Run Models"),
                  
                  hr(style="1px solid #000000"),
                  tags$b(("Generlized Linear Model")),
                  textOutput("glmRMSE"),
                  tags$div('Summary'),
                  verbatimTextOutput("glmSummary"),
                  
                  hr(style="1px solid #000000"),
                  tags$b(("Classification Tree")),
                  textOutput("trRMSE"),
                  tags$div('Summary'),
                  verbatimTextOutput("trSummary"),
                  
                  hr(style="1px solid #000000"),
                  tags$b(("Random Forest ")),
                  textOutput("rfRMSE"),
                  tags$div('Summary'),
                  verbatimTextOutput("rfSummary")
                  
                  
                  # Add busy Indicators
                  
                  
                         
                         
                  
               
                )
              )
            )
            
            ),
          
          
          tabPanel(
            "Prediction",
            fluidPage(
              sidebarLayout(
                sidebarPanel(
                  selectInput("predictions", "Select Model ", choices=c("Generlized Linear Model","Classification Tree","Random Forest")),
                  width = 3
                ),
                mainPanel(
                  
                )
              )
            )
            
          )
        )
    )
  )
        