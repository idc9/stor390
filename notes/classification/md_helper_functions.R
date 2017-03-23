# helper functions for the classificaiton lecture

fit_mean_difference <- function(train){
    # computes the mean difference normal vector and intercept (w, b)
    # train is a data frame with two labeled classes
    # class label column is called y and classes are labeled -1, 1
    
    
    # compute the means of each class
    train_means <- data_gauss %>% 
        group_by(y) %>% 
        summarise_all(mean)
    
    # extact the means
    mean_pos <- select(filter(train_means, y==1), -y)
    mean_neg <- select(filter(train_means, y==-1), -y)
    
    # reformat the means
    mean_pos <- mean_pos %>% as.matrix() %>% t()
    mean_neg <- mean_neg %>% as.matrix() %>% t()
    
    # compute the normal vector and intercept -- you can derive these equations by hand
    normal_vector <- mean_pos - mean_neg
    intercept  <- -(1/2)*( t(mean_pos) %*% mean_pos - t(mean_neg) %*% mean_neg )
    
    list(w=normal_vector,
         b=intercept)
    
}


# gets nearest centroid predictions
get_nearest_centroid_predictions <- function(train, test){
    # computes the mean difference predictions
    # train is a data frame with two labeled classes
    # class label column is called y and classes are labeled -1, 1
    # test is a data frame with same x variable names
    # returns a copy of test with the y predictions
    
    # make a copy of the test data frame to return
    test_pred <- test
    
    md_fit <- fit_mean_difference(train)
    w  <- md_fit[['w']]
    b  <- md_fit[['b']]
    
    # extract the X data from the test data frame
    # assume thet test columns have the same names as the train columns
    X_test <- as.matrix(test[, rownames(normal_vector)])
    
    # compute the mean difference predictions
    # the guts of the MD algorithm happens here
    predictions <- apply(X_test, 1, function(x) sign(x %*% w + b))
    
    # add the predicted y values to the test data frame
    test_pred <- test_pred %>% 
        add_column(y_pred =predictions) %>% 
        mutate(y_pred=factor(y_pred))
    
    test_pred
}
