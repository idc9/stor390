# this is the code I used to scrape readfreeonline
# however the website appears to have died...

library(tidyverse)
library(rvest)


chapter_base_url <- 'http://www.readfreeonline.net/OnlineBooks/Harry_Potter_and_the_Sorcerers_Stone/Harry_Potter_and_the_Sorcerers_Stone_'
num_chapters <- 17

# download each chapter and concatonate them
text <- ''
for(i in 1:num_chapters){
    
    # url for the chapter text
    chapter_url <- paste0(chapter_base_url, i, '.html')
    
    # download the chatpter html
    chapter_html <- read_html(chapter_url)  
    
    # extract the text of the chatper from the html
    chapter_text <- chapter_html %>%
        html_nodes(".ContentCss") %>%
        html_text()
    
    #
    text <- paste0(text, chapter_text)
}

# save as a .txt file
# write_lines(text, 'philosophers_stone.txt')
