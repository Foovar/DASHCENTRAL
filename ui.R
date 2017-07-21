
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# Central telefonica - Mainframe UPAO
# 
library(shiny)
library(shinydashboard)
library(dygraphs)

dashboardPage(
  dashboardHeader(title = "CENTRAL REPORTS", dropdownMenu(
    type = "messages", icon = icon("group"), headerText = "Integrantes",
    messageItem(
      from = "Paredes Enriquez, Alex",
      message = "",
      icon = icon("user")
    ),
    messageItem(
      from = "Layza Quiroz, Diego",
      message = "",
      icon = icon("user")
    ),
    messageItem(
      from = "Requejo Velasquez, Jordan",
      message = "",
      icon = icon("user")
    )
  )),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Data", tabName = "data", icon=icon("database"), badgeLabel = "procesada"),
      menuItem("Charts", tabName = "charts", icon = icon("bar-chart"), 
               menuSubItem("Llamadas a todo destino", tabName = "report01", icon = icon("phone")),
               menuSubItem("Llamadas a soporte", tabName = "report02", icon = icon("support")),
               menuSubItem("Duracion de llamadas", tabName = "report03", icon = icon("clock-o")),
               menuSubItem("Llamadas sin exito", tabName = "report04", icon = icon("exclamation")),
               menuSubItem("Congestion de llamadas", tabName = "report05", icon = icon("warning")),
               menuSubItem("Ganancias por llamadas", tabName = "report06", icon=icon("usd"))
               )
    ),
    h3(align = "center", "UPAO")
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard", fluidRow(
        valueBoxOutput("tearnings"),
        valueBoxOutput("tusers"),
        valueBoxOutput("tcalls"),
        box(highchartOutput("pcalls"), status = "primary"),
        box(title = "Ultimas llamadas realizadas.")
      )),
      
      tabItem(tabName = "data", fluidRow(
          DT::dataTableOutput("table"))),
      
      tabItem(tabName = "report01", dygraphOutput("report01")),
      
      tabItem(tabName = "report02", sidebarPanel(
        dateRangeInput('dateRange', label = paste('Fecha Inicio - ', " Fecha Fin"),
                       start = as.Date("2017-07-17"), end = as.Date("2017-08-17"),
                       min = as.Date("2017-07-14"), max = as.Date("2017-10-17"),
                       separator = " - ", format = "yyyy-mm-dd"),
        checkboxInput("showgrid", label = "Showgrid", value = TRUE),
        checkboxInput("fillGraph", label = "Fill graph", value = TRUE),
        checkboxInput("drawpoint", label = "Draw points", value = TRUE)
      ), box(dygraphOutput("report02"), width = 8, title = "LLamadas diarias a atencion al cliente.")),
      
      
      tabItem(tabName = "report04", sidebarPanel(
        dateRangeInput('dateRan', label = paste('Fecha Inicio - ', " Fecha Fin"),
                       start = as.Date("2017-10-13"), end = as.Date("2017-10-18"),
                       min = as.Date("2017-07-14"), max = as.Date("2017-10-20"),
                       separator = " - ", format = "yyyy-mm-dd"),
        checkboxInput("busy", label = "Busy", value = 1),
        checkboxInput("congestion", label = "Congestion", value = 2),
        checkboxInput("failed", label = "Failed", value = 3),
        checkboxInput("no_answer", label = "No Answer", value = 4)
      ), box(dygraphOutput("report04") , width = 8, title="Llamadas sin exito.", solidHeader = T, collapsible = T, status = "primary")),
      
      tabItem(tabName = "report05", sidebarPanel(
        dateRangeInput('dateRange', label = paste('Fecha Inicio - ', " Fecha Fin"),
                       start = as.Date("2017-07-17"), end = as.Date("2017-08-17"),
                       min = as.Date("2017-07-14"), max = as.Date("2017-10-17"),
                       separator = " - ", format = "yyyy-mm-dd"),
        checkboxInput("showgrid05", label = "Showgrid", value = TRUE),
        checkboxInput("fillGraph05", label = "Fill graph", value = TRUE),
        checkboxInput("drawpoint05", label = "Draw points", value = TRUE)
      ), box(dygraphOutput("report05"), width = 8))
      
    )
  )
)

#box( dygraphOutput("report01") ),