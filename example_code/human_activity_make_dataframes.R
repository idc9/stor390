setwd('/Users/iaincarmichael/Downloads/dataset_uci')
library(tidyverse)

library(class)

# read in data
X_train <- read_csv('final_X_train.txt', col_names = F)
Y_train <- read_csv('final_Y_train.txt', col_names = F)
X_test <- read_csv('final_X_test.txt', col_names = F)
Y_test <- read_csv('final_Y_test.txt', col_names = F)

# read in the feature names
feature_names <- read_delim('features.txt', delim=' ', col_names=F)
feature_names <- feature_names$X2

# make training data frame
train <- as_tibble(X_train)
colnames(train) <- feature_names
train['activity'] <- Y_train

# make test data frame
test <- as_tibble(X_test)
colnames(test) <- feature_names
test['activity'] <- Y_test

write_csv(train, 'human_activity_train.csv')
write_csv(test, 'human_activity_test.csv')



