# example code for dplyr lecture 2
# stor 390 1/24/17


library(tidyverse)

# Load the bison data
bison <- read_csv(url("https://raw.githubusercontent.com/idc9/stor390/master/data/bison_orangecounty.csv"))

# Question 1
# What is the ITISscientificName of the 382nd row?
slice(bison, 382) %>%
    select(ITISscientificName)

# or
bison[382,'ITISscientificName' ]


# Question 2
# What is the decimalLongitude of the most recent Dumetella carolinensis sighting?

bison %>%
    select(ITISscientificName, decimalLatitude, decimalLongitude, eventDate) %>%
    mutate(latitude_rad = pi * decimalLatitude / 180, 
           longitude_rad = pi * decimalLongitude / 180, 
           eventDate = parse_datetime(eventDate)) %>%
    filter(ITISscientificName == "Dumetella carolinensis") %>%
    arrange(desc(eventDate)) %>%
    select(eventDate, decimalLongitude)

# Question 3
# Which species has been observed the most by one collector?
group_by(bison, ITISscientificName, collectorNumber) %>%
    filter(collectorNumber != "", ITISscientificName!="") %>%
    summarise(num=n()) %>%
    arrange(desc(num))

