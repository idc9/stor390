# this script contains a minimal example of the k-means algorithm for STOR 390
library(flexclust) # for computing euclidean distances
library(tidyverse)

k_means <- function(X, K, max_iter = 10, init_seed=NA){
    # Runs the K-means algorithm
        # X: a data frame with all numeric values
        # K: the number of desired clusters
        # max_iter: max number of iteration
    
    

    # possibly set intial cluster assignment see
    if(!is.na(init_seed)){
        set.seed(init_seed)
    }
    
    # randomly initialize cluster assignments
    init_assignments <- sample(1:K, dim(X)[1], replace = T)
    
    # cluster assignment column
    X <- X %>% 
        add_column(cl=factor(init_assignments))

    cl_old <- init_assignments
    
    for(i in 1:max_iter) {

        # compute current cluster centroids
        centroids <- X %>%  
            group_by(cl) %>% 
            summarise_all(mean)
        
        
        # matrix keeping track of distance from each point to each centroid
        centroid_dists <- matrix(0, nrow=dim(X)[1], ncol=K)
        
        # find distance from each cluster centroid to all points
        for(k in 1:K){
            
            # grab kth centroid
            cent <- centroids %>% filter( cl == k) %>% select(-cl)
            
            # compute distance from each point to k-th centroid
            centroid_dists[,k] <- X %>% select(-cl) %>% dist2(cent)
        }
        
        # assign points to nearest centroid
        cl_new <- apply(centroid_dists, 1, which.min) %>% factor
        
        # stop if cluster assignments don't change
        if(sum(cl_new != cl_old) == 0){
            break
        }
        
        # update cluster assignments
        cl_old <- cl_new
        X$cl <- cl_new
    }
    
    return(X)
}
