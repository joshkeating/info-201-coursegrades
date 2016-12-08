# Required libraries and packages
library(shiny)
library(plotly)
library(dplyr)
library(reshape2)
# Sources the data from the /resources dir
gpa <- read.csv("./resources/UWgpa.csv")
data.filtered <- read.csv("./resources/subset.csv", stringsAsFactors = FALSE)
# Renames the GPA columns to something more readable
gpa <- rename(gpa, "A-" = A., "B+"=B., "B"=B, "B-"=B..1, "C+"=C., "C"=C, "C-"=C..1, "D+"=D., "D"=D, "D-"=D..1)
data.filtered <- rename(data.filtered, "A-" = A., "B+"=B., "B"=B, "B-"=B..1, "C+"=C., "C"=C, "C-"=C..1, "D+"=D., "D"=D, "D-"=D..1)
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
    trimmed.course$Color <- trimmed.course$Quarter
    
    # sets NA values to 0
    trimmed.course[is.na(trimmed.course)] <- 0
    
    quarter.color <- c(Autumn = "#ffb380", Winter = "#66a3ff", Spring ="#66ff66", Summer = "#ffff80")
    
    
    # melts the data into something that is plotable by ggplot
    trimmed.course_head <- trimmed.course
    trimmed.course_head_melt <- melt(trimmed.course_head[11:24], id.vars = c('Teacher', "Color"))
    p <- ggplot(data = trimmed.course_head_melt, aes(x = variable, y = value, group = Teacher, colour = Color)) + 
      ylab('Number of Students') + xlab('Grade Given') + 
      geom_line(alpha = 0.7) + scale_color_manual(values = quarter.color) + theme_minimal()
    
    return(p)
    
    
    
  })
  
  BuildPlot <- function(data.filtered) {
    
    ax <- list(
      title = "Quarter",
      showticklabels = FALSE,
      range = c(0, 40),
      dtick = 10
    )
    
    # xvar <- paste0('~', df$X.shift)
    # yvar <- paste0('~', df$Average_GPA)
    # plot.color1 <- ((df$X.shift %% 10)*100)
    # plot.color2 <- paste0('~', plot.color1)
    
    
    plot_ly(
      data = data.filtered, x = ~X.shift, y = ~Average_GPA, type = 'scatter', mode = 'markers',
      color = ((data.filtered$X.shift %% 10)*100), size = ~Student_Count, hoverinfo = "text", marker = list(colorbar = list(title='Class Size' )),
      colors = c("#a9efef", "#008ae6"),
      text = ~paste("Course Title: ", Class, ", Average GPA: ", Average_GPA)) %>%
      layout(xaxis = ax,  yaxis = list(title = "Average GPA")) %>% 
      
      #Puts labels on the X Axis for each Quarter
      add_annotations(x = c(5,15,25,35),
                      y = c(1.7,1.7,1.7,1.7),
                      text = c("Autumn","Winter","Spring","Summer"),
                      xref = "x",
                      yref = "y",
                      showarrow = FALSE)}
  
  
  
  # Use this to debug filtering functions
  
  # output$table <- renderDataTable({
  #   datasetInput()
  # })
  
  # sends the datasetInput() plot into renderPlotly
  
  output$plot <- renderPlotly({
    ggplotly(datasetInput())
  })
  
  output$plot2 <- renderPlotly({
    
    if (input$class == "All"){
      
      df.choose <- data.filtered %>%
        filter(data.filtered$Year == input$year)
      
      return(BuildPlot(df.choose))
    }
    
    else{
      df.choose <- data.filtered %>%
        filter(data.filtered$Year == input$year & data.filtered$Class ==  toupper(input$class))
      
      return(BuildPlot(df.choose))}
    
  })
  
  
})
