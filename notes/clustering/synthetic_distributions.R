
# samples points from two classes of a two dimensional guassian distribution
# returns a data frame with columns: x1, x2, y
# n_pos, n_neg: number of points in each class
# mu_pos, mu_neg: class means (vector length two)
# sigma_pos, sigma_neg: number of points in each class (2x2 matrix)
two_class_guasssian_meatballs <- function(n_pos, n_neg, mu_pos, mu_neg, sigma_pos, sigma_neg, seed=NA){
    
    if(!is.na(seed)){
        set.seed(seed)
    }
    
    # generate data from negative class
    class_neg <- rmvnorm(n=n_neg, mean=mu_neg, sigma=sigma_neg) %>% # mvrnorm comes from MASS
        as_tibble() %>%
        mutate(y=-1) %>%
        rename(x1=V1, x2=V2)
    
    # generate data from positive class
    class_pos <- rmvnorm(n=n_pos, mean=mu_pos, sigma=sigma_pos) %>% 
        as_tibble() %>%
        mutate(y=1) %>%
        rename(x1=V1, x2=V2)
    
    # put data into one data frame
    data <- rbind(class_pos, class_neg)%>% 
        mutate(y =factor(y)) # class label should be a factor
    
    data
}


# samples points from a Boston cream doughnut distribution
boston_cream_doughnut <- function(n_pos, n_neg){
    
    # direction picked uniformly at random
    # length for the negative class between 0 and 1
    # length for the positive class between 1 and 2
    
    # generate a direction in the plane at random
    # draw a 2 dimensional standard normal and normalize each point by it's length
    direction <- rmvnorm(n=n_pos + n_neg, mean=c(0,0), sigma=diag(2)) %>%
        apply(1, function(r) r/(sqrt(sum(r^2)))) %>%
        t()
    
    # draw lengths randomly from designated intervals
    length_neg <- runif(n=n_neg, min=0, max=1)
    length_pos <- runif(n=n_pos, min=1, max=2)
    
    # multiply direction by length
    boston_cream <- direction * c(length_neg, length_pos)
    
    
    colnames(boston_cream) <- c('x1', 'x2')
    boston_cream <- boston_cream %>%
        as_tibble() %>%
        mutate(y= c(rep(-1,n_neg), rep(1, n_pos))) %>%
        mutate(y =factor(y))
    
    
    boston_cream
}

# Gaussia mixture model
gmm_distribution2d <- function(n_neg, n_pos, mean_seed=NA, data_seed=NA){
    # 2 class gaussian mixture model distribution from ISLR/ESL

    
    # grand class means
    grand_mu_pos <- c(1, 0)
    grand_mu_neg <- c(0, 1)
    
    
    # if mean_seed is provided sample the means from the mean seed
    if(!is.na(mean_seed)){
        set.seed(mean_seed)
        
        # sample class means
        mu_pos <- rmvnorm(n=10, mean=grand_mu_pos, sigma=diag(2))
        mu_neg <- rmvnorm(n=10, mean=grand_mu_neg, sigma=diag(2))
        
        # if the data seed is not set then remove the seed
        if(is.na(data_seed)){
            rm(.Random.seed, envir=globalenv())
        }
    } else{
        # sample class means
        mu_pos <- rmvnorm(n=10, mean=grand_mu_pos, sigma=diag(2))
        mu_neg <- rmvnorm(n=10, mean=grand_mu_neg, sigma=diag(2))
    }
    
    # if the data seed is provided the set it
    if(!is.na(data_seed)){
        set.seed(data_seed)
    }
    
    
    # pick which means to sample from
    m_index_pos <- sample.int(10, n_pos, replace = TRUE)
    m_index_neg <- sample.int(10, n_neg, replace = TRUE)
    
    # sample data from each class
    X_pos <- map(1:n_pos,function(i) rmvnorm(n=1, mean=mu_pos[m_index_pos[i], ], sigma=diag(2)/5)) %>% 
        unlist %>% 
        matrix(ncol=n_pos) %>% 
        t %>%
        as_tibble() %>%
        mutate(y=1) 
    
    
    X_neg <- map(1:n_neg,function(i) rmvnorm(n=1, mean=mu_neg[m_index_neg[i], ], sigma=diag(2)/5)) %>% 
        unlist %>% 
        matrix(ncol=n_neg) %>% 
        t %>%
        as_tibble() %>%
        mutate(y=-1) 
    
    # set column names
    colnames(X_pos) <- gsub("V", 'x', colnames(X_pos))
    colnames(X_neg) <- gsub("V", 'x', colnames(X_neg))
    
    # put data into one data frame
    data <- rbind(X_pos, X_neg)%>% 
        mutate(y =factor(y)) # class label should be a factor
    
    data
    
}
