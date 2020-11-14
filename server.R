

library(shiny)

# Define server logic required to draw a histogram
# Define server logic 
server <- function(input, output) {

output$TestStatus <- renderTable({
# Cattle population size
n<- 100000
#Total number of diseased cattle
TD <- input$Prevalence/100*n
#Number of true positive cattle
TP<-floor(TD*input$SE/100)
#Number of false negative cattle
FN<- TD-TP
#Number of total healthy cattle
TH <- 100000 -TD
#Number of true negative cattle
TN<- floor(TH*input$SP/100)

#Number of false positive cattle 
FP<- TH - TN
#Positive predictive value: probability of diseased if tested positive
PPV<- TP / (TP + FP)
#False negative proportion: probability of diseased if tested negative
FNP<- FN / (FN + TN)
    
datf <- data.frame(Outcome = c("Test Postive", "Test Negative", "Total"),
Disease = c(TP, FN, TD), 
Healthy = c(FP, TN, TH),
Total = c(TP+FP, TN+FN, TD + TH))
format(datf)
})
  
output$Prediction <- renderPlot({
    n <- 100000
    TD <- input$Prevalence/100 * n
    TP <- floor(TD * input$SE/100)
    FN<- TD - TP
    TH <- 100000 - TD
    TN     <- floor(TH * input$SP/100)
    FP <- TH - TN
   
datf <- data.frame(Outcome = c("Test Postive", "Test Negative", "Total"),
Disease = c(TP, FN, TD), 
Healthy = c(FP, TN, TH),
Total = c(TP+FP, TN+FN, TD + TH)) 
    
datf1 <- data.frame(Outcome = c("PPV", "FNP", "Prevalence"),
metric = round(100 * datf$Disease/datf$Total,2))
    
ggplot(datf1, aes(x = Outcome, y = metric)) + geom_bar(stat = "identity", fill="blue")+
 geom_text(aes(label = metric), vjust=-0.3, size = 4) +
theme_minimal()+
theme_bw()
})
}

#
