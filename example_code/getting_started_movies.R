# STOR 390, spring 2017
# Lecture 1 example code

# load a package
library(tidyverse)

# read a csv file
# NOTE: this is the 'absolute path' to the file that is on my computer
movies <- read_csv('/Users/iaincarmichael/Dropbox/stor390/data/movies.csv')

# if movies.csv were in the same directory as the R script
# i.e. the current working directory I could import the data like
# movies <- read_csv('movies.csv')

# You can also download movies.csv from the internet
# load(url('https://stat.duke.edu/~mc301/data/movies.Rdata'))


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

