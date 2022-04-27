# # function to produce the location map
# map_function <- function(locations = hb_locations) {
#   leaflet(locations) %>% 
#     addProviderTiles(providers$CartoDB.Positron) %>% 
#     addTiles(providers$CartoDB.Positron) %>% 
#     addCircleMarkers(lat = ~latitude, lng = ~longitude, popup = ~paste(health_board))
# }

# function to produce plot on first tab
bed_plot_function <- function(beds_by_hb_trim) {

  ggplotly(beds_by_hb_trim %>% 
             ggplot() +
             aes(x = quarter, y = hb_mean_occupancy, 
                 colour = hb_name, group = hb, 
                 text = hb_mean_occupancy) +
             geom_line() +
             geom_point(size = 0.75) +
             theme_bw() +
             labs(title = "Health Board % Bed Occupancy, 2016 - 2021",
                  x = "\nQuarter",
                  y = "% Bed Occupancy") +
             #scale_color_discrete(name = NULL) +
             scale_color_manual(values = nhs_colours_2) +
             theme(legend.title = element_blank(),
                   plot.title.position = "left",
                   axis.text.x = element_text(angle = 270, vjust = 0.25),
                   title = element_text(face = "bold")),
           tooltip = "text") %>%  
    style(hoverlabel = list, marker.color = "white")
  
}


# function to produce the age data for all times
age_function_all_times <- function(acute_activity_agesex) {
  
  ggplotly(acute_activity_agesex %>% 
    ggplot()+
    aes(x = quarter, 
        y = total_stays_per_quarter_age, 
        group = age, colour = age) +
    geom_point()+
    geom_line() + 
    labs(x = "Yearly Quarter", 
         y = "Total Stays", 
         title = "Total Emergency Inpatient Stays Across Scotland by Age Group",
         subtitle = "Q3, 2016 - Q3, 2021", 
         colour = "Age") +
    theme_bw()+
    theme(axis.text.x = element_text(angle=45, hjust=0.9))) %>% 
  style(hoverlabel = list, marker.color = "white")  
}

# function to produce the sex data for all times
sex_function_all_times <- function(acute_activity_agesex) {
  ggplotly(acute_activity_agesex %>% 
    ggplot()+
    aes(x = quarter, 
        y = total_stays_per_quarter_sex, 
        group = sex, colour = sex) +
    geom_line() + 
    labs(x = "Yearly Quarter", 
         y = "Total Stays", 
         title = "Total Emergency Inpatient Stays Across Scotland by Sex",
         subtitle = "Q3, 2016 - Q3, 2021", 
         colour = "Sex") +
    theme_bw()+
    theme(axis.text.x = element_text(angle=45, hjust=0.9))) %>% 
  style(hoverlabel = list, marker.color = "white")  
}

# function to produce SIMD data for all times
simd_function_all_times <- function(acute_activity_simd){

  ggplotly(acute_activity_simd %>%
  mutate(simd = fct_relevel(as.character(simd, 
                                         "1", "2", "3", "4", "5"))) %>%
  ggplot()+
  aes(x = quarter, 
      y = total_stays_per_quarter_simd, 
      group = simd, colour = simd) +
  geom_point()+
  geom_line() + 
  labs(x = "Yearly Quarter", 
       y = "Total Stays", 
       title = "Total Emergency Inpatient Stays Across Scotland by SIMD Level",
       subtitle = "Q3, 2016 - Q3, 2021", 
       colour = "SIMD Level:
       1 = Most Deprived
       5 = Least Deprived") +
  theme_bw()+
  theme(axis.text.x = element_text(angle=45, hjust=0.9))) %>% 
  style(hoverlabel = list, marker.color = "white")  
}



# function to produce the new location map
new_map_function <- function(locations = HBName) {
  
  sco_hb_simplified %>% 
    st_transform(4326) %>% 
    leaflet() %>% 
    addProviderTiles(providers$CartoDB.Positron) %>% 
    addTiles(providers$CartoDB.Positron) %>%
    addPolygons(
      color = ~nhs_colours(HBName),
      #fillColor = ~colorQuantile(nhs_colours, sco_hb_simplified$Shape_Area)(Shape_Area),
      fillOpacity = 0.6,
      weight = 1, 
      popup = ~HBName
    )
}
