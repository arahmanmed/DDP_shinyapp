# Developing Data Products
# Course Project - Shiny Web App

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel(h2("PPV & FNP of Rose Bengal Test: Probability of bovine brucellosis [a bacterial disease] if tested positive & negative, respectively")),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        numericInput("Prevalence", "Prevalence (%): Proportion of cattle
                in the population with the disease", 
                     min = 0, 
                     max = 100,
                     value = 0.6),
        
      
        sliderInput("SE","Sensitivity (%): Test's ability to detect diseased cattle:",
                     min = 0,
                     max = 100,
                     value = 87.4),
        

        sliderInput("SP","Specificity (%): Test's ability to detect healthy cattle",
                     min = 0,
                     max = 100,
                     value = 99.4),
       
        h5("For example:"),
        h5("The prevalence of bovine brucellosis in subsistence management system is 0.6% with 87.4 sensitivity and 99.4% specificity"),
        a(href = "https://doi.org/10.1017/S0950268818003503", "Reference")
      ),
      
      # Plotting the predicted PPV, FNP based on Se, SP, and Prevalence
      mainPanel(
        strong(h4("Contingency table of test results and disease status per 100,000 cattle")), 
        tableOutput("TestStatus"),
        h5("Positive Predictive Value (PPV): Probability of brucellosis if tested positive"),
        h5("False Negative Probability (FNP) - Probability of brucellosis if tested negative"),
        
        plotOutput("Prediction")
      )
   )
)
