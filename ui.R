
library(shiny)
library(plotly)
library(dplyr)
library(rCharts)

# Remember to change this is you're not Josh
gpa <- read.csv("./resources/UWgpa.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  titlePanel("Comparing Course Grades Over Time"),
  
    sidebarPanel(
    
      textInput("text", label = h3("Select a Course"), value = "CSE 142"),
      
      helpText("Note: Syntax of class input should be abbreviation of ",
               "the class followed by the course number i.e INFO 200."),
      
      # Uncomment this line for debugging
      # verbatimTextOutput('value'),
      
      checkboxGroupInput("checkGroup", label = h3("Select Quarter(s)"),
                         choices = c(unique(as.character(gpa$Quarter))),
                         selected = c("Autumn", "Winter")),
      
      helpText("Note: Select quarter(s) to view grade distribution.")
      
      # Uncomment this line for debugging
      # ,verbatimTextOutput("selct")
      
    ),
    
    mainPanel(
      plotlyOutput("plot")
    )
   
  )
  
  
)
