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
             labs(title = "% Bed Occupancy by Health Board, Scotland, Q3|2016 - Q3|2021",
                  x = "\nQuarter",
                  y = "% Bed Occupancy") +
             #scale_color_discrete(name = NULL) +
             scale_color_manual(values = nhs_colours_2) +
             theme(legend.title = element_blank(), 
                   axis.text.x = element_text(angle = 270, vjust = 0.25),
                   title = element_text(face = "bold")),
           tooltip = "text") %>%  
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