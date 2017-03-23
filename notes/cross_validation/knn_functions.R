

get_knn_test_grid <- function(train_data, k){
    # get KNN predictions for a test grid
    
    xlim <- c(1.2*min(train_data$x1), 1.2*max(train_data$x1))
    ylim <- c(1.2*min(train_data$x2), 1.2*max(train_data$x2))
    
    # make a test grid
    test_grid <- expand.grid(x1 = seq(xlim[1], xlim[2], length = 100),
                             x2 = seq(ylim[1], ylim[2], length = 100)) %>% 
        as_tibble()
    
    # we have to split the training data into an x matrix an y vector to use the knn function
    train_data_x <- train_data %>% select(-y)
    train_data_y <- train_data$y # turn into a vecotr
    
    # compute KNN predictions
    # the knn function is from the class package
    knn_grid_prediction <- knn(train=train_data_x, # training x
                               test=test_grid, # test x
                               cl=train_data_y, # train y
                               k=k) # set k
    
    # add predicionts to test data frame
    test_grid_pred <- test_grid %>% 
        add_column(y_pred = knn_grid_prediction)
    
    
    test_grid_pred
}



get_knn_error_rates <- function(train_data, test_data, k){
    # computes KNN test/train error rates
    
    # break the train/test data into x matrix and y vectors
    # this formatting is useful for the knn() functions
    train_data_x <- train_data %>% select(-y)
    train_data_y <- train_data$y # turn into a vector
    
    
    test_data_x <- test_data %>% select(-y)
    test_data_y <- test_data$y # turn into a vector
    
    # get predictions on training data
    knn_train_prediction <- knn(train=train_data_x, # training x
                                test=train_data_x, # test x
                                cl=train_data_y, # train y
                                k=k) # set k
    
    # get predictions on test data
    knn_test_prediction <- knn(train=train_data_x, # training x
                               test=test_data_x, # test x
                               cl=train_data_y, # train y
                               k=k) # set k
    
    # training error rate
    tr_err <- mean(train_data_y != knn_train_prediction)
    # training error rate
    tst_err <- mean(test_data_y != knn_test_prediction)
    
    list(tr=tr_err, tst=tst_err)
}
