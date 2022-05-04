# Cleaning script for "Activity by Board of Treatment, Age and Sex"
# Emergency Inpatients 
# 2016 Q3 - 2021 Q3

library(tidyverse)
library(here)
library(janitor)

## Read In Data
hosp_activity_agesex <- read_csv(here("../../raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_age_and_sex.csv"))


#clean column names
hosp_activity_agesex <- janitor::clean_names(hosp_activity_agesex)

# We only need ACUTE patients, what do we have:
# admission_type:
# * Elective Inpatients		(not acute)
# * *Emergency Inpatients*				
# * Transfers			(not acute)			
# * All Day cases				(not acute)		
# * All Inpatients		  		(not necasseraly acute)		
# * All Inpatients and Day cases			(not acute)			
# * Not Specified   		(not acute???)


hosp_acute_activity_agesex <- hosp_activity_agesex %>% 
  filter(admission_type == "Emergency Inpatients")


# COLUMN FOR TOTALS FOR AGE BY QUARTER
hosp_acute_activity_agesex <- hosp_acute_activity_agesex %>% 
  group_by(age, quarter) %>% 
  mutate(total_stays_per_quarter_age = sum(stays))

# total stays column for sex by quarter: 
# (sometimes stay = 0, and length of stay = 5 - discuss)
hosp_acute_activity_agesex <- hosp_acute_activity_agesex %>% 
  group_by(sex, quarter) %>% 
  mutate(total_stays_per_quarter_sex = sum(stays))

# write to csv
write_csv(hosp_acute_activity_agesex, "../../clean_data/acute_activity_by_board_of_treatment_age_sex_clean.csv")
