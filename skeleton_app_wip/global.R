# load packages required for app to function
library(tidyverse)
library(here)
library(janitor)
library(shinydashboard)
library(leaflet)


source("R/helpers.R")

# data for app
beds_by_hb_trim <- read_csv(here('clean_data/bed_occupancy_by_health_board_clean.csv'))

hb_locations <- read_csv(here('raw_data/health_board_geo.csv'))


