# Cleaning script for "Activity by Board of Treatment and Deprivation"
# Emergency Inpatients 
# 2016 Q3 - 2021 Q3

library(tidyverse)
library(here)
library(readxl)
library(janitor)
library(ggplot2)
library(lubridate)
library(stringr)

hosp_activity_simd <- 
  read_csv(here("../../raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_and_simd.csv"))


hosp_activity_simd <- janitor::clean_names(hosp_activity_simd)

# We only need ACUTE patients, what do we have:
# admission_type:
# * Elective Inpatients		(not acute)
# * *Emergency Inpatients*				
# * Transfers			(not acute)			
# * All Day cases				(not acute)		
# * All Inpatients		  		(not necasseraly acute)		
# * All Inpatients and Day cases			(not acute)			
# * Not Specified   		(not acute???)
hosp_acute_activity_simd <- hosp_activity_simd %>% 
  filter(admission_type == "Emergency Inpatients")

# drop NAs
hosp_acute_activity_simd_no_na <- hosp_acute_activity_simd %>% 
  drop_na(simd)

# Column for total stays per quarter 
hosp_acute_activity_no_na_simd <- hosp_acute_activity_simd_no_na %>% 
  group_by(simd, quarter) %>% 
  mutate(total_stays_per_quarter_simd = sum(stays))

# col for total episodes per quarter
hosp_acute_activity_no_na_simd <- hosp_acute_activity_no_na_simd %>% 
  group_by(simd, quarter) %>% 
  mutate(total_episodes_per_quarter_simd = sum(episodes))


# write to csv
write_csv(hosp_acute_activity_no_na_simd, "../../clean_data/acute_activity_by_board_of_treatment_simd_clean.csv")
