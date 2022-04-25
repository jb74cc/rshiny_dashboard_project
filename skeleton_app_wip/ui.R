library(shiny)
library(shinydashboard)
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
      sliderInput("slider2", label = h3("Slider Range"), min = 0, 
                  max = 100, value = c(40, 60))
          
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Map", leafletOutput("map_function"))
      )
    )
  )
)