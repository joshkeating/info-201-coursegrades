
library(shiny)
library(plotly)
library(dplyr)
library(rCharts)

# Remember to change this is you're not Josh
gpa <- read.csv("/home/josh/School_16-17/Info-201/info-201-coursegrades/resources/UWgpa.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  titlePanel("Comparing Course Grades Over Time"),
  
    sidebarPanel(
    
      textInput("text", label = h3("Select a Course"), value = "CSE 142"),
      verbatimTextOutput('value'),
      
      checkboxGroupInput("checkGroup", label = h3("Select Quarter(s)"), 
                         choices = c(unique(as.character(gpa$Quarter))),
                         selected = c("Autumn", "Winter")),
      
      # selected = c("Autumn", "Winter", "Spring", "Summer")
      # list("Autumn" = Autumn, "Winter" = Winter, "Spring" = Spring, "Summer" = Summer)
      # list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3)
      
      
      verbatimTextOutput("selct")
      
      
    ),
    
    mainPanel(
      plotlyOutput("plot")
      
      # dataTableOutput('table')
      
    )
   
  )
  
  
)
