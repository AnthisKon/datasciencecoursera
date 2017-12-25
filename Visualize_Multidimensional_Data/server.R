

library(shiny)

shinyServer(function(input, output) {
  pca <- prcomp(iris[,-5],
                center = TRUE,
                scale = TRUE)
  plotdata = pca$x
  output$documentation <- renderText({ "I used iris dataset to demonstrate a simple Principal Components Analysis and how we can see if the Components help us to separate the data.
- You can choose how many components you want to visulasize with the scatter plot.
- This plot may help you decide how many components you should use in further analysis
- How is this usefull? Dimension Reduction! Instead of the 4 variables of the iris dataset you can use just CP1 and CP2(or just CP1) to built a predictive model or visualize the data" })
  output$MyPlot <- renderPlot({

  pairs(plotdata[,1:input$PCS],col=iris$Species)
  })
})


