# load packages required for app to function
library(tidyverse)
library(here)
library(janitor)
library(leaflet)
library(CodeClanData)
library(shinydashboard)

source("R/helpers.R")

# data for app
beds <- read_csv(here('raw_data/beds_by_nhs_board_of_treatment_and_specialty.csv'))