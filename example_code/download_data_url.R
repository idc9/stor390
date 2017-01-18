library(tidyverse)

# instead of doing the jenky copy and paste method I showed you in class...
# find the url for the data on github
github_data_url <- 'https://raw.githubusercontent.com/idc9/stor390/master/data/movies.csv'

data <- read_csv(url(github_data_url))

# when you analyze data you should (usually) save the raw file on your computer
write_csv(data, 'movies.csv') # saves to the current working directory
