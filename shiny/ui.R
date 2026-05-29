library(shiny)
library(plotly)

shinyUI(
  fluidPage(
    
    titlePanel("IF36 - Shiny APP"),
    
    sidebarLayout(
      
      sidebarPanel(
        textInput(
          "filteradd",
          label="Filtre Additif"
        ),
        textInput(
          "filtersub",
          label="Filtre Soustractif"
        )
      ),
      
      mainPanel(
        plotlyOutput("frequenceMsg"),
        plotlyOutput("victoireMsg")
      )
      
    )
  )
)