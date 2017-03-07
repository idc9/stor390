# To get some data you can use to run the code in the classification lecture/notes run this script
# it will produce a data frame called data with three columns: two x variables and the class labels


# set the random seed
set.seed(100)

# class means
mean_neg <- c(-1, 0)
mean_pos <- c(1, 0)


# generate data from negative class
class_neg <- rmvnorm(n=200, mean=mean_neg, sigma=diag(2)) %>% 
    as_tibble() %>%
    mutate(y=-1) %>%
    rename(x1=V1, x2=V2)

# generate data from positive class
class_pos <- rmvnorm(n=200, mean=mean_pos, sigma=diag(2)) %>% 
    as_tibble() %>%
    mutate(y=1) %>%
    rename(x1=V1, x2=V2)

# put data into one data frame
data <- rbind(class_pos, class_neg)%>% 
    mutate(y =factor(y)) # class label should be a factor

data