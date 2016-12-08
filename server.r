
#### SHINY 

shinyServer(function(input, output) {

  ax <- list(
    title = "Quarter",
    showticklabels = FALSE,
    range = c(0, 40),
    dtick = 10
  )
  
  BuildPlot <- function(data.filtered) {
    
    xvar <- paste0('~', X.shift)
    yvar <- paste0('~', Average_GPA)
    plot.color1 <- ((X.shift %% 10)*100)
    plot.color2 <- paste0('~', plot.color1)
    
    
    plot_ly(
      data=data.filtered, x = eval(parse(text = xvar)), y = eval(parse(text=yvar)), type = 'scatter', mode = 'markers',
      color = plot.color2, size = ~Student_Count, hoverinfo = "text", marker = list(colorbar = list(title='Class Size' )),
      colors = c("#a9efef", "#008ae6"),
      text = ~paste("Course Title: ", df$Class, ", Average GPA: ", df$Average_GPA)) %>%
      layout(xaxis = ax,  yaxis = list(title = "Average GPA")) %>% 
      
      #Puts labels on the X Axis for each Quarter
      add_annotations(x = c(5,15,25,35),
                      y = c(1.7,1.7,1.7,1.7),
                      text = c("Autumn","Winter","Spring","Summer"),
                      xref = "x",
                      yref = "y",
                      showarrow = FALSE)}
  
  
  output$plot <- renderPlotly({
    
    if (input$class == "All"){
      
      df.choose <- df %>%
        filter(df$Year == input$year)
      
      return(BuildPlot(df.choose))
    }
    
    else{
    df.choose <- df %>%
      filter(df$Year == input$year & df$Class == input$class)
     
    return(BuildPlot(df.choose))}
    
  })
  
})

