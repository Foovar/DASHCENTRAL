
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
setwd("/Users/Alex/Git/DASHCENTRAL")

library(shiny)
library(dplyr)
source("scripts/reports/Report01.R")

log <- read.csv("input/Log.csv")
colnames(log) <- list( "src", "dst", "dcontext", "clid", "channel", "dstchannel", "lastapp", "lastdata", "start", "answer", "end", "duration", "billsec", "disposition", "amaflags", "uniqueid", "ip", "port" )

shinyServer(function(input, output) {

 output$table <- DT::renderDataTable({
   DT::datatable(log[ ,c(1,2,13,14, 9, 11)])
 })
 
 output$tcalls <- renderValueBox(
   {
     valueBox(format(length(log$src), digits = 3,  big.mark = ","), "Total de Llamadas", icon = icon("phone"), color="yellow")
   }
 )
 
 output$report01 <- renderDygraph({
   daily_report(log)
 })
 
 
})
