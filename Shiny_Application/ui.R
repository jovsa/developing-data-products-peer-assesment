library(shiny)

# Define UI for application that predicts flora species
shinyUI(fluidPage(
     
     # Application title
     titlePanel("Flora Species Predictor"),
     

     sidebarLayout(
          sidebarPanel(
               helpText("This application helps you identify the specices of a flower based on certain characteristics."),
               helpText("You enter the specifications of your specimen below, and the metrics will be compared to the Iris data base to predice the species of your specimen. The table on the right will show you which species your specimen resembeles along with probabilites for each class. The graph on the right will show how your specimen compares to the reference Iris in the database. The tree diagram provides insight on the classification model used to predict the specimen described by the input parameters.  "),
               helpText("Your specimen is marked with an X."),
               helpText("Please choose your selections below."),
               sliderInput("sepalLength", "Your sepal length [cm]:", round=FALSE, step=0.01,
                           min = 4.0,  # 4.3
                           max = 8.0,  # 7.9
                           value = 6),
               sliderInput("sepalWidth", "Your sepal width [cm]:", round=FALSE, step=0.01,
                           min = 1.0,  # 2.0
                           max = 5.0,  # 4.4
                           value = 3),
               sliderInput("petalLength", "Your petal length [cm]:", round=FALSE, step=0.01,
                           min = 0.0,  # 1.0
                           max = 7.0,  # 6.9
                           value = 3.5),
               sliderInput("petalWidth", "Your petal width [cm]:", round=FALSE, step=0.01,
                           min = 0.0,  # 0.1
                           max = 3.0,  # 2.5
                           value = 1.5),
               imageOutput("imagePetalSepal")
          ),
                         
          # Show a plot of the generated distribution
          mainPanel(
               "Results:",
               htmlOutput("results"),
               "Length vs Width of Flora:",
               plotOutput("chartsPlots"),
               "Classification Tree Logic:",
               plotOutput("rpartPlot")

               
          )
     )
))
