# load packages required for app to function
library(tidyverse)
library(here)
library(janitor)
library(shinydashboard)
library(leaflet)
library(sf)
library(plotly)

source("R/helpers.R")

# data for app
beds_by_hb_trim <- read_csv(here('clean_data/bed_occupancy_by_health_board_clean.csv'))

hb_locations <- read_csv(here('raw_data/health_board_geo.csv'))

#sco_hb <- st_read('SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp', "SG_NHS_HealthBoards_2019")

# data for map
sco_hb <- st_read('raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp', "SG_NHS_HealthBoards_2019")

# simplify polygons on map
sco_hb_simplified <-  st_simplify(sco_hb, preserveTopology = TRUE,
                                  dTolerance = 1000)

# colour palette
nhs_colours <-  c("Ayrshire and Arran" = "#45214A", 
                  "Borders" = "#323050", 
                  "Dumfries and Galloway" = "#21445B", 
                  "Forth Valley" = "#1A6566", 
                  "Grampian" = "#5D8A66",
                  "Highland" = "#033B3D", 
                  "Lothian" = "#0D4A3A", 
                  "Orkney" = "#2D5731", 
                  "Shetland" = "#526126", 
                  "Western Isles" = "#7B6823",
                  "Fife" = "#0B2559", 
                  "Tayside" = "#183B59", 
                  "Greater Glasgow and Clyde" = "#2A5159", 
                  "Lanarkshire" = "#327355")


# alternative colour palette
nhs_colours_2 <-  c("#406771", "#73BFA3", "#F2B263", "#F2594B", "#F23030",
                  "#34401A", "#F2A03D", "#F27F1B", "#590202", "#0B2559",
                  "#2A5159", "#1EA4D9", "#9B4393", "#433685")