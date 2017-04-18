
library(tidyverse)
library(stringr)
library(tidytext)

library(SnowballC)
library(klaR)

source('read_text.R')

# read in the corpus
books <- read_author('orwell_essays')

# break each book up into chuncks of of text
chunks <- books %>% 
    mutate(chunk = str_c(book,'_', linenumber %/% 10))


# tokenize by word
chunks <- chunks%>% 
    unnest_tokens(word, text) 


# stemming ----------------------------------------------------------------

# use the stemWords() function to stem each word in the chunks data frame




# document term matrices -------------------------------------------------------------


# count words and compute tf-idf scores
chunk_words <- chunks %>% 
    count(chunk, word, sort = TRUE) %>%
    ungroup() %>% 
    rename(count=n)%>% 
    bind_tf_idf(word, chunk, count)


# convert text into document term matrices
bag_of_words_dtm <- chunk_words %>% cast_dtm(chunk, word, count)
tfidf_dtm <- chunk_words %>% cast_dtm(chunk, word, tf_idf)


# convert to regular R matrices
X_bag_of_words <- as.matrix(bag_of_words_dtm)
X_tfidf <- as.matrix(tfidf_dtm)


# training classes (i.e. book titles)
# yes this is super hacky
row_names <- bag_of_words_dtm$dimnames$Docs
tr_classes <- str_sub(str_extract(row_names, '[a-z_]+'), start=1, end=-2)%>% factor


# fit classifiers ---------------------------------------------------------



# fit mean difference classifier
bow_classifier <- nm(x=X_bag_of_words, grouping=tr_classes)
tfidf_classifier <- nm(x=X_tfidf, grouping=tr_classes)

# get training predictions
bow_tr_pred <- predict(bow_classifier, newdata = X_bag_of_words)$class
tfidf_tr_pred <- predict(tfidf_classifier, newdata = X_tfidf)$class

# training error
paste0('bag of words based classifier training error: ', mean(tr_classes != bow_tr_pred))
paste0('tf-idf based classifier training error: ', mean(tr_classes != tfidf_tr_pred))
