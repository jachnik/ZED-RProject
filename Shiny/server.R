library(ggplot2)
library(plotly)
library(caret)
library(clusterSim)

shinyServer(function(input, output) {
  
  loadDataFromFile <- reactive({
    tbl <- read.csv("/Users/jachnika/Desktop/Raport/data.csv")
    dataFrame <- as.data.frame(tbl)
    dataFrame
  })
  
  cleanData <- reactive({
    df <- loadDataFromFile()
    for (i in names(df)) {
      df[[i]] <- as.numeric(as.character(df[[i]]))
    }
    df$year <- floor(as.numeric(as.character(df$X)) / 880) + 1
    idx <- df == '?'
    is.na(df) <- idx
    idxs <- createDataPartition(df$year, p = 0.9, list = FALSE)
    df <- df[complete.cases(df[colnames(df)]), colnames(df)]
    df <- df[-idxs,]
    df
  })
  
  plotData <- reactive({
    df <- cleanData()
    df$sst <- data.Normalization(df$sst, type = "n12")
    df$length <- data.Normalization(df$length, type = "n12")
    df
  })
  
  output$sampleData <- DT::renderDataTable(DT::datatable({
    d <- loadDataFromFile()
    d
  }))
  
  output$plotOfSST <- renderPlot({
    p <- ggplot(data = plotData()) +
         stat_smooth(aes(x = X, y = length), method = "loess", colour = "green") + 
         stat_smooth(aes(x = X, y = sst), method = "loess", colour = "red") 
    p
  })
})