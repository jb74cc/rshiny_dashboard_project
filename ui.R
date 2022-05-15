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
  
  titlePanel(img(src = "phs-logo.png", width = 250),
             windowTitle = "PHS Dashboard"),
  
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
                                    h3("Is there a difference in number of 
                                       emergency inpatient stays between age 
                                     groups across Scotland?", 
                                     style = "color:white"),
                                    h4("Apart from the obvious dip in spring 2020,
                                     possibly due to the first COVID lockdown 
                                     and when hospitals changed to being almost 
                                     solely used for COVID care, it is 
                                     interesting to note that the age group data
                                     does not overlap each other both before and
                                     after COVID.",
                                     style = "color:white"),
                                    h4("With interest in the gap between 40-49
                                       and 50-59 year olds, an independent 
                                       samples hypothesis test (p < 2.22e-16) 
                                       confirmed that there was enough 
                                       statistical evidence to suggest that 
                                       50-59 year olds are more likely to be 
                                       admitted as an Emergency Inpatient 
                                       throughout Scotland.",
                                       style = "color:white"),
                                    h4("The \'70 - 79\' age group shows the most 
                                     admissions, with a decrease in admissions 
                                     appearing to correlate with a decrease in 
                                     age thereafter (with the exception of the 
                                     \'90 years and over\' age- group who 
                                     appear near the bottom despite having a 
                                     similar number of records).",
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
                                    h4("With p values close to zero, independent 
                                       samples hypothesis tests revealed that 
                                       there was sufficient statistical evidence 
                                       to suggest that being Female means you 
                                       are more likely to be admitted as an 
                                       Emergency Inpatient both before and 
                                       during COVID times.", 
                                       style = "color:white"),
                                    h4("Apart from the obvious dip in spring 
                                       2020, possibly due to the first COVID 
                                       lockdown and hospitals focusing almost 
                                       solely on COVID care, more Females 
                                     than Males across Scotland were admitted to 
                                     hospital each month throught this time 
                                     period.", 
                                     style = "color:white"),
                                    h4("There was a rather uniform difference of 
                                     around 10-13,000 individual stays per 
                                     quarter between sexes.",
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
                                    h3("Is there a difference in number of 
                                       emergency inpatient 
                         stays between SIMD (Scottish Index of Multiple Deprivation) levels across Scotland?", 
                         style = "color:white"),
                         
                         h4("Several independent samples (one tailed) hypothesis 
                            tests were carried out for both pre-COVID and during 
                            COVID times considering the mean stays of:",
                            style = "color:white"),
                         h5("* SIMD 1 (most deprived areas) and SIMD 3 (mid 
                            deprivation areas)", 
                            style = "color:white"),
                         h5("* SIMD 3 (mid deprivation areas) and SIMD 5 (least 
                            deprived areas)", 
                            style = "color:white"),
                         h4("With all p values close to zero, results for all 
                            tests revealed that those in more 
                            deprived areas were statistically significantly more
                            likely to visit Scottish hospitals as an Emergency 
                            Inpatient than those in less deprived areas both 
                            before and during COVID.", 
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
                                    h3("A review on the A&E Attendances", 
                                       style = "color:white"),
                                    h4("Peaks existed at Q1 and Q4. A massive downturn was recorded in 2020Q2, 
                                       which may resulted from the measurement of lock-down.", style = "color:white"),
                                    h4("A right-sided statistics hypothesis tested on the difference of mean between 
                                       number of attendance post-Covid and pre-Covid. The assumption of both means 
                                       equal to each other is rejected (pv. 0.013). It is confirmed that the mean 
                                       attendances of post-COVID is greater than the mean attendances of pre-COVID.",
                                       style = "color:white")))),
                  
                  
                  # Map Tab ----------------- 
                  tabPanel("Map", 
                           column(1),
                           column(8,
                                  leafletOutput("new_map_function"),
                                  br(),
                                  h3("NHS Scotland Healthboard Map", style = "color:white"),
                                  h4("Please click on a Health Board region on the map above to find 
                     out the total number of Covid 19 cases to date.", style = "color:white"))),
                  
                  # Resources Tab ----------------- 
                  tabPanel("Resources", 
                           h3("Data sourced from PHS Open Data Platform.", style = "color:white"),
                           h3("Contains public sector information licensed under the Open 
              Government Licence v3.0.", style = "color:white"),
              HTML("<br>", "<br>"),
              h4("The SIMD (Scottish Index of Multiple Deprivation) 
                            is a quintile scale:", 
                 style = "color:white"),
              h5("1 = \'Most Deprived\', 5 = \'Least Deprived\'", 
                 style = "color:white"),
              p("It uses a wide range of information for small areas 
                           (~7000 data zones) to identify concentrations of 
                           multiple deprivation across Scotland. Further 
                           information can be found here:", 
                style = "color:white"), 
              tags$a("www.gov.scot", href = "https://www.gov.scot/collections/scottish-index-of-multiple-deprivation-2020/", 
                     style = "color:white"),
              HTML("<br>", "<br>"),
              tags$h4("Data Sets Used", style = "color:white"),
              HTML("<br>"),
              tags$a("Hospital Activity Page", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/inpatient-and-daycase-activity/resource/c3b4be64-5fb4-4a2f-af41-b0012f0a276a"),
              HTML("<br>"),
              tags$a("Hospital Activity by Speciality", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/inpatient-and-daycase-activity/resource/c3b4be64-5fb4-4a2f-af41-b0012f0a276a"),
              HTML("<br>"),
              tags$a("Hospital Activity and Patient Demographics", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/inpatient-and-daycase-activity/resource/00c00ecc-b533-426e-a433-42d79bdea5d4"),
              HTML("<br>"),
              tags$a("Hospital Activity and Deprivation", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/inpatient-and-daycase-activity/resource/4fc640aa-bdd4-4fbe-805b-1da1c8ed6383"),
              HTML("<br>"),
              tags$a("Hospitalisations due to Covid-19", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/covid-19-wider-impacts-hospital-admissions"),
              HTML("<br>"),
              tags$a("A&E Attendances and Performance Data", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/monthly-emergency-department-activity-and-waiting-times"),
              HTML("<br>"),
              tags$a("Quarterly Hospital Beds Information - Datasets - Scottish Health and Social Care Open Data - nhs.scot", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/hospital-beds-information"),
              HTML("<br>"),
              tags$a("Delayed Discharge Data", style = "color:white", 
                     href = "https://www.opendata.nhs.scot/dataset/hospital-beds-information")
                  )
              
      )
    )
  )
)