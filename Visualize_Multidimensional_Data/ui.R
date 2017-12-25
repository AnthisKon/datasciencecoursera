

library(shiny)

shinyUI(fluidPage(
  titlePanel("Iris Dataset Principal Components Visualization"),
  sidebarLayout(
    sidebarPanel(
      numericInput('PCS',
                   label = 'Choose the number of Components',
                   value = 4,
                   min=2,
                   max=4)

    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot",  plotOutput("MyPlot")),
        tabPanel("Documentation", verbatimTextOutput("documentation"))
      )
    )
  )
))
