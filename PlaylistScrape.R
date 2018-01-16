library(rvest)
library(xml2)

library(tidyverse)


robotstxt::paths_allowed("https://www.relisten.be/playlists/")


#Example page
html_page <- read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")


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
  
  playlist <- data.frame(radio, date, time, title, artist, stringsAsFactors = FALSE)
  playlist$date <- lubridate::dmy(playlist$date)
  playlist
}

#adding system sleep to function
read_playlist_and_sleep <- function(radio, date) {
  read_playlist(radio, date)
  Sys.sleep(10)
}



#Example page to test the function
#read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")
#df_test <- read_playlist("radio1", "5-01-2018")


#SCRAPING
#making the selection
day <- 8:16
dates_selection <- paste0(day,"-01-2018")

#radios selection
radio_selection<- c("radio1", "radio2", "studiobrussel", "mnm", 
                     "joefm", "qmusic", "nostalgie")

#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")



#SCRAPE TEST

#test dataframe of three
three_pairs <- sample_n(all_pairs, 3)

#Currently returns as a list
test <- map2(three_pairs$radio, three_pairs$date, read_playlist_and_sleep)




