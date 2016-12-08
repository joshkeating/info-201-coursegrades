# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(rCharts)

# Sources the data from the /resources dir
gpa <- read.csv("./resources/UWgpa.csv")
data.filtered <- read.csv("./resources/subset.csv", stringsAsFactors = FALSE)

# creates the navbar
navbarPage("University of Washington Grades",
           tabPanel("Distribution by Quarter",
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
           
           # tab pannel for second graph
           tabPanel("GPA Distrubution by Class", 
                    
                    sidebarPanel(
                      # defines values for textInput widget 
                      textInput(inputId = 'class', 'Pick Course', value = "All"),
                      helpText("Note: Syntax of class input should be abbreviation of ",
                               "the class followed by the course number i.e INFO 200."),
                      
                      # defines values for selectInput widget 
                      selectInput(inputId = 'year', 'Pick Year', choices = list('2010' = '2010', '2011' = '2011', '2012'='2012', '2013'= '2013', '2014'='2014', '2015'='2015'), selected = "2014")
                      
                    ),
                    
                    mainPanel(
                        plotlyOutput('plot2')
                    )
                    
           ),
           
          # framing the data desc
          tabPanel("About",
                    h2("Framing the Data"),
                    p("For our final project in INFO 201, we chose for analysis a dataset of class information for each class 
                      taught at the University of Washington (Seattle) from Autumn 2010 to Winter 2016.  Specifically, we were 
                      most interested in the breakdown of the letter grading within each class. This data is anonymized and can 
                      be manipulated to highlight features that are important to current UW students. Using this data and our 
                      visualizations, the user can determine which classes have a higher average GPA when stratified by quarter."),
                    br(),
                    br(),
                    h4("Team Members:"),
                    br(),
                   p("Michael Essef"),
                   
                   p("Josh Keating"),
                   
                   p("Clalissa Yi"),
                   
                   p("Ned Sander"),
                   br(),
                   
                   
                   
                  p(
                    a("Link to github", href ="https://github.com/joshkeating/info-201-coursegrades")
                    
                  )


           )
)

