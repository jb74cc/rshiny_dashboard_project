# COVID-19 Wider Impacts - Hospital Admissions
# SIMD

#libraries
library(tidyverse)
library(here)
library(janitor)
library(lubridate)
library(stringr)

# raw data
covid_admissions_HB_simd <- read_csv(here("../../raw_data/covid_data/hospital_admissions_hb_simd_20220302.csv"))

#Clean Names
covid_admissions_HB_simd <- janitor::clean_names(covid_admissions_HB_simd)

#Change week_ending column to a date and creating new month, year AND a month
# and year column
covid_admissions_HB_simd <- covid_admissions_HB_simd %>%
  mutate(week_ending = ymd(week_ending))

covid_admissions_HB_simd <- covid_admissions_HB_simd %>%
  mutate(
    wk_ending_month = month(week_ending, 
                            label = TRUE, 
                            abbr = FALSE),
    wk_ending_year = year(week_ending)
  ) %>% 
  unite(wk_ending_yr_month, 
        wk_ending_month, wk_ending_year, 
        remove = FALSE, 
        sep = " ")
covid_admissions_HB_simd

# Adding a quarter and year column to both (should have used regex but this took
# no time really)
covid_admissions_HB_simd <- covid_admissions_HB_simd %>% 
  mutate(year_quarter = case_when(
    wk_ending_yr_month == "January 2020" ~ "2020Q1",
    wk_ending_yr_month == "February 2020" ~ "2020Q1",
    wk_ending_yr_month == "March 2020" ~ "2020Q1",
    wk_ending_yr_month == "April 2020" ~ "2020Q2",
    wk_ending_yr_month == "May 2020" ~ "2020Q2",
    wk_ending_yr_month == "June 2020" ~ "2020Q2",
    wk_ending_yr_month == "July 2020" ~ "2020Q3",
    wk_ending_yr_month == "August 2020" ~ "2020Q3",
    wk_ending_yr_month == "September 2020" ~ "2020Q3",
    wk_ending_yr_month == "October 2020" ~ "2020Q4",
    wk_ending_yr_month == "November 2020" ~ "2020Q4",
    wk_ending_yr_month == "December 2020" ~ "2020Q4",
    wk_ending_yr_month == "January 2021" ~ "2021Q1",
    wk_ending_yr_month == "February 2021" ~ "2021Q1",
    wk_ending_yr_month == "March 2021" ~ "2021Q1",
    wk_ending_yr_month == "April 2021" ~ "2021Q2",
    wk_ending_yr_month == "May 2021" ~ "2021Q2",
    wk_ending_yr_month == "June 2021" ~ "2021Q2",
    wk_ending_yr_month == "July 2021" ~ "2021Q3",
    wk_ending_yr_month == "August 2021" ~ "2021Q3",
    wk_ending_yr_month == "September 2021" ~ "2021Q3",
    wk_ending_yr_month == "October 2021" ~ "2021Q4",
    wk_ending_yr_month == "November 2021" ~ "2021Q4",
    wk_ending_yr_month == "December 2021" ~ "2021Q4",
    wk_ending_yr_month == "January 2022" ~ "2022Q1",
    wk_ending_yr_month == "February 2022" ~ "2022Q1",
  ))


# We only need ACUTE patients: 
# admission_type has: All, Emergency and Planned
# all and emergency always have similar figures compared with planned.

# removing "all" as we only want acute 
covid_admissions_HB_simd <- covid_admissions_HB_simd %>% 
  filter(admission_type == "Emergency")

# Creating total columns for each simd for: total admissions per month and
# per quarter AND for the equivalent in average18/19 - MONTH AND QUARTER:
covid_admissions_HB_simd <- covid_admissions_HB_simd %>% 
  group_by(simd_quintile, wk_ending_yr_month) %>% 
  mutate(total_admissions_per_month_simd = sum(number_admissions))

covid_admissions_HB_simd <- covid_admissions_HB_simd %>% 
  group_by(simd_quintile, wk_ending_yr_month) %>% 
  mutate(admissions_2018_19_per_month_simd = sum(average20182019))

covid_admissions_HB_simd <- covid_admissions_HB_simd %>% 
  group_by(simd_quintile, year_quarter) %>% 
  mutate(total_admissions_per_quarter_simd = sum(number_admissions))

covid_admissions_HB_simd <- covid_admissions_HB_simd %>% 
  group_by(simd_quintile, year_quarter) %>% 
  mutate(admissions_2018_19_per_quarter_simd = sum(average20182019))

write_csv(covid_admissions_HB_simd, "../../clean_data/covid_hosp_admissions_hb_simd_clean.csv")
