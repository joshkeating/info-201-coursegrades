# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(rCharts)

# Sources the data from the /resources dir
gpa <- read.csv("./resources/UWgpa.csv")


navbarPage("University of Washington Grades",
           tabPanel("Distribution by Quarter",
                    sidebarLayout(
                      sidebarPanel(
                        # stuff goes here
                        
                        
                        
                        # defines values for textInput widget 
                        textInput("text", label = h3("Select a Course"), value = "CSE 142"),
                        
                        # displays some help text for the user 
                        helpText("Note: Syntax of class input should be abbreviation of ",
                                 "the class followed by the course number i.e INFO 200."),
                        
                        # Uncomment this line for debugging
                        # verbatimTextOutput('value'),
                        
                        # defines values for checkboxGroupInput widget
                        checkboxGroupInput("checkGroup", label = h3("Select Quarter(s)"),
                                           choices = c(unique(as.character(gpa$Quarter))),
                                           selected = c("Autumn", "Winter")),
                        
                        # displays some help text for the user 
                        helpText("Note: Select quarter(s) to view grade distribution.")
                        
                        # Uncomment this line for debugging
                        # ,verbatimTextOutput("selct")
                        
                      
                      ),
                      mainPanel(
                        plotlyOutput("plot")
                      )
                    )
           ),
           tabPanel("Other plot"
                    
           ), 
           tabPanel("About"
                    
           )

)

  

