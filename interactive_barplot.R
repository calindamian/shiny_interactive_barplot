#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



#Define module

#Define module UI
interactive_barplot_ui = function(id) {
    
    ns <- NS(id)
    fluidRow(
            plotOutput(ns("ggplot") , click = ns("plot_click") ,  dblclick = ns("plot_dblclick")) 
    )
}

#Define module server function
interactive_barplot = function(input, output, session , tb , axis_category , axis_numeric) {
    

    global = reactiveValues(selected_country = "*" )
    
    
    observeEvent(eventExpr = input$plot_click, {
        global$selected_country =  tb ()  %>% 
            ungroup()%>% 
            arrange(.data[[axis_numeric()]])%>%
            filter (row_number() == round (input$plot_click$y) ) %>% 
            select (.data[[axis_category()]])%>%
            pull()
    })
    
    
    observeEvent(eventExpr = input$plot_dblclick, {
        global$selected_country =  "*"
    })
    
    output$ggplot <- renderPlot(
            tb () %>% 
            mutate(selected = ifelse(.data[[axis_category ()]] %in% global$selected_country | global$selected_country == "*", "yes" , "no" ) )%>%
              ggplot(aes ( reorder (.data[[axis_category ()]]  , .data[[axis_numeric ()]]) ,  .data[[axis_numeric()]] , fill=selected)) +
              geom_bar(stat = "Identity") +
              scale_y_continuous(breaks  = NULL) +
              labs (x=NULL , y=NULL) +
              coord_flip()+
              scale_fill_manual(values = c("yes" = "#3e3f3a", "no" = "grey" ), guide = FALSE )+
              theme_minimal() +
              theme(panel.grid.major = element_blank() ,
                    panel.grid.minor = element_blank()) 
            
        
        
    )
    #return from server module function has to be reactive
    return ( reactive (global$selected_country) )
    
}
