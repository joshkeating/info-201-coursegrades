
library(shiny)
library(plotly)
library(dplyr)
library(rCharts)

base_grades <- read.csv("/home/josh/School_16-17/Info-201/info-201-coursegrades/resources/UW-Seattle_20110-20161-Course-Grade-Data_2016-04-06.csv")
gpa <- read.csv("/home/josh/School_16-17/Info-201/info-201-coursegrades/resources/UWgpa.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  
  # Text input widget 
  output$value <- renderPrint({ input$text })
  
  output$selct <- renderPrint({ input$checkGroup })
  
  
  datasetInput <- reactive({
    
    trimmed.course <- filter(gpa, Class == toupper(input$text))
    
    tr2 <- filter(trimmed.course, Quarter == input$checkGroup)
    
    return(trimmed.course)

  })
  
  
  
  
  output$table <- renderDataTable({datasetInput()})
  
  
  
  

  # Slider widget for year selection
  # output$range <- renderPrint({ input$slider1 })
  
  # output$ui <- renderUI({
  #   if (is.null(input$input_type))
  #     return()
  #   
  #   switch(input$input_type,
  #          "slider" = sliderInput("dynamic", "Dynamic",
  #                                 min = 1, max = 20, value = 10),
  #          "text" = textInput("dynamic", "Dynamic",
  #                             value = "starting value"),
  #          "numeric" =  numericInput("dynamic", "Dynamic",
  #                                    value = 12),
  #          "checkbox" = checkboxInput("dynamic", "Dynamic",
  #                                     value = TRUE),
  #          "checkboxGroup" = checkboxGroupInput("dynamic", "Dynamic",
  #                                               choices = c("Option 1" = "option1",
  #                                                           "Option 2" = "option2"),
  #                                               selected = "option2"
  #          ),
  #          "radioButtons" = radioButtons("dynamic", "Dynamic",
  #                                        choices = c("Option 1" = "option1",
  #                                                    "Option 2" = "option2"),
  #                                        selected = "option2"
  #          ),
  #          "selectInput" = selectInput("dynamic", "Dynamic",
  #                                      choices = c("Option 1" = "option1",
  #                                                  "Option 2" = "option2"),
  #                                      selected = "option2"
  #          ),
  #          "selectInput (multi)" = selectInput("dynamic", "Dynamic",
  #                                              choices = c("Option 1" = "option1",
  #                                                          "Option 2" = "option2"),
  #                                              selected = c("option1", "option2"),
  #                                              multiple = TRUE
  #          ),
  #          "date" = dateInput("dynamic", "Dynamic"),
  #          "daterange" = dateRangeInput("dynamic", "Dynamic")
  #   )
  #   
  #   
  #   
  #   
  # })
  # 
  # 
  # output$input_type_text <- renderText({
  #   input$input_type
  # })
  # 
  # output$dynamic_value <- renderPrint({
  #   str(input$dynamic)
  # })
  # 
  # 
})
