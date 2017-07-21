
source("scripts/functions.R")

congestion_calls <- function(congestion, input){
  test <- sin_exito(congestion$start)
  datats <- xts(x=test$total, order.by = strptime(test$fecha, format='%Y-%m-%d %H'))
  
  dygraph(datats, main = "Llamadas sin éxito por congestion.", ylab = "Total") %>% 
    dySeries("V1", label="Total") %>% 
    dyOptions(drawGrid = input$showgrid05,fillGraph = input$fillGraph05, drawPoints = input$drawpoint05, colors=c("red"), pointSize = 2) %>%  
    dyRangeSelector(dateWindow =date_range(test$fecha, 7 * 24))
}