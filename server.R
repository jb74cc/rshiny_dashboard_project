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
  
  
  filter_all_time_age <- reactive({
    acute_activity_agesex %>% 
      filter(quarter >= input$select_start_age) %>% 
      filter(quarter <= input$select_end_age)
    })
  
  
  filter_all_time_sex <- reactive({
    acute_activity_agesex %>% 
      filter(quarter >= input$select_start_sex) %>% 
      filter(quarter <= input$select_end_sex)
  })
  
  
  
  filter_all_time_simd <- reactive({
    acute_activity_simd %>% 
      filter(quarter >= input$select_start_simd) %>% 
      filter(quarter <= input$select_end_simd)
  })
  
  
  filter_waiting_time_all_range <- reactive({
    waiting_time_all_range %>% 
      filter(year_quarter >= input$select_start_ae) %>% 
      filter(year_quarter <= input$select_end_ae)
  })
  
  
  # Generate a plot of the bed occupancy data ----
  output$plot <- renderPlotly({
    bed_plot_function(filtered_hb())
    
  })
  
  
  # Generate a plot of all times data for age
  output$plot1 <- renderPlotly({
    age_function_all_times(filter_all_time_age())
  })
 
   # Generate a plot of all times data for sex
  output$plot2 <- renderPlotly({
    sex_function_all_times(filter_all_time_sex())
  })
  
  # Generate a plot of all times data for simd
  output$plot3 <- renderPlotly({
    simd_function_all_times(filter_all_time_simd())
  })  
  
  # Generate a plot of a&e waiting time function
  output$waiting_plot <- renderPlotly({
    waiting_time_function(filter_waiting_time_all_range())
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