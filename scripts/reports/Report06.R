library(dplyr)
source("scripts/functions.R")

earnings_calls <- function(calls, input){
  duracion <- aggregate(billsec ~ as.Date(start, format="%Y-%m-%d"), calls, sum)
  colnames(duracion) <- list("start", "billsec")
  duracion$billsec <- ((duracion$billsec / 60) * 0.25) / 10;
  dts <- timeSD(duracion$billsec, duracion$start)
  dygraph(dts, main = "Ganancias por llamadas diarias.", ylab = "Soles") %>% 
    dySeries("V1", label="Total") %>% 
    dyOptions(fillGraph =T,  drawPoints = T, drawGrid = F, colors=c("green"), pointSize = 2) %>% 
    dyRangeSelector(dateWindow = input$dateRange)
}