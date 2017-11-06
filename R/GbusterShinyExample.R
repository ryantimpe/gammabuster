####
# Gammabuster Shiny Example
####

library(shiny)
library(tidyverse)

devtools::install_github("johnsonbrent/gammabuster")
library(gammabuster)

ui <- fluidPage(
  titlePanel("Make Your Own Gammabuster"),

  sidebarLayout(
    sidebarPanel(
      radioButtons("gammaType", "What do you know?",
                   choices = c("The min and max" = "bounds", "The mean and range" = "mean"),
                   selected = "bounds"),
      hr(), #Line break
      #If you know the min/max...
      conditionalPanel(condition = "input.gammaType == 'bounds'",
                       numericInput("sel_bnds_min", "Minimum",
                                    value = 20, min = 0),
                       numericInput("sel_bnds_max", "Minimum",
                                    value = 40, min = 0),
                       sliderInput("sel_bnds_conf", "Confidence in those bounds",
                                   min = 0.5, max = 1.0, value = 0.95, step = 0.025)
                       ),
      #If you know the mean & range...
      conditionalPanel(condition = "input.gammaType == 'mean'",
                       numericInput("sel_mean_mean", "Expected Value",
                                    value = 20, min = 0),
                       numericInput("sel_mean_rng", "Expected Range containing Mean",
                                    value = 4, min = 0.1),
                       sliderInput("sel_mean_conf", "Confidence in those bounds",
                                   min = 0.5, max = 1.0, value = 0.975, step = 0.025)
      )
    ),
    mainPanel(
      verbatimTextOutput("print_results"),
      plotOutput("chart_results")
    )
  )
)

server <- function(input, output, session){

  runGamma <- reactive(
    if(input$gammaType == "mean"){
      return(GbusterMean(mean = input$sel_mean_mean,
                           range = input$sel_mean_rng,
                           pct = input$sel_mean_conf))
    } else {
      return(GbusterMinMax(lower = input$sel_bnds_min,
                           upper = input$sel_bnds_max,
                           pct = input$sel_bnds_conf))
    }
  )

  output$print_results <- renderPrint(
    runGamma()
  )

  output$chart_results <- renderPlot({
    if(input$gammaType == "mean"){
      x <- seq((input$sel_mean_mean - input$sel_mean_rng),
               (input$sel_mean_mean + input$sel_mean_rng),
               length = 100)
    } else {
      x <- seq((input$sel_bnds_min * 0.4),
               (input$sel_bnds_max * 1.6),
               length = 100)
    }

    hx <- dgamma(x,
                 shape = runGamma()[["par"]][1], rate = runGamma()[["par"]][2])


    plot(x,
         hx,
         type = "l",
         lty = 1,
         xlab = "Value of X",
         ylab = "Density",
         main = "Gamma distribution",
         col = "blue",
         lwd = 3
    )

  })

}

shinyApp(ui, server)
