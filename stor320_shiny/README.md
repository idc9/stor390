# STOR 320 Shiny lecture on Monday October 23, 2018

## Rough timeline

1. Introduce myself
* Give contact info
* Talk about what I do at my job
* Give example of app developed and used at work
2. Go over lecture notes up to the renderUI section
3. Class will do the beer2burpees example
4. Continue lecture if time is still available

## Lecture notes

For now, in order to view the lecture, you will have to open the document `shiny.Rmd` in RStudio and click on the `Run Document` button.  

Previously, removing the code line 7 `runtime: shiny` would result in a knitted html document for viewing without running the Shiny elements; however, running it in the current environment results in the following error - "appshot of Shiny app objects is not yet supported".  Still have to see if there is a workable solution.

## Class example

The class example will involve the beer2burpees app that my colleague developed when she took the Coursera series on data science.  
I will show them what the app looks like by running the app in the folder `beer2burpees_answer`.
The students will figure out and include the one missing line of code by running `beer2burpees_example`.  This is to illustrate how variables get mapped between the user interface and the server and the use of `renderUI()`.
