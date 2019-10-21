## Liam O'Keeffe
## 26 November 2018
## server.r file for UFO shiny app
## Creates barplots breaking down the 2016 UFO sightings in Canada and the US

library(shiny)
library(dplyr)
library(lubridate)

server <- function(input, output) {
  data <- read.csv("./data/UFOCoords.csv")
  
  # creates barplots based on widget input
  output$bar <- renderPlot({
    data <- data %>% 
            filter(Country == input$country)
    data$Date <- as.Date(data$Date, "%m/%d/%Y")
    if (input$month == 0) {
      data <- data %>% 
              group_by(month(Date)) %>% 
              count()
      data$`month(Date)` <- month.abb[data$`month(Date)`]
      barplot(data$n, names.arg=data$`month(Date)`, xlab="2016 Months",
              ylab="Frequency", col="blue")  
    } else {
      data <- data %>%
              filter(month(Date) == input$month) %>%
              group_by(day(Date)) %>%
              count()
      barplot(data$n, names.arg=data$`day(Date)`, 
              xlab=paste0("Days in Month", " (", month.abb[input$month], ")"), 
              ylab="Frequency", col="blue")
    }
  })
  
  # outputs number of UFO sightings in the USA or Canada based on radio button input
  output$count <- renderText({
    paste0("Total UFO sightings in 2016 in ", input$country, " is ", 
           nrow(data %>% filter(Country == input$country)))
  })

  
  
}
