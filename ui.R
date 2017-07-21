
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
  dashboardHeader(title = "CENTRAL REPORTS"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Data", tabName = "data", icon=icon("database"), badgeLabel = "procesada"),
      menuItem("Charts", tabName = "charts", icon = icon("bar-chart"), 
               menuSubItem("Llamadas a todo destino", tabName = "report01", icon = icon("phone")),
               menuSubItem("Llamadas a soporte", icon = icon("support")),
               menuSubItem("Duracion de llamadas", icon = icon("clock-o")),
               menuSubItem("Llamadas sin exito", icon = icon("exclamation")),
               menuSubItem("Congestion de llamadas", icon = icon("warning")),
               menuSubItem("Ganancias por llamadas", icon=icon("usd"))
               )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard", fluidRow(
        valueBox(10 * 2, "New Orders", icon = icon("credit-card")),
        valueBox(10 * 2, "New Orders", icon = icon("credit-card"), color = "purple"),
        valueBoxOutput("tcalls"),
        box(
          title = "Controls",
          sliderInput("slider", "Number of observations:", 1, 100, 50)
        )
      )),
      
      tabItem(tabName = "data", fluidRow(
          DT::dataTableOutput("table"))),
      
      tabItem(tabName = "report01", dygraphOutput("report01"))
    )
  )
)