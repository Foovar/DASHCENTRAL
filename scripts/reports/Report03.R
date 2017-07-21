library(dplyr)
source("scripts/functions.R")

call_duration <- function(calls, input){
  duracion <- aggregate(billsec ~ as.Date(start, format="%Y-%m-%d"), calls, sum)
  colnames(duracion) <- list("start", "billsec")
  duracion$billsec <- duracion$billsec / 60;
  dts <- timeSD(duracion$billsec, duracion$start)
  dygraph(dts, main = "Duracion de Llamadas diarias.") %>% 
    dySeries("V1", label="Total") %>% 
    dyOptions(fillGraph = T, colors=c("blue"), pointSize = 2) %>% 
  dyRangeSelector(dateWindow = input$dateRange)
}