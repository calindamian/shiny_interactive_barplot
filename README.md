# Shiny interactive barplot
Shiny module implementing interactive barplot selector 

## Demo
A demo using data from gapeminder could be seen in action https://calindamian.shinyapps.io/interactive_barplot_ui/
![image](https://user-images.githubusercontent.com/61669129/77831104-5adb2600-712d-11ea-8504-9cebe4b91b4a.png)

## Usage
Files 
  -  ***interactive_barplot_ui_demo.R*** : contains the demo showing how to use the module.
  -  ***interactive_barplot.R*** : contains code for the module

The main server function takes 3 parameters :
  - tb  : tibble or dataframe containing attributes to be displayed
  - axis_category : attribute used for category axis
  - axis_numeric  : attribute used for numeric axis. The categories are ordered based on values of this attribute

```
    selected = callModule(interactive_barplot , "test" 
                          ,tb =reactive (tb_result) 
                          ,axis_category= reactive ("country")
                          ,axis_numeric =  reactive("pop"))
```
The function is returning selected category value (that can be used later in the app )
On double click selected value is set to "*" 
