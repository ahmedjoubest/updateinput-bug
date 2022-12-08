library(shiny)
library(shinycssloaders)
library(dplyr)

ui <- fluidPage(
  selectInput("select","Choix multiples",multiple = T, choices = c(), selected = c()),
  plotOutput("plot") %>% withSpinner(),
  actionButton("update","Update input")
)

server <- function(input, output, session) {
  
  df <- eventReactive(input$update,{
    updateSelectInput(inputId = "select",choices = 1:5, selected = 1:5) 
    data.frame(a=1:2)
  })
  
  select <- debounce(reactive(input$select),1500)
  
  # Plot
  output$plot <- renderPlot({
    a <- df() # df rentre dans le calcul du plot
    barplot(
      length(select()) # input$select aussi (qu'on veut debouncer)
    )
  })
}

shinyApp(ui, server)