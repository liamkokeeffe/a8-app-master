## Liam O'Keeffe
## 26 November 2018
## ui.R file for UFO shiny app
## creates app with sidebar including radio buttons and a numeric input widget.
## Also contains a plot in the main panel and a text output at the bottom relating to the
## radio button widget.

library(shiny)

ui <- fluidPage(
  titlePanel("UFO Sighting Data"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("country",
                   h3("Select Location(s)"),
                   c("USA", "CANADA")),
      numericInput("month", h3("Enter Month # (1-12)"), 
                   value = 0, min = 0, max = 12, step = 1)
    ),
    mainPanel(
      plotOutput("bar"),
      h3(textOutput("count"))
    )
  )
)
