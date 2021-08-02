
library(shiny)
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
        fluidPage(uiOutput("modeling"))
    )
  )
        