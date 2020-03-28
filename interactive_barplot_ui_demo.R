#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library (lubridate)
library (DT)
library(gapminder)

#source module
source("interactive_barplot.R")

#global variables using gapminder
tb_result = gapminder%>% 
            arrange(desc (year)) %>%
            group_by( country ) %>%
            filter (row_number()==1) %>%
            arrange(desc(pop))%>%
            head(20)


# Define UI for application that draws a histogram

ui <- fluidPage(
   h2("Interactive bar plot module example"),
   
   sidebarLayout(
     sidebarPanel (width = 2 ,
                   tags$p (tags$strong("Filter by Country") , "(ordered by pop)" ) ,
                   tags$p ("Click for one selection / double click for * selection"),
                   interactive_barplot_ui ("test") 
                  )
     
     ,
     mainPanel( width = 9 ,
                verbatimTextOutput("debug") ,
                dataTableOutput("result")
                
              )
     
   )
   
)

server <- function(input, output , session) {
  
    selected = callModule(interactive_barplot , "test" 
                          ,tb =reactive (tb_result) 
                          ,axe_category= reactive ("country")
                          ,axe_numeric =  reactive("pop"))
    
    output$debug = renderText( str_c( "Selected Countries: " , selected ()))
    
    output$result = renderDataTable( {
                      
                      tb_result   %>% 
                      filter ( country %in% selected () | selected () == "*" )
                  }
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)


