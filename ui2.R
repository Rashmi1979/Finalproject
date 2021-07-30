fluidPage(
  titlePanel(uiOutput('test')),
  sidebarLayout(
    sidebarPanel("This dataset comes from the",
                 br(),
    ),
    mainPanel(plotOutput("dataplot"),
              dataTableOutput("datatable")
    )
  )
)