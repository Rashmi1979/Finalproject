
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
                    h3("Subseting dataset:"),

                    selectInput("InternetService", "Choose Internetsevice type", choices=c("DSL", "Fiber optic", "No")),
                    br(),
                    selectInput("Contract", "Choose Contract type", choices=c("Month to month", "One year")),
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
        