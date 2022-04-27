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
                                                       selected = c("NHS Highland", "NHS Lothian"))),
                             #selected = sort(unique(beds_by_hb_trim$hb_name)))),
                             
                             column(7, 
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
                                  h3("Is there a difference in number of 
                                       emergency inpatient stays between age 
                                     groups across Scotland?", 
                                     style = "color:white"),
                                  h4("Apart from the obvious dip in spring 2020, 
                                     when hospitals changed to being almost 
                                     solely used for COVID care, it is 
                                     interesting to note that the age group data
                                     does not overlap each other both before and
                                     after COVID.",
                                     style = "color:white"),
                                  h4("The \'70 - 79\' age group shows the most 
                                     admissions, with a decrease in admissions 
                                     appearing to correlate with a decrease in 
                                     age thereafter (with the exception of the 
                                     \'90 years and over\' age- group) who 
                                     appear near the bottom despite having a 
                                     similar number of records.",
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
                                    h3("Is there a difference in number of 
                                       emergency inpatient stays between males 
                                       and females across Scotland?", 
                                     style = "color:white"),
                                    h4("Apart from the obvious dip in spring 2020, 
                                     when hospitals changed to being almost 
                                     solely used for COVID care, more Females 
                                     than Males across Scotland were admitted to 
                                     hospital each month.", 
                                     style = "color:white"),
                                    h4("There was a rather uniform difference of 
                                     around 10,000 individual stays per quarter
                                     between sexes.",
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
                      h3("Is there a difference in number of emergency inpatient 
                         stays between SIMD levels across Scotland?", 
                         style = "color:white"),
                      h4("The SIMD (Scottish Index of Multiple Deprivation) is a quintile scale:", 
                         style = "color:white"),
                      h4("1 = \'Most Deprived\', 5 = \'Least Deprived\'", style = "color:white"),
                      p("It uses a wide range of information for small areas (data zones) to identify concentrations of multiple deprivation across Scotland. Further information can be found here: https://www.gov.scot/collections/scottish-index-of-multiple-deprivation-2020/", style = "color:white"),
                      h4("Two independent samples (one tailed) hypothesis tests were carried out between the mean stays of:", style = "color:white"),
                      h5("* SIMD 1 (most deprived areas) and SIMD 3 (mid deprivation areas)", style = "color:white"),
                      h5("* SIMD 3 (mid deprivation areas) and SIMD 5 (least deprived areas)", style = "color:white"),
                      h4("Results for both tests revealed that those in more deprived areas were statistically significantly more likely to visit Scottish hospitals than those in less deprived areas.", style = "color:white")))),
                      
                      

# A&E Tab -----------------            
tabPanel("A&E",
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
                  
           ))),

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