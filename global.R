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

sco_hb <- st_read('raw_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp', "SG_NHS_HealthBoards_2019")

sco_hb_simplified <-  st_simplify(sco_hb, preserveTopology = TRUE,
                                  dTolerance = 1000)
