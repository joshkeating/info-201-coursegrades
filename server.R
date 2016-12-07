
library(shiny)
library(plotly)
library(dplyr)
library(reshape2)
library(RColorBrewer)

# Remember to change this is you're not Josh
gpa <- read.csv("/home/josh/School_16-17/Info-201/info-201-coursegrades/resources/UWgpa.csv")

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
    trimmed.course$W <- NULL
    trimmed.course$Teacher <- paste(trimmed.course$Primary_Instructor,"<br>","Section:", trimmed.course$Class.2, "<br>", 
                                    "Quarter:", stringr::str_sub(trimmed.course$Term, 8, -2),  "<br>", "Avg GPA:",
                                    trimmed.course$Average_GPA)

    trimmed.course$Quarter_Color <- trimmed.course$Quarter
    
    trimmed.course[is.na(trimmed.course)] <- 0
    trimmed.course_head <- trimmed.course
    trimmed.course_head_melt <- melt(trimmed.course_head[11:24], id.vars = c('Teacher', "Quarter_Color"))
    p <- ggplot(data = trimmed.course_head_melt, aes(x = variable, y = value, group = Teacher, colour = Quarter_Color)) + 
      ylab('Number of Students') + xlab('Grade Given') + 
      geom_line(alpha = 0.7) + theme_minimal()
    
    return(p)

  })
  
  # this is for the table --------------------------------------------
  
  # output$table <- renderDataTable({
  #   datasetInput()
  # })
  
  # this is the plot stuff -------------------------------------------
  
  output$plot <- renderPlotly({
    ggplotly(datasetInput())
  })
  
})
