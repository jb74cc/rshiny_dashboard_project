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
      # selectInput("hb_input", 
      #             label = tags$b("Select Health Board"),
      #             choices = sort(unique(beds_by_hb_trim$hb_name)),
      #             multiple = TRUE,
      #             selected = unique(beds_by_hb_trim$hb_name)
      #             ),
      
      checkboxGroupInput("hb_input", label = h4("Select Health Board"), 
                         choices = sort(unique(beds_by_hb_trim$hb_name)),
                         selected = sort(unique(beds_by_hb_trim$hb_name))),
      
    
      
      # br() element to introduce extra vertical spacing ----
      br(),
      # drop down select dates
      selectInput("select_start", label = h4("Select start date"), 
                  choices = sort(unique(beds_by_hb_trim$quarter)), 
                  selected = min(beds_by_hb_trim$quarter)),
      
      selectInput("select_end", label = h4("Select end date"), 
                  choices = sort(unique(beds_by_hb_trim$quarter)), 
                  selected = max(beds_by_hb_trim$quarter))
      
      #Input: Slider for the number of observations to generate ----
      # dateRangeInput("daterange3", "Date range:",
      #                start  = "2016-07-01",
      #                end    = "2020-01-01",
      #                min    = "2016-07-01",
      #                max    = "2021-10-31",
      #                format = "dd/mm/yy",
      #                separator = " - ")
      
      # sliderInput("format", label = h3("Date Range"), min = 2016, 
      #             max = 2021, pre = "Q", sep = ",", value = c(2016, 2021))
      #     
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Map", leafletOutput("new_map_function")),
                  tabPanel("Resources", verbatimTextOutput("summary"))
      )
    )
  )
)