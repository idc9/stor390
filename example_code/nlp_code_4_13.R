library(tidytext)
library(janeaustenr)
library(dplyr)
library(stringr)
library(tidyverse)

# put jane austen books into tidy format
tidy_books <- austen_books() %>%
    group_by(book) %>%
    mutate(linenumber = row_number(),
           chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                   ignore_case = TRUE)))) %>%
    ungroup() %>%
    unnest_tokens(word, text)

# print out books
tidy_books %>% arrange(book, linenumber)

# print most occuring words
tidy_books %>% count(word, sort=T)

# kill stop words
tidy_books <- tidy_books %>%
    anti_join(stop_words)

# print most occuring words
tidy_books %>% count(word, sort=T)


# sentiment analysis with an inner join
janeaustensentiment <- tidy_books %>%
    inner_join(get_sentiments("bing")) %>% 
    inner_join(get_sentiments("afinn")) 


# print out results
janeaustensentiment %>% arrange(book, linenumber)
               
# relative frequencies
janeaustensentiment %>% ggplot() + geom_bar(aes(sentiment)) + facet_wrap (~book)

# sentiment analysis
janeaustensentiment <- tidy_books %>%
    inner_join(get_sentiments("bing")) %>%
    count(book, index = linenumber %/% 80, sentiment) %>%
    spread(sentiment, n, fill = 0) %>%
    mutate(sentiment = positive - negative)


# plot trajectories
ggplot(janeaustensentiment, aes(index, sentiment, fill = book)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~book, ncol = 2, scales = "free_x") + 
    ggtitle('sentiment trajectory')




# fourier ------------------------------------------------------------------



library(syuzhet) 


sense <- janeaustensentiment %>% filter(book == 'Sense & Sensibility')

# number of fourier componenets to retain
n_fourier_comp = 3

# low pass filter with fourier trans to get plot shape
sentiments_ft <- get_transformed_values(sense$sentiment, 
                                        low_pass_size = n_fourier_comp,
                                        scale_vals = TRUE,
                                        scale_range = FALSE) %>%
    as.numeric() %>%
    tibble(index = seq_along(.), ft=.)


# line plot
ggplot(data = sentiments_ft) +
    geom_line(aes(x = index, y = ft), color = "midnightblue") +
    labs(title=str_c("sentiment arc for Sense and Sensibility with ", n_fourier_comp, ' fourier components' ),
         y='Transformed Sentiment Value') + 
    geom_hline(aes(yintercept=0), color='black', alpha=.2) +
    theme_minimal() 









