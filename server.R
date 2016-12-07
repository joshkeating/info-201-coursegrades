
library(shiny)
library(plotly)
library(dplyr)
library(reshape2)
library(rCharts)

# Remember to change this is you're not Josh
gpa <- read.csv("/home/josh/School_16-17/Info-201/info-201-coursegrades/resources/UWgpa.csv")


# gpa[is.na(gpa)] <- 0
gpa <- rename(gpa, "A-" = A., "B+"=B., "B"=B, "B-"=B..1, "C+"=C., "C"=C, "C-"=C..1, "D+"=D., "D"=D, "D-"=D..1)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  
  # Text input widget 
  output$value <- renderPrint({ input$text })
  
  output$selct <- renderPrint({ input$checkGroup })
  
  
  datasetInput <- reactive({
   
    validate(
      need(input$text != "", 'Please enter a class.')
    )
    validate(
      need(input$checkGroup != "", 'Please choose at least one quarter.')
    )
    trimmed.course <- filter(gpa, Class == toupper(input$text), Quarter %in% input$checkGroup)
    
    
    trimmed.course <- select(trimmed.course, 11:22, Student_Count)
    trimmed.course[is.na(trimmed.course)] <- 0
    trimmed.course$row <- rownames(trimmed.course)
    # Creates data frame with row column and total students column from trimmed.course
    st <- data.frame('row' = numeric(nrow(trimmed.course)), 'total' = numeric(nrow(trimmed.course)))
    st$row <- trimmed.course[,'row']
    st$total <- trimmed.course[,'Student_Count']
    trimmed.course$Student_Count <- NULL
    trimmed.course_melt = melt(trimmed.course, id.vars = 'row')
    # this graphs the data in ggplot
    p <- ggplot(data = trimmed.course_melt, aes(x = variable, y = value, group = row, color = row)) +
      ylab('# of Students') + xlab('Grade Given') + 
      # geom_line() + theme_minimal()
    
     geom_smooth(method = 'loess', se = FALSE)
    
    return(p)

  })
  
  # this is for the table --------------------------------------------
  
  # output$table <- renderDataTable({
  #   datasetInput()
  # })
  
  # this is the plot stuff --------------------------------------------
  
  output$plot <- renderPlotly({
    ggplotly(datasetInput())
  })
  
  
  
})
