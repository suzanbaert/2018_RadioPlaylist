library(rvest)
library(xml2)

library(tidyverse)


#Example page
#html_page <- read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")


#function to read a playlist, returnin a dataframe with timestamp, artist and title of song
read_playlist <- function(radio, date){

  #assemble link
  link <- paste0("https://www.relisten.be/playlists/", radio, "/", date, ".html")

  #playlist info
  html_playlist <- read_html(link) %>%
    html_nodes(css = "#playlist")

  #get time info
  time <- html_playlist %>%
    html_nodes(css = ".media-body > h4 > .pull-right") %>%
    html_text()
  
  #get title info
  title <- html_playlist %>%
    html_nodes(css = ".media-body > h4 > span") %>%
    html_text()
  
  #get artist info
  artist <- html_playlist %>%
    html_nodes(css = ".media-body > p > a > span") %>%
    html_text()
  
  #check for empty pages and return NA if that's the case
  # if (length(artist) == 0) {
  #   artist <- NA
  #   time <- NA
  #   title <- NA}
  
  #check for empty pages and return NA if that's the case
  if (length(artist) == 0) {return(NULL)}

  
  playlist <- data.frame(radio, date, time, title, artist, stringsAsFactors = FALSE)
  playlist$date <- lubridate::dmy(playlist$date)
  playlist
}

#adding system sleep to function
read_playlist_and_sleep <- function(radio, date) {
  Sys.sleep(sample(1:5, 1))
  read_playlist(radio, date)
}



#Example page to test the function
#read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")
#df_test <- read_playlist("radio1", "5-01-2018")


# #test on empty pages
# read_playlist("clubfm", "7-1-2018")
# 
# radios <- c("radio1", "clubfm")
# date <- "07-01-2018"
# pairs <- merge(radios, date)
# test <- map2_df(pairs$x, pairs$y, read_playlist)
# 
# tail(test)
