# STOR 390, spring 2017
# Lecture 2 example code


# basic objects in R
number <- 4
db <- 3.776677

string <- 'I am a string'

boolean <- TRUE
b <- F

boolean | b
boolean & b


nums <- 1:5

vec <- c('one', 'two', 'three')


# instally tidyverse if it is not already on your computer
# install.packages('tidyverse')

# load a package
library(tidyverse)

# where is the current working directory?
getwd()

# what files are in the current working directory
list.files(getwd())


setwd('/Users/iaincarmichael/Dropbox/stor390/example_code/movies')

# note the movies data come from: http://www2.stat.duke.edu/~mc301/data/movies.html
# if movies.csv were in the same directory as the R script
# i.e. the current working directory I can import the data like this
movies <- read_csv('movies.csv')


# some summaries of the data
str(movies)
head(movies)
mean(movies$imdb_num_votes)


# ggplot2
# the + should freak you out a little if you have used R before...
ggplot(data = movies) + geom_point(mapping = aes(x = imdb_rating, y = critics_score))

# you can put code after the + on the next line
ggplot(data=movies, aes(x=audience_score)) +
    geom_histogram()

# aesthetic mappings
ggplot(data = movies) +
    geom_point(mapping = aes(x = imdb_rating, y = critics_score, color=mpaa_rating))


ggplot(data = movies) + 
    geom_point(mapping = aes(x = imdb_rating, y = critics_score, size = imdb_num_votes))

# facetting
ggplot(data = movies) + 
    geom_point(mapping = aes(x = imdb_rating, y = critics_score)) + 
    facet_wrap(~ mpaa_rating, nrow = 2)


# over plotting
ggplot(data = movies) + 
    geom_point(mapping = aes(x = imdb_rating, y = critics_score)) + 
    facet_wrap(genre ~ mpaa_rating)

#
ggplot(data = movies) + 
    geom_bar(mapping = aes(x = mpaa_rating))

