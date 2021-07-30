
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- navbarPage(
    "Project 3: Customer Churn  ",
    theme = shinytheme("flatly"),
    
    # First Tab About
    tabPanel(
        "About",
        fluidPage(uiOutput("about")),
    ),
    
    # Tab Data
    tabPanel(
        "Data",
        
    ),
    tabPanel(
        "Data Exploration",
        # App title ----
        titlePanel(div(
            windowTitle = "GraduatEmploymentSG",
            img(src = "sg0.jpg", width = "100%", class = "bg"),
            'test'
        ))
    ),
    tabPanel(
        "Modeling",
        # App title ----
        fluidPage(uiOutput("doc")),
    )
)
        