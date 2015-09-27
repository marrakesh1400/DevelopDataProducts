# ui.R:

shinyUI(pageWithSidebar(
  headerPanel("Easy UTM coordinate conversion"),
  sidebarPanel(
    h3('Documentation:'),
    h4('Enter your latitude and longitude or use the defaults to find Universal Transmercator coordinates for the White House.
        Latitude must be between -90 and +90 and longitude must be between -180 and +180. Negative latitude values
        are for southern hemisphere and negative longitude values are for the western hemisphere. Press Submit
       and you will receive back the UTM easting and northing as well the UTM zone (1-60), as well as a map
       of your location. Give it a try!'),
    # input boxes for 
    numericInput('lat', 'Enter the latitude',value = 38.89776, min = -90, max = 90, step = 0.01,),
    numericInput('lon', 'Enter the longitude',value = -77.0365, min = -180, max = 180, step = 0.01,),
    # submit button
    submitButton('Submit')
  ),
  mainPanel(
    h4("The UTM Easting is:"),
    textOutput('easting'),
    h4("The UTM Northing is:"),
    textOutput('northing'),
    h4("The UTM Zone is:"),
    textOutput('zone'),
    plotOutput('sweetMap')
  )
))