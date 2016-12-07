# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(reshape2)

# Sources the data from the /resources dir
gpa <- read.csv("./resources/UWgpa.csv")

# Renames the GPA columns to something more readable
gpa <- rename(gpa, "A-" = A., "B+"=B., "B"=B, "B-"=B..1, "C+"=C., "C"=C, "C-"=C..1, "D+"=D., "D"=D, "D-"=D..1)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  # Text input widget
  output$value <- renderPrint({ input$text })
  
  # Checkbox group input widget
  output$selct <- renderPrint({ input$checkGroup })
  
  # Reactive function that wrangles the dataset based on the user input from the two widgets
  datasetInput <- reactive({
    
    # These two validate functions check for valid input from the two widgets and display a help string if needed
    validate(
      need(input$text != "", 'Please enter a class.')
    )
    validate(
      need(input$checkGroup != "", 'Please choose at least one quarter.')
    )
    
    # filters the data based on the input text and quarters selected
    trimmed.course <- filter(gpa, Class == toupper(input$text), Quarter %in% input$checkGroup)
    
    # removes dropped class data
    trimmed.course$W <- NULL
    
    # builds hover data for each class
    trimmed.course$Teacher <- paste(trimmed.course$Primary_Instructor,"<br>","Section:", trimmed.course$Class.2, "<br>", 
                                    "Quarter:", stringr::str_sub(trimmed.course$Term, 8, -2),  "<br>", "Avg GPA:",
                                    trimmed.course$Average_GPA)
    
    # adds Quarter_Color col for coloring by quarter
    trimmed.course$Quarter_Color <- trimmed.course$Quarter
    
    # sets NA values to 0
    trimmed.course[is.na(trimmed.course)] <- 0
    
    # melts the data into something that is plotable by ggplot
    trimmed.course_head <- trimmed.course
    trimmed.course_head_melt <- melt(trimmed.course_head[11:24], id.vars = c('Teacher', "Quarter_Color"))
    p <- ggplot(data = trimmed.course_head_melt, aes(x = variable, y = value, group = Teacher, colour = Quarter_Color)) + 
      ylab('Number of Students') + xlab('Grade Given') + 
      geom_line(alpha = 0.7) + theme_minimal()
    
    return(p)

  })
  
  # Use this to debug filtering functions
  
  # output$table <- renderDataTable({
  #   datasetInput()
  # })
  
  # sends the datasetInput() plot into renderPlotly
  
  output$plot <- renderPlotly({
    ggplotly(datasetInput())
  })
  
})
