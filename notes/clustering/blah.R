
library(mvtnorm)
library(tidyverse)

source('synthetic_distributions.R')


data <- two_class_guasssian_meatballs(n_pos=200, n_neg=200,
                                      mu_pos=c(4,0), mu_neg=c(-4,0),
                                      sigma_pos=diag(2), sigma_neg=diag(2),
                                      seed=103) %>% 
                                        select(-y)
            



X <- data %>% as.matrix

centers_init <- matrix(c(0, 1, 0, -1), nrow=2)
colnames(centers_init) <- c("x1", "x2")


km_fitted <- kmeans(X, centers=centers_init, iter.max = 1, algorithm = )

km_centroids <- km_fitted$centers %>% as_tibble %>% add_column(cl=factor(c(1,2)))

data %>% 
    add_column(cl = factor(km_fitted$cluster)) %>% 
    ggplot() +
    geom_point(aes(x=x1, y=x2, color=cl, shape = cl)) +
    geom_point(data=km_centroids, aes(x=x1, y=x2), shape='X', size=5) +
    theme(panel.background = element_blank()) +
    lims(x=c(-8, 8), y=c(-8, 8)) 






