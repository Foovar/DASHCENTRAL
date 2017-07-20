
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "CENTRAL REPORTS"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Data", tabName = "data", icon=icon("database")),
      menuItem("Charts", tabName = "charts", icon = icon("bar-chart"), 
               menuSubItem("Llamadas a todo destino", icon = icon("phone")),
               menuSubItem("Llamadas a soporte", icon = icon("support")),
               menuSubItem("Duracion de llamadas", icon = icon("clock-o")),
               menuSubItem("Llamadas sin exito", icon = icon("exclamation")),
               menuSubItem("Congestion de llamadas", icon = icon("warning")),
               menuSubItem("Ganancias por llamadas", icon=icon("usd"))
               )
    )
  ),
  dashboardBody()
)