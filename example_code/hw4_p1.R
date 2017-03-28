library(tidyverse)

library(class) # KNN
library(e1071) # SVM
library(kernlab) # kernel SVM
library(caret) # tuning

library(stringr)

train <- read_csv('https://raw.githubusercontent.com/idc9/stor390/master/data/human_activity_train.csv')

test <- read_csv('https://raw.githubusercontent.com/idc9/stor390/master/data/human_activity_test.csv')

# only consider walking upstairs vs downstairs
train <- train %>% 
    filter(activity == 2 | activity == 3)

test <- test %>% 
    filter(activity == 2 | activity == 3)

# subsample training data
N_tr <- dim(train)[1] # total number of training examples
set.seed(8599)
train <- train[sample(x=1:N_tr, size=500), ]


# break the data up into separate x and y data
train_x <- train %>% select(-activity)
train_y <- train$activity

test_x <- test %>% select(-activity)
test_y <- test$activity

# k values to check for KNN
k_values <- seq(from=1, to= 41, by=2)



# test set error ----------------------------------------------------------


error_df <- tibble(k=k_values, tst_error = rep(0, length(k_values)))



for(i in 1:length(k_values)){
    
    k <- k_values[i]
    
    
    test_predictions <- knn(train=train_x, # training x
                            test=test_x, # test x
                            cl=train_y, # train y
                            k=k) # 
    

    error_df[i, 'test'] <- mean(test_predictions != test_y)
    
}




# cross validation --------------------------------------------------------

# this code is basically copied and pasted from the lecture

# number of cross-validation folds
M <- 10


# helpful quantities
num_k <- length(k_values)
n <- dim(train)[1]

# create data frame to store CV errors
cv_error_df <- matrix(0, nrow=num_k, ncol=M) %>% 
    as_tibble() %>% 
    add_column(k=k_values)
colnames(cv_error_df) <- str_replace(colnames(cv_error_df), 'V', 'fold')

# seed for CV subsampling
set.seed(345)

# for each of the M folds
for(m in 1:M){
    
    # number of points that go in the cv train set
    n_cv_tr <- floor(n * (M-1)/M)
    
    # randomly select n_tr numbers, without replacement, from 1...n
    cv_tr_indices <- sample(x=1:n, size=n_cv_tr, replace=FALSE)
    
    # break the data into a non-overlapping train and test set
    cv_tr_data <- train[cv_tr_indices, ]
    cv_tst_data <- train[-cv_tr_indices, ]
    
    
    # break the train/test data into x matrix and y vectors
    # this formatting is useful for the knn() functions
    cv_tr_x <- cv_tr_data %>% select(-activity)
    cv_tr_y <- cv_tr_data$activity
    
    cv_tst_x <- cv_tst_data %>% select(-activity)
    cv_tst_y <- cv_tst_data$activity # turn into a vector
    
    # for each value of k
    for(i in 1:num_k){
        
        # fix k for this loop iteration
        k <- k_values[i]
        
        # get predictions on cv test data data
        cv_tst_predictions <- knn(train=cv_tr_x, # training x
                                  test=cv_tst_x, # test x
                                  cl=cv_tr_y, # train y
                                  k=k) # set k
        
        # compute error rate on cv-test data
        cv_tst_err <- mean(cv_tst_y != cv_tst_predictions)
        
        # store values in the data frame
        cv_error_df[i, paste0('fold',m)] <- cv_tst_err
    }
}


# compute the mean cv error for each value of k
cv_mean_error <- cv_error_df %>% 
    select(-k) %>% 
    rowMeans()





# plot error --------------------------------------------------------------


error_df <- error_df %>%
    add_column(cv = cv_mean_error)

# reshape the error data frame then plot it
error_df %>% 
    gather(key=type, value=error, test, cv) %>% 
    ggplot() +
    geom_point(aes(x=k, y=error, color=type, shape=type)) +
    geom_line(aes(x=k, y=error, color=type))


# find the minimum cv an test error
error_df %>% filter(test==min(test))
error_df %>% filter(cv==min(cv))






