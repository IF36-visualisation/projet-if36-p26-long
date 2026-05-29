library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

demos = read.csv("demos.csv")
matches = read.csv("matches.csv")
messages = read.csv("messages.csv")
players = read.csv("players.csv")


shinyServer(function(input, output) {
  
  
  
  output$monPlot <- renderPlotly({
    
    if (is.null(input$filter) || input$filter == "") {
      
      filtered_msg <- count(messages, message, sort = TRUE)
      filtered_msg <- head(filtered_msg, 20)
      
    } else {
      
      filtered_msg <- messages[
        grepl(input$filter,
              messages$message,
              ignore.case = TRUE),
      ]
      
      filtered_msg <- count(filtered_msg, message, sort = TRUE)
      filtered_msg <- head(filtered_msg, 20)
    }
    
    p <- ggplot(filtered_msg,
                aes(x = reorder(message, n),
                    y = n)) +
      geom_col(fill = "steelblue") +
      geom_text(aes(label = n),
                hjust = -0.1) +
      coord_flip()+
      ggtitle("Messages les plus envoyées")
    
    ggplotly(p)
    
    
  })
  
})