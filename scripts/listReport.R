setwd("/home/DASHCENTRAL/")
library(dplyr)
library(highcharter)
library(zoo)
library(xts)
library(dygraphs)

log <- read.csv("/home/R-CENTRAL/input/Log.csv")
colnames(log) <- list( "src", "dst", "dcontext", "clid", "channel", "dstchannel", "lastapp", "lastdata", "start", "answer", "end", "duration", "billsec", "disposition", "amaflags", "uniqueid", "ip", "port" )
calls <- log[log$answer != "", ]
callfailed <- log[log$answer == "" & log$dst != "123" , ]
callsupport <- log[log$dst == "123", ]
congestion <- callfailed[callfailed$disposition == "CONGESTION", ]

#Llamadas realizadas a atencion cliente por dia

callsupport$start <- gsub("([0-9]+:[0-9]+:[0-9]+)","", callsupport$start)
callsupport_repot <- data.frame(callsupport$start, c(0))
colnames(callsupport_repot)<-list("date", "value")
callsupport_repot <-callsupport_repot %>%
  group_by(date) %>%
  summarise(n())
colnames(callsupport_repot)<-list("date", "value")
##convertir a tipo date
callsupport_repot$date <-strptime(as.character(callsupport_repot$date), "%Y-%m-%d")
#callsupport_repot$date <- as.Date(callsupport_repot$date)
soporteTS<- xts(x=callsupport_repot$value,order.by = callsupport_repot$date, format='%Y-%M-%d')

#Numero de llamadas a atencion cliente por dia
dygraph(soporteTS, main = "N° de llamadas a callcenter por dia") %>%
  dySeries("V1", label="Total") %>% 
  dyOptions(drawPoints = T, pointSize = 2,fillGraph = TRUE, fillAlpha = 0.4) %>%
  dyRangeSelector(height = 40)
##############

#Llamadas diarias a todo destino
daily <- daily_count(calls$start)
dts <- timeS(daily$total, daily$fecha)
dygraph(dts, main = "Reporte. Llamadas diarias a todo destino.") %>% 
  dySeries("V1", label="Total") %>% 
  dyOptions(fillGraph = T, colors=c("green"), pointSize = 2) %>%  
  dyRangeSelector(dateWindow =date_range(daily$fecha, 7 * 24))
#################################


## Duracion de llamadas diarias
#tcalls <- calls %>% group_by(as.Date(start)) %>% summarise(n())
#dts <- timeSD(tcalls[, -1], tcalls[,1])

#dygraph(dts, main = "Reporte. Duracion de llamadas diarias.") %>% 
#  dySeries("V1", label="Total Segundos: ") %>% 
#  dyOptions( colors=c("blue"), pointSize = 2) %>%  
#  dyRangeSelector(dateWindow =date_range(daily$fecha, 7 * 24))
###########################################################


##Reporte de llamadas sin exito
test <- sin_exito(callfailed$start)
datats <- xts(x=test$total, order.by = strptime(test$fecha, format='%Y-%m-%d %H'))

dygraph(datats, main = "Reporte. Llamadas sin exito.") %>% 
  dySeries("V1", label="Total") %>% 
  dyOptions(fillGraph = T, colors=c("red"), pointSize = 2) %>%  
  dyRangeSelector(dateWindow =date_range(test$fecha, 7 * 24))
#############################################################

### Llamadas sin exito por congestion.
test <- sin_exito(congestion$start)
datats <- xts(x=test$total, order.by = strptime(test$fecha, format='%Y-%m-%d %H'))

dygraph(datats, main = "Reporte. Llamadas sin exito por congestion.") %>% 
  dySeries("V1", label="Total") %>% 
  dyOptions(fillGraph = T, colors=c("red"), pointSize = 2) %>%  
  dyRangeSelector(dateWindow =date_range(test$fecha, 7 * 24))
####################################################


##Reporte de llamadas 
x <- log$disposition
hchart(as.character(x), type = "pie")
#################################

##### PIE llamadas sin exito
xx <- hours(callfailed)
tsdata = xts(x = xx[,-1], order.by = strptime(xx[,1], format='%Y-%m-%d %H'))

dygraph(tsdata, main = "Reporte. Llamadas sin éxito.") %>%
  dyOptions( drawPoints = T, pointSize = 2, colors = RColorBrewer::brewer.pal(4, "Set1")) %>%
  dyRangeSelector(dateWindow = c(as.character( xx$fecha[length(xx$fecha) - 168] ),as.character(tail(xx[,1],1))))



