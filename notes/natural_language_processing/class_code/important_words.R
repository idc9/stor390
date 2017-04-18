# this script looks at the raw word counts and tf-idf scores for a collection of documents

library(tidyverse)
library(stringr)
library(tidytext)

library(SnowballC)

source('read_text.R')


# read in raw data
books <- read_author('rowling')
# books <- read_author('orwell_essays')
# books <- read_author('orwell_novels')
# books <- read_author('tolkien')


# tokenize, count words and compute tf-idf scores
book_words <- books %>% 
    unnest_tokens(word, text) %>% 
    count(book, word, sort = TRUE) %>%
    ungroup() %>% 
    rename(count=n)%>% 
    bind_tf_idf(word, book, count)


# range of words to display
display_range <- 1:15

# plot raw word counts
book_words %>% 
    group_by(book) %>% 
    arrange(desc(count)) %>% 
    slice(display_range) %>% 
    ungroup %>%
    ggplot(aes(word, count, fill = book)) +
    geom_col(show.legend = FALSE) +
    labs(x = NULL, y = "word count") +
    facet_wrap(~book, ncol = 4, scales = "free") +
    coord_flip()

# plot tf-idf scores
book_words %>% 
    group_by(book) %>% 
    arrange(desc(tf_idf)) %>% 
    slice(display_range) %>% 
    ungroup %>%
    ggplot(aes(word, tf_idf, fill = book)) +
    geom_col(show.legend = FALSE) +
    labs(x = NULL, y = "tf-idf") +
    facet_wrap(~book, ncol = 4, scales = "free") +
    coord_flip()
