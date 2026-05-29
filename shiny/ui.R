library(shiny)
library(plotly)

ui <- fluidPage(
  
  titlePanel("Application d'analyse"),
  
  tabsetPanel(
    

    tabPanel(
      "Analyse Mirage",
      
      sidebarLayout(
        
        sidebarPanel(
          
          h4("Options Mirage"),
          
          selectInput(
            inputId = "choix_type",
            label = "Choisir un type :",
            choices = c("Tueur", "Mort")
          ),
          
          selectInput(
            inputId = "choix_equipe",
            label = "Choisir une équipe :",
            choices = c("Anti-Terroriste", "Terroriste", "Les deux")
          )
          ,
          sliderInput(
            inputId = "epsilon_cluster",
            label = "Epsilon :",
            min = 0,
            max = 1,
            value = 0.3
          ),
          
          sliderInput(
            inputId = "min_ptn_cluster",
            label = "Minimum points :",
            min = 0,
            max = 200,
            value = 50
          )
          
        ),
        
        mainPanel(
          p("Les geom_image ne sont pas compatibles avec les ggplotly"),
          h3("Analyse Heatmap des Morts / Tueurs"),
          plotOutput("map"),
          h3("Position pose des bombes"),
          plotOutput("position_bombe_xy"),
          h3("Clustering"),
          plotOutput("position_cluster"),
          plotlyOutput("repartition_cluster"),
          plotOutput("cluster_part")
        )
        
      )
    ),
    
    tabPanel(
      "Analyse Message",
      
      sidebarLayout(
        
        sidebarPanel(
          
          h4("Options Message"),

          
          textInput(
            inputId = "filtre_additif",
            label = "Filtre Additif :"
          ), 
          
          textInput(
            inputId = "filtre_soustractif",
            label = "Filtre Soustractif :"
          ),
          
          sliderInput(
            inputId = "limits_temps",
            label = "Limite temporelle",
            min = 0,
            max = 50,
            value = c(5, 15)
          )
          
        ),
        
        mainPanel(
          h3("Contenu de l'onglet Analyse Message"),
          plotlyOutput("topmessage"),
          plotlyOutput("messagewin"),
          plotlyOutput("messagewinrate"),
          plotlyOutput("messageperiod"),
          plotlyOutput("messagetype"),
          plotlyOutput("messagetypepart")
          
        )
        
      )
    )
    
  )
)
