library(shiny)
library(shinydashboard)

# Define server
server <- function(input, output, session) {
  

  filtered_hb <- reactive({
    beds_by_hb_trim %>% 
      filter(hb_name %in% input$hb_input) %>% 
      filter(quarter >= input$select_start) %>% 
      filter(quarter <= input$select_end)
    
  })
  
  
  
  # Generate a plot of the bed occupancy data ----
  output$plot <- renderPlotly({
    bed_plot_function(filtered_hb())
    
    
  })
  
  # Generate a summary of the data ----
  output$summary <- renderPrint({
    paste("Resource list goes here")
  })
  
  # Generate a map of health board locations ----
  output$new_map_function <- renderLeaflet({
    new_map_function()
  })
  
}