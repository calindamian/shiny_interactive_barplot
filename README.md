# Shiny interactive barplot
Shiny module implementing interactive barplot selector 

![image](https://user-images.githubusercontent.com/61669129/77831104-5adb2600-712d-11ea-8504-9cebe4b91b4a.png)

# Demo
A demo could be seen in action https://calindamian.shinyapps.io/interactive_barplot_ui/

Data from gapeminder was used.

# Usage
The code for the demo : ***interactive_barplot_ui_demo.R*** 

The code for the module : ***interactive_barplot.R*** 

callModule(interactive_barplot , "test" 
                          ,tb =reactive (tb_result) 
                          ,axe_category= reactive ("country")
                          ,axe_numeric =  reactive("pop"))
                          
