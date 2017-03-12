library(shiny)
library(ggplot2)
library(SPARQL) 

# Step 1 - Set up preliminaries and define query
# Define the statistics.gov.scot endpoint
endpoint <- "http://statistics.gov.scot/sparql"

# create query statement
query <-
"PREFIX qb: <http://purl.org/linked-data/cube#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?year ?sector ?CO2
WHERE {
?s qb:dataSet <http://statistics.gov.scot/data/greenhouse-gas-emissions-by-source-sector>;
<http://statistics.gov.scot/def/dimension/greenhouseGasSourceSector> ?SectorURI;
<http://purl.org/linked-data/sdmx/2009/dimension#refPeriod> ?yearURI;
<http://statistics.gov.scot/def/dimension/pollutant> <http://statistics.gov.scot/def/concept/pollutant/co2>;
<http://statistics.gov.scot/def/measure-properties/count> ?CO2.
?SectorURI rdfs:label ?sector.
?yearURI rdfs:label ?year.
}
ORDER BY ?year ?sector"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qdata <- SPARQL(endpoint,query)
CO2data <- qdata$results
theme_set(theme_gray(base_size = 18))

function(input, output) {

# Step 3 Set it up for the check boxes for source sectors
  data_1=reactive({
    return(CO2data[CO2data$sector%in%input$source_choose,])
  })
  
# Step 4 Use ggplot2 to draw a basic linechart
output$plot <- renderPlot({

# Step 5 Set it up so the year chooser updates the chart
g <- ggplot(data=subset( data_1(),  year>= input$range[1] & year<= input$range[2]), aes(x=year, y=CO2, group=sector)) +     geom_line(aes(color=sector), size=1.0)+ theme(legend.position="bottom")
g <- g + labs (x="Year", y="CO2 Mt") 
g <- g + guides(col = guide_legend(nrow = 5),byrow=TRUE)  + theme(legend.title=element_blank())

print(g)

})
}

