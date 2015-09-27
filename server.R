# server.R
library(sp)
library(rgdal)
require(maps)

# function to convert longitude to UTM zone
UTMzone <- function(x){
  zone <- ceiling((x + 180)/6)
  return(zone)
}

# function to convert long/latitude to UTM coordinates
LongLatToUTM<-function(x,y,zone){
  xy <- data.frame(ID = 1:length(x), X = x, Y = y)
  coordinates(xy) <- c("X", "Y")
  proj4string(xy) <- CRS("+proj=longlat +datum=WGS84")  ## for example
  res <- spTransform(xy, CRS(paste("+proj=utm +zone=",zone," ellps=WGS84",sep='')))
  resdf = (as.data.frame(res))
  return(resdf)
}

# configure shiny server
shinyServer(
  function(input, output) {
    output$zone    <- renderText({UTMzone(input$lon)})    
    output$easting <- renderText({unlist(LongLatToUTM(input$lon, input$lat, UTMzone(input$lon))[2])})
    output$northing <- renderText({unlist(LongLatToUTM(input$lon, input$lat, UTMzone(input$lon))[3])})
    output$sweetMap <- renderPlot({
      map("world", fill=TRUE, col="white", bg="lightblue", ylim=c(-90, 90), mar=c(0,0,0,0))
      points(input$lon, input$lat, col = "red", pch = 16, cex = 2)
    })
  }
)


