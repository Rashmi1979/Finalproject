
library(shiny)
library(shinythemes)

# Main UI page
ui <- navbarPage(
    
    "Project 3: Customer Churn  ",
    theme = shinytheme("flatly"),
    
    # Tab About
    tabPanel(
        "About",
        fluidPage(uiOutput("about")),
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
                                       selected=c('gender','tenure','SeniorCitizen','Partner','Dependents','InternetService','MonthlyCharges','Churn'))
        
                ,
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
        # App title ----
        fluidPage(uiOutput("dataexp"))
    ),
    #tab Modeling
    tabPanel(
        "Modeling",
        fluidPage(uiOutput("modeling")),
    )
)
        