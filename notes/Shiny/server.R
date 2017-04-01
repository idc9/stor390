## Coursera Data Products Class Project
## Burpee Calculator
## server.R

# Calculate calories per Burpee
cal <- function(Weight) {
    
    #convert to kg
    weight_kg <- (Weight/2.2046)
    #calculate calories per Burpee
    # Assumptions
    #     1) Each Burpee consumes 3.5 ml of O2 per kg of weight.
    #     2) 1L of oxygen consumed = 5 kcals
    cal <- weight_kg * 3.5/1000 * 5
    print(cal)
}
# Read in the beer calorie data
beerdata <- read.csv("beerdata.csv", stringsAsFactors=TRUE, header=TRUE)
beerdata$Calories <- as.numeric(beerdata$Calories)
beerdata$Beer <- as.character(beerdata$Beer)

Cal_Beer <- function(Beer, Quantity)
{
    name <- Beer
    Quantity
    beercal <- beerdata[beerdata$Beer==name, 2]
    totalcal <- beercal*Quantity
    return(totalcal)
}

burpees <- function(Weight, Beer, Quantity){
    #From the cal function
    weight_kg <- (Weight/2.2046)
    cal <- weight_kg * 3.5/1000 * 5
    #From the Cal_Beer function
    name <- Beer
    Quantity
    beercal <- beerdata[beerdata$Beer==name, 2]
    totalcal <- beercal*Quantity
    #Now the burpees
    num_burpees <- round(totalcal/cal)
    return(num_burpees)
}

shinyServer(
    function(input,output) {
        output$wt <- renderText(paste({input$Weight},"lbs"))
        output$cal <- renderText({cal(input$Weight)})
        output$Cal_Beer <- renderText({Cal_Beer(input$Beer, input$Quantity)})
        output$burpees <- renderText({burpees(input$Weight, input$Beer, input$Quantity)})
    }
)