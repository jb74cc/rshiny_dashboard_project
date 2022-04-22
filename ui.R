library(shiny)
library(shinydashboard)



ui <- dashboardPage(
  dashboardHeader(title = "PHS dashboard"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Tab 2", tabName = "tab2", icon = icon("th"))
    )
  ),
  ## Body content
  dashboardBody(
    tags$head(tags$style(HTML('
  
       .content-wrapper {
        background-color: #8C8C8C;
                             }
    
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #0D0D0D;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #0D0D0D;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #0D0D0D;
                              }        
                              
        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color: #262626;
                              }

        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #8C8C8C;
                              }

        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color: #262626;
                              color: #FFFFFF;
                              }

        /* other links in the sidebarmenu when hovered */
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color: #0D0D0D;
                              }
        /* toggle button when hovered  */                    
         .skin-blue .main-header .navbar .sidebar-toggle:hover{
                              background-color: #8C8C8C;
                              }
                              ')
    )
    ),
    
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250), status = "primary"),
                
                box(
                  title = "Controls", status = "primary",
                  solidHeader = TRUE, #collapsible = TRUE,
                  sliderInput("slider", "Number of observations:", 1, 100, 50), 
                  height = 273
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "tab2",
              h2("Tab 2 content")
      )
    )
  )
)