library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)


ui <- fluidPage(
  
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
  
  titlePanel(img(src = "phs-logo.png", width = 250)),
  
  mainPanel(
    fluidRow(
      
      
      tabsetPanel(type = "tabs",
                  
                  tabPanel("Bed Occupancy", 
                           fluidRow(
                             column(1),
                             column(3,
                                    
                                    # drop down select dates
                                    selectInput("select_start", label = h4("Select start date"), 
                                                choices = sort(unique(beds_by_hb_trim$quarter)), 
                                                selected = min(beds_by_hb_trim$quarter)),
                                    
                                    selectInput("select_end", label = h4("Select end date"), 
                                                choices = sort(unique(beds_by_hb_trim$quarter)), 
                                                selected = max(beds_by_hb_trim$quarter)), 
                                    
                                    checkboxGroupInput("hb_input", label = h4("Select Health Board"), 
                                                       choices = sort(unique(beds_by_hb_trim$hb_name)),
                                                       selected = c("NHS Highland", "NHS Lothian"))),
                             #selected = sort(unique(beds_by_hb_trim$hb_name)))),
                             
                             column(8, 
                                    br(), 
                                    br(),
                                    plotlyOutput("plot"),
                                    h3("Is there such a thing as a \"Winter Crisis\"?", 
                                       style = "color:white"),
                                    h4("Grouping the bed occupancy data into \"winter\" and 
                        \"summer\" allows a two-sample hypothesis test to conclude 
                        that the average acute bed occupancy in winter is 
                        statistically significantly greater than in summer up 
                        until the onset of Covid.",
                        style = "color:white")))),
                  
                  
                  # Age Demographics Tab -----------------
                  tabPanel("Demographics - Age", 
                           fluidRow(
                             column(1),
                             column(3,
                                    
                                    # drop down select dates
                                    selectInput("select_start_age", 
                                                label = h4("Select start date"),
                                                choices = sort(unique(acute_activity_agesex$quarter)),
                                                selected = min(acute_activity_agesex$quarter)),
                                    
                                    selectInput("select_end_age", 
                                                label = h4("Select end date"),
                                                choices = sort(unique(acute_activity_agesex$quarter)),
                                                selected = max(acute_activity_agesex$quarter)),
                                    
                             ),
                             column(8, 
                                    br(), 
                                    br(),
                                    plotlyOutput("plot1"),
                                    h3("Text", 
                                       style = "color:white"),
                                    h4("Text",
                                       style = "color:white")))),
                  
                  
                  # Sex Demographics Tab -----------------
                  tabPanel("Demographics - Sex", 
                           fluidRow(
                             column(1),
                             column(3,
                                    
                                    # drop down select dates
                                    selectInput("select_start_sex", 
                                                label = h4("Select start date"),
                                                choices = sort(unique(acute_activity_agesex$quarter)),
                                                selected = min(acute_activity_agesex$quarter)),
                                    
                                    selectInput("select_end_sex", 
                                                label = h4("Select end date"),
                                                choices = sort(unique(acute_activity_agesex$quarter)),
                                                selected = max(acute_activity_agesex$quarter)),
                                    
                             ),
                             column(8, 
                                    br(), 
                                    br(),
                                    plotlyOutput("plot2"),
                                    h3("Text", 
                                       style = "color:white"),
                                    h4("Text",
                                       style = "color:white")))),
                  
                  
                  
                  # Deprivation Tab -----------------
                  tabPanel("Deprivation", 
                           fluidRow(
                             column(1),
                             column(3,
                                    
                                    # drop down select dates
                                    selectInput("select_start_simd", 
                                                label = h4("Select start date"), 
                                                choices = sort(unique(acute_activity_simd$quarter)), 
                                                selected = min(acute_activity_simd$quarter)),
                                    
                                    selectInput("select_end_simd", 
                                                label = h4("Select end date"), 
                                                choices = sort(unique(acute_activity_simd$quarter)), 
                                                selected = max(acute_activity_simd$quarter)),
                                    
                             ),
                             column(8, 
                                    br(), 
                                    br(),
                                    plotlyOutput("plot3"),
                                    h3("Text", 
                                       style = "color:white"),
                                    h4("Text",
                                       style = "color:white")))),
                  
                  
                  
                  
                  
                  # A&E Tab -----------------            
                  tabPanel("A&E",
                           fluidRow(
                             column(1),
                             column(3,
                                    
                                    # drop down select dates
                                    selectInput("select_start_ae", label = h4("Select start date"),
                                                choices = sort(unique(waiting_time_all_range$year_quarter)), 
                                                selected = min(waiting_time_all_range$year_quarter)),
                                    selectInput("select_end_ae", label = h4("Select end date"), 
                                                choices = sort(unique(waiting_time_all_range$year_quarter)), 
                                                selected = max(waiting_time_all_range$year_quarter)),
                             ),
                             column(8,
                                    br(), 
                                    br(),
                                    plotlyOutput("waiting_plot"),
                                    h3("Text", 
                                       style = "color:white"),
                                    h4("Text",
                                       style = "color:white")))),
                  
  
  # Map Tab ----------------- 
  tabPanel("Map", 
           column(1),
           column(8,
                  leafletOutput("new_map_function"),
                  br(),
                  p("NHS Scotland Healthboard Map", style = "color:white"))),
  
  # Resources Tab ----------------- 
  tabPanel("Resources", 
           p("Data sourced from PHS Open Data Platform.
                      Contains public sector information licensed under 
                      the Open Government Licence v3.0.", style = "color:white"))
  
)
)
)
)