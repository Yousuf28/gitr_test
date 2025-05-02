#!/usr/bin/env Rscript

# This code is for creating
# -----------------------------------------------------------------------------
# Date                     Programmer
#----------   --------------------------------------------------------------
# May-02-2025    Md Yousuf Ali (MdYousuf.Ali@fda.hhs.gov)
# fs::file_copy('.gitconfig', '/home/.gitconfig',overwrite = T)
mm <- Sys.getenv('GIT_SSH')
fs::dir_create('.ssh', recurse = T)
write(mm, '.ssh/id_gitr')

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
      shiny::actionButton('git_push', 'submit')
    ),

    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output,session) {
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })

  shiny::observeEvent(input$git_push,{
    req(input$git_push)
    df <- mtcars
    write.csv(df, 'mtcars.csv')
    gitr::gaa()
    gitr::gcmsg('test')
    ## gitr::gp()
    gitr::gp()
  })


}
shinyApp(ui = ui, server = server)
