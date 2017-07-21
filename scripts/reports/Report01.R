# LLAMADAS DIARIAS A TODO DESTINO

source("scripts/functions.R")

daily_report <- function(calls){
  daily <- daily_count(calls$start)
  dts <- timeS(daily$total, daily$fecha)
  return(dygraph(dts, main = "Llamadas diarias a todo destino.", ylab = "Total") %>% 
    dySeries("V1", label="Total") %>% 
    dyOptions(fillGraph = T, colors=c("green"), pointSize = 2) %>%  
    dyRangeSelector(dateWindow =date_range(daily$fecha, 7 * 24)))
}