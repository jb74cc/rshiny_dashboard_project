library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # colour tabs and text
  tags$style(HTML("
        .tabbable > .nav > li > a {
           background-color: #433685;
           color: #FFF;
        }")),
  # use a gradient in background
  setBackgroundColor(
    color = c("#265C4B", "#589A8D"),
    gradient = "radial",
    direction = c("bottom", "right")
  ),
  
  # App title ----
  titlePanel(img(src = "phs-logo.png", width = 250)),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select the random distribution type ----
      radioButtons("dist", "Bed Occupancy:",
                   c("Year" = "norm",
                     "Quarter" = "unif",
                     "Pre Covid" = "lnorm",
                     "Post Covid" = "exp")),
      
      # br() element to introduce extra vertical spacing ----
      br(),
      
      # Input: Slider for the number of observations to generate ----
      sliderInput("n",
                  "Number of observations:",
                  value = 500,
                  min = 1,
                  max = 1000)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Table", tableOutput("table"))
      )
    )
  )
)


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
  
  # Generate an HTML table view of the data ----
  output$table <- renderTable({
    d()
  })
  
}

shinyApp(ui, server)
