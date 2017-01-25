library(ggplot2)
library(plotly)
shinyUI(bootstrapPage(
  fluidPage(
    titlePanel("Dane dot. czynników potencjalnie wpływających na długość śledzia oceanicznego"),
    fluidRow(
      DT::dataTableOutput("sampleData")
    ),
    titlePanel("Wykres trendu wzrostu temperatury przy powierzchni wody oraz trendu spadku długości śledzia oceanicznego"),
    fluidRow(
      plotOutput("plotOfSST")
    )
  )
))