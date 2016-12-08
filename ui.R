# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)

# Sources the data from the /resources dir
gpa <- read.csv("./resources/UWgpa.csv")


navbarPage("University of Washington Grades",
           tabPanel("Distribution by Quarter",
                    
                    
                    h2("Grade Distribution Over Time"),
                    br(),
                    p("This interactive vizualization allows you to select a course and filter by quarter to view that",
                      " particular classes distribution over time.  By hovering over the data, you can view the year,",
                      "professor, quarter, and average GPA of that class."
                      ),
                    br(),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                       
                        
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
           tabPanel("About",
                    titlePanel("Framing The Data"),
                    br(),
                    p("For our project we chose a dataset of all the class grades from the University of Washington from
                      2010 to 2016.  This data is anonymized and can be manipulated to highlight features that are important to 
                      current UW students. Using this data and our visualizations, the user can determine which classes have
                      higher average GPA when stratified by quarter."
      
                    )
                    
           )

)

  

