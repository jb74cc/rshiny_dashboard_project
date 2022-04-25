library(shiny)
library(shinydashboard)

# Define server
server <- function(input, output) {
  
  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  d <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    dist(input$n)
  })
  
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    
    beds_by_hb_trim %>%
      ggplot() +
      aes(x = quarter, y = hb_mean_occupancy, colour = hb_name, group = hb) +
      geom_line() +
      geom_point(size = 0.75) +
      theme_bw() +
      labs(title = "% Bed Occupancy by Health Board, Scotland, Q3|2016 - Q3|2021",
           x = "\nQuarter",
           y = "% Bed Occupancy") +
      theme(axis.text.x = element_text(angle = 270, vjust = 0.25),
            title = element_text(face = "bold"),
            legend.title = element_blank())
  })
  
  # Generate a summary of the data ----
  output$summary <- renderPrint({
    summary(d())
  })
  
  # Generate a map of healthboard locations ----
  output$map_function <- renderLeaflet({
    map_function()
  })
  
}