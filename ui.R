
library(shiny)
library(plotly)
library(dplyr)
library(rCharts)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

  titlePanel("Comparing Course Grades Over Time"),
  
    sidebarPanel(
    
      textInput("text", label = h3("Select a Course"), value = "CSE 142"),
      verbatimTextOutput('value'),
      
      checkboxGroupInput("checkGroup", label = h3("Quarter Selection"), 
                         choices = list("Autumn" = "Autumn", "Winter" = "Winter", "Spring" = "Spring", "Summer" = "Summer"),
                         selected = "Winter"),
      
      # selected = c("Autumn", "Winter", "Spring", "Summer")
      # list("Autumn" = Autumn, "Winter" = Winter, "Spring" = Spring, "Summer" = Summer)
      # list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3)
      
      
      verbatimTextOutput("selct")
      
  
      
      
    ),
    
    mainPanel(
      
      dataTableOutput('table')
      
    )
    
    
    
    # column(4,
    #        
    #        # Copy the line below to make a slider range 
    #        sliderInput("slider1", label = h3("Year(s) Range"), min = 2010, 
    #                    max = 2016, year_range = c(2014, 2015))
    # ),
    
    
    
    
    # column(3, wellPanel(
    #   selectInput("input_type", "Input type",
    #               c("slider", "text", "numeric", "checkbox",
    #                 "checkboxGroup", "radioButtons", "selectInput",
    #                 "selectInput (multi)", "date", "daterange"
    #               )
    #   )
    # )),
    # 
    # column(3, wellPanel(
    #   # This outputs the dynamic UI component
    #   uiOutput("ui")
    # )),
    # 
    # column(3,
    #        tags$p("Input type:"),
    #        verbatimTextOutput("input_type_text"),
    #        tags$p("Dynamic input value:"),
    #        verbatimTextOutput("dynamic_value")
    # )
  )
  
  
)
