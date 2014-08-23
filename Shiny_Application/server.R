library(shiny)
library(lattice)
library(devtools)
library(ggplot2)
library(grid)
library(gridExtra)
library(caret)
library(ggthemes)
library(rattle)
library(xtable)
data(iris)

modFit <- train(Species ~ ., method="rpart", data=iris)
irisP <- data.frame(Sepal.Length=numeric(1), Sepal.Width=numeric(1), Petal.Length=numeric(1), Petal.Width=numeric(1), Species=character(1), stringsAsFactors=TRUE)

shinyServer(function(input, output) {
    
     output$chartsPlots <- renderPlot({
          irisP$Sepal.Length <- input$sepalLength
          irisP$Sepal.Width <- input$sepalWidth
          irisP$Petal.Length <- input$petalLength
          irisP$Petal.Width <- input$petalWidth
          irisP$Species <- predict(modFit, irisP)
          Prob <- predict(modFit, irisP, type = "prob")
          
          results <- data.frame(irisP$Species, Prob[1], Prob[2], Prob[3])
          colnames(results) <- c("Predicted Species", "Prob. of Setosa", "Prob. of Versicolor ", "Prob. of Virginica")
          overallResults <- xtable(results)
          
          output$results <-  reactiveTable(function() {
               overallResults
          })
          
          
          
          
          
          g1 <- ggplot()
#           g1 <- g1 + theme_solarized()
          g1 <- g1 + geom_point(data = iris, aes(x= Sepal.Width+Petal.Width, y = Sepal.Length+Petal.Length, col=Species))
          g1 <- g1 + geom_point(aes(x=Sepal.Width+Petal.Width, y=Sepal.Length+Petal.Length, col=Species), size=5, shape=4, data=irisP)
          print(g1)
          
})  


     output$imagePetalSepal <-  renderImage({
          filename <- "./images/PetalSepal2.jpg"
          list(src = filename)
     }, deleteFile = FALSE)

     
     output$rpartPlot <-  renderPlot({
          fancyRpartPlot(modFit$finalModel)
     })
})