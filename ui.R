library(shiny)
library(ggplot2)



fluidPage(



  # Sidebar 
  sidebarPanel(
    headerPanel("CO2 emissions by source sector, Scotland"),
  
  # Specification of range within an interval
  sliderInput("range", "Select years:",
              min = 1990, max = 2014, value = c(1998,2014),sep = ""),
  
  # Check boxes for the source sectors
  checkboxGroupInput("source_choose", label = "Select source sectors",
                     choices = c("Agriculture and Related Land Use",
                                 "Business and Industrial Process",
                                 "Development",
                                 "Energy Supply",
                                 "Forestry",
                                 "International Aviation and Shipping",
                                 "Public Sector Buildings",
                                 "Residential",
                                 "Transport (excluding international aviation and shipping)",
                                 "Waste Management"), 
                                  selected = c("Agriculture and Related Land Use",
                                               "Business and Industrial Process",
                                               "Development",
                                               "Energy Supply",
                                               "Forestry",
                                               "International Aviation and Shipping",
                                               "Public Sector Buildings",
                                               "Residential",
                                               "Transport (excluding international aviation and shipping)",
                                               "Waste Management"))),

  mainPanel(
    tags$head(tags$style("#plot{height:100vh !important;}")),
    plotOutput('plot')
  )
)