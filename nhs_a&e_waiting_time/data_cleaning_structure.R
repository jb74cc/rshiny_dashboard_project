Line 43 for Plotting

__Cleaned file__

yRead two files:

ae_waiting_time <- read_csv(here::here("data/ae_activity_waiting_times_apr2022-data.csv")) %>% 
  clean_names()

ae_waiting_time_prior <- read_csv(here::here("data/monthly_ae_waitingtimes_A&E attendances and performance data_202201.csv"))

location_code : A subset of ae_waiting_time that only contains Healthboard code, name and region

ae_waiting_time_prior:
- modification to year and quarter
- filter the data of 2016 and after

ae_waiting_time_subset:*
- a subset of ae_waiting_time_prior, with selected column
  #select("year", "month" , "treatment_location" , "department_type", "number_of_attendances_aggregate",  "number_meeting_target_aggregate","attendance_greater8hrs", "attendance_greater12hrs", "discharge_destination_admission_to_same" , "discharge_destination_other_specialty" ,"discharge_destination_residence", "discharge_destination_transfer" ,"discharge_destination_unknown")
-filter the year and quarter to only 2016Q3
-add a year_quarter column 

write_csv(ae_waiting_time_subset, file = here::here("data/ae_waiting_time_subset.csv"))

ae_waiting_time_clean:*
- a subset of ae_waiting_time_subset (column 1:9)
- arrange NAs values as 0
- mutate the year_quater column as factor

write_csv(ae_waiting_time_clean, file = here::here("data/ae_waiting_time_clean.csv"))

ae_waiting_time_clean_long:
- the same as ae_waiting_time_clean, but with renamed columns:
  "hrs_waiting_4","hrs_more_waiting_8", "hrs_more_waiting_12"

ae_waiting_time_clean_long_p:* use for plotting
- pivot_longer of ae_waiting_time_clean_long
- adjust column order, filter with department type

write_csv(ae_waiting_time_clean_long_p, file = here::here("data/ae_waiting_time_clean_long_p.csv"))

__For Plotting__

df : waiting_time_all_range:*
graph_1 : Number of People in Waiting Time Range `3 lines`
assign name : all_time_range_plot

waiting_time_all_range %>% 
  group_by(year_quarter) %>% 
  ggplot()+
  aes(x = year_quarter, y = log10(total_attendances), group = time_waiting, colour = time_waiting)+
  geom_point()+
  geom_line()+
  xlab("Year(Quarter)")+ylab("Number of Attendances (log 10)")+
  theme(axis.text.x = element_text(angle = 90, size = 5, vjust = 0.5, hjust=1))+
  labs(color="Time Waiting", size = 5)+
  ggtitle("Number of People in Waiting Time Range")



df : ae_waiting_time_clean_long_p
graph_2 : The total number of attendances from 2016 to 2022 `1 line`
assign name: total_num_attendances

ae_waiting_time_clean_long_p %>% 
  group_by(year_quarter) %>% 
  summarise(total_attendances = sum(number_attendances)) %>% 
  ggplot()+
  aes(x = year_quarter, y = log10(total_attendances))+
  geom_point()+
  geom_line(group = 1)+
  xlab("Year(Quarter)")+ylab("Number of Attendances(log 10)")+
  theme(axis.text.x = element_text(angle = 90, size = 5, vjust = 0.5, hjust=1))+
  labs(color="Time Waiting", size = 5)+
  ggtitle("Number of A&E Attendances from 2016 to 2022")

df: region_waiting_time
graph_3 : Average Number of Attendances (Region)
assign name: avg_num_region

region_waiting_time %>% 
  group_by(year_quarter) %>% 
  ggplot()+
  aes(x = year_quarter, y = attendances, group = region, color = region)+
  geom_line()+
  geom_point()+
  xlab("Year(Quarter)")+ylab("Number of Attendances")+
  theme(axis.text.x = element_text(angle = 90, size = 5, vjust = 0.5, hjust=1))+
  labs(color="Time Waiting", size = 3)+
  ggtitle("Average Number of Attendances (Region)")

















