# function to produce the location map
map_function <- function(locations = hb_locations) {
  leaflet(locations) %>% 
    addProviderTiles(providers$CartoDB.Positron) %>% 
    addTiles(providers$CartoDB.Positron) %>% 
    addCircleMarkers(lat = ~latitude, lng = ~longitude, popup = ~paste(health_board))
}

# function to produce plot on first tab
bed_plot_function <- function(beds_by_hb_trim) {

  beds_by_hb_trim %>%
  ggplot() +
  aes(x = quarter, y = hb_mean_occupancy, colour = hb_name, group = hb) +
  geom_line() +
  geom_point(size = 0.75) +
  theme_bw() +
  labs(title = "% Bed Occupancy by Health Board, Scotland, Q3|2016 - Q3|2021",
       x = "\nQuarter",
       y = "% Bed Occupancy") +
  theme(axis.text.x = element_text(angle = 270, vjust = 0.25),
        title = element_text(face = "bold"),
        legend.title = element_blank())
  
}

quarter_dates <- c("2016Q3", "2016Q4", "2017Q1", "2017Q2", "2017Q3", "2017Q4", 
                   "2018Q1", "2018Q2", "2018Q3", "2018Q4", "2019Q1", "2019Q2", 
                   "2019Q3", "2019Q4", "2020Q1", "2020Q2", "2020Q3", "2020Q4",
                   "2021Q1", "2021Q2", "2021Q3")
