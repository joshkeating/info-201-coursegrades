library(shiny)
library(dplyr)
library(plotly)
library(shinythemes)

shinyUI(fluidPage(

  
  theme = shinytheme("flatly"),
  headerPanel("UW GPA"),
  sidebarPanel(
    textInput(inputId = 'class', 'Pick Course', value = "All"),
    selectInput(inputId = 'year', 'Pick Year', choices = list('2010' = '2010', '2011' = '2011', '2012'='2012', '2013'= '2013', '2014'='2014', '2015'='2015'), selected = "2014")
    
  ),
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Michael Clalissa",plotlyOutput('plot'))
                ))
    
  )
)

