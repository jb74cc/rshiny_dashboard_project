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
                             column(4,
                                    
                                    # drop down select dates
                                    selectInput("select_start", label = h4("Select start date"), 
                                                choices = sort(unique(beds_by_hb_trim$quarter)), 
                                                selected = min(beds_by_hb_trim$quarter)),
                                    
                                    selectInput("select_end", label = h4("Select end date"), 
                                                choices = sort(unique(beds_by_hb_trim$quarter)), 
                                                selected = max(beds_by_hb_trim$quarter)), 
                                    
                                    checkboxGroupInput("hb_input", label = h4("Select Health Board"), 
                                                       choices = sort(unique(beds_by_hb_trim$hb_name)),
                                                       selected = sort(unique(beds_by_hb_trim$hb_name)))),
                             
                             column(7, 
                                    br(), 
                                    br(),
                                    plotlyOutput("plot")))),
                  
                  
                  
                  tabPanel("Demographics", verbatimTextOutput("")),
                  
                  tabPanel("Deprivation", verbatimTextOutput("")),
                  
                  tabPanel("A&E", verbatimTextOutput("")),
                  
                  tabPanel("Map", 
                           column(1),
                           column(8,
                                  leafletOutput("new_map_function"),
                                  p("p creates a paragraph of text."),
                                  p("A new p() command starts a new paragraph. 
                               Supply a style attribute to change the format of the entire paragraph.", 
                               style = "font-family: 'times'; font-si16pt"),
                               strong("strong() makes bold text."),
                               em("em() creates italicized (i.e, emphasized) text."),
                               br(),
                               code("code displays your text similar to computer code"),
                               div("div creates segments of text with a similar style. 
                                   This division of text is all blue because I passed the argument 'style = color:blue' to div", 
                                   style = "color:blue"),
                               br(),
                               p("span does the same thing as div, but it works with",
                                 span("groups of words", style = "color:blue"),
                                 "that appear inside a paragraph."))),
                  
                  tabPanel("Resources", verbatimTextOutput("summary"))
                  
      )
      )
    )
    
  )