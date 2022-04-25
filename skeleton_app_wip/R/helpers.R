map_function <- function(locations = hb_locations) {
  leaflet(locations) %>% 
    addProviderTiles(providers$CartoDB.Positron) %>% 
    addTiles(providers$CartoDB.Positron) %>% 
    addCircleMarkers(lat = ~latitude, lng = ~longitude, popup = ~paste(health_board))
}
