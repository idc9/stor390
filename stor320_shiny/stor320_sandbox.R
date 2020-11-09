library(shiny)
library(leaflet)
library(leaflet.extras)


ui <- fluidPage(
    numericInput("lat", "Latitude", value = 35.910274),
    numericInput("lng", "Longitude", value = -79.051004),
    textInput("label", "Place", value = "You are here!"),
    leafletOutput("mymap")
)

server <- function(input, output) {
    output$mymap <- renderLeaflet({
        leaflet() %>%
            addTiles() %>%  # Add default OpenStreetMap map tiles
            addMarkers(lng = input$lng, lat = input$lat, popup = input$label) %>% 
            leaflet.extras::addSearchOSM(options = searchOptions(collapsed = FALSE))
    })
}

shinyApp(ui, server)