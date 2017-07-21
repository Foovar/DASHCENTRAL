
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
setwd("/Users/Alex/Git/DASHCENTRAL")

library(shiny)
library(dplyr)
library(highcharter)
source("scripts/reports/Report01.R")

log <- read.csv("input/Log.csv")
colnames(log) <- list( "src", "dst", "dcontext", "clid", "channel", "dstchannel", "lastapp", "lastdata", "start", "answer", "end", "duration", "billsec", "disposition", "amaflags", "uniqueid", "ip", "port" )
calls <- log[log$answer != "", ]
callfailed <- log[log$answer == "" & log$dst != "123" , ]
callsupport <- log[log$dst == "123", ]
congestion <- callfailed[callfailed$disposition == "CONGESTION", ]
users <- unique(calls[c("src")])
users <- users$src

shinyServer(function(input, output) {

 output$table <- DT::renderDataTable({
   DT::datatable(log[ ,c(1,2,13,14, 9, 11)])
 })
 
 #GANANCIAS TOTALES
 output$tearnings <- renderValueBox(
   {valueBox(paste0("S/.",format((sum(calls$billsec) / 60) * 0.20, digits = 3,  big.mark = ",")), "Ganancias Totales", icon = icon("usd"))}
 )
 # TOTAL DE LLAMADAS
 output$tcalls <- renderValueBox(
   {valueBox(format(length(log$src), digits = 3,  big.mark = ","), "Total de Llamadas", icon = icon("phone"), color="yellow")}
 )
 
 # TOTAL DE USUARIOS
 output$tusers <- renderValueBox(
   {
     valueBox(format( length(users), digits = 3,  big.mark = ","), "Cantidad de Usuarios", icon = icon("group"), color = "purple" )
   }
 )
 

 output$pcalls <- renderHighchart({
   hchart(as.character(log$disposition), type = "pie")
 })
 
 
 #REPORTES
 
 ## REPORTE DE LLAMADAS DIARIAS
 output$report01 <- renderDygraph({
   daily_report(log)
 })
 
 
})
