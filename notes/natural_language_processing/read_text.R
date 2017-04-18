library(stringr)

read_author <- function(author) {
    # Reads in a collection of texts in one folder
    # returns a data frame
    
    DATADIR <- str_c(author, '/')
    files <- list.files(DATADIR)
    
    books <- tibble()
    for(i in 1:length(files)){
        file_name <- files[i]
        book_title <- str_split(file_name, '.txt', simplify = TRUE)[1]
        
        book_df <- readLines(str_c(DATADIR, file_name)) %>% # read in text file
            .[. != ""] %>% # remove blank lines
            tibble(text=.) %>% # convert into data frame
            mutate(linenumber = row_number(),
                   author = author,
                   book = book_title) # add some meta data
        
        books <- rbind(books, book_df)
    }
    books
}
