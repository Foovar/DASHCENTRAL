
source("scripts/functions.R")

failed_calls <- function(callfailed, input){
  indices <- c(1:4)
  xx <- hours(callfailed)
  tsdata = xts(x = xx[,-1], order.by = strptime(xx[,1], format='%Y-%m-%d %H'))
  
  dygraph(tsdata[, c(input$busy,input$congestion, input$failed, input$no_answer)], main = "") %>%
    dyOptions( drawPoints = T, pointSize = 2, colors = RColorBrewer::brewer.pal(4, "Set1")) %>%
    dyRangeSelector(dateWindow =  input$dateRan)
}