# STOR 390, spring 2017
# Lecture 1 example code

# instally tidyverse if it is not already on your computer
install.packages('tidyverse')

# load a package
library(tidyverse)

# You can also download the movies data from the internet
load(url('https://stat.duke.edu/~mc301/data/movies.Rdata'))

# if movies.csv were in the same directory as the R script
# i.e. the current working directory I could import the data like
# movies <- read_csv('movies.csv')

# some summaries of the data
str(movies)
head(movies)
mean(movies$imdb_num_votes)

# base R plotting
plot(movies$imdb_rating, movies$critics_score)

# ggplot2
# the + should freak you out a little if you have used R before...
ggplot(data = movies) + geom_point(mapping = aes(x = imdb_rating, y = critics_score))

# you can put code after the + on the next line
ggplot(data=movies, aes(x=audience_score)) +
    geom_histogram()

# looks much better that way...
ggplot(data = movies) +
    geom_point(mapping = aes(x = imdb_rating, y = critics_score, color=mpaa_rating))

