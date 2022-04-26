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

# function to produce the new location map
new_map_function <- function(locations = HBName) {
  
  sco_hb_simplified %>% 
    st_transform(4326) %>% 
    leaflet() %>% 
    addProviderTiles(providers$CartoDB.Positron) %>% 
    addTiles(providers$CartoDB.Positron) %>%
    addPolygons(
      fillColor = ~colorQuantile("YlOrRd", sco_hb_simplified$Shape_Area)(Shape_Area),
      fillOpacity = 0.6,
      weight = 1
    )
}