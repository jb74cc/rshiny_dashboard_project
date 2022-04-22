map_function <- function(data, region_input) {
  data %>% 
    filter(Region == region_input) %>% 
    leaflet() %>% 
    addTiles() %>% 
    addCircleMarkers(lng = ~Longitude, lat = ~Latitude,
                     popup = ~paste0(Distillery))
}
