# this library implements SVM
library(e1071)

library(mvtnorm)
library(tidyverse)

# some helper functions I wrote
source('synthetic_distributions.R')
source('svm_fun.R')


# some training data
train <- gmm_distribution2d(n_neg=200, n_pos=201, mean_seed=238, data_seed=1232)

# test grid
test_grid <- expand.grid(x1 = seq(-5, 5, length = 100),
                         x2 = seq(-5, 5, length = 100)) %>% 
    as_tibble()



library(caret)


train_x <- train %>% select(-y)
train_y <- train$y

# specify tuning procedure
trControl <- trainControl(method = "cv", # perform cross validation
                          number = 5) # use 5 folds

# the values of C, SVM's tuning parameter, to look over in cross validation
tune_grid <- tibble(cost=c(.01, .1, 1, 10, 100))


# fit the SVM model
svmFit <- train(x=train_x, # x data
                y=train_y, # y data
                method = "svmLinear2", # use linear SVM from the e1071 package
                preProc = c("center","scale"), # preporocessing
                tuneGrid = tune_grid,
                trControl = trControl) # how to select the tuning parameter



predict(svmFit, newdata = train_x)