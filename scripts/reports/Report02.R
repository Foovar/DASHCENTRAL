call_support <- function(timeSerie, input){
  dygraph(timeSerie(), main = "") %>%
    dyOptions(drawGrid = input$showgrid,fillGraph = input$fillGraph, colors="green",
              drawPoints = input$drawpoint, pointSize = 2,fillAlpha = 0.4)%>%
    dyRangeSelector(dateWindow = input$dateRange)
}