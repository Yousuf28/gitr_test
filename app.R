#!/usr/bin/env Rscript

# This code is for creating
# -----------------------------------------------------------------------------
# Date                     Programmer
#----------   --------------------------------------------------------------
# May-02-2025    Md Yousuf Ali (MdYousuf.Ali@fda.hhs.gov)


library(shiny)
ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      shiny::actionButton('git_ush', 'submit')
    ),

    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })

  shiny::observe(input$submit,{
    df <- mtcars
    write.csv(df, 'mtcars.csv')
    gitr::gaa()
    gitr::gcmsg('test')
    ## gitr::gp()
    gitr::gp()



  })


}
shinyApp(ui = ui, server = server)
