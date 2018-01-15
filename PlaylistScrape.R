library(rvest)
library(xml2)

library(tidyverse)


robotstxt::paths_allowed("https://www.relisten.be/playlists/")


#Example page
html_page <- read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")



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

#Example page
#read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")
df_test <- read_playlist("radio1", "5-01-2018")



#making the selection
day <- 8:15
dates_selection <- paste0(day,"-01-2018")

radio_selection <- c("radio1", "radio2", "studiobrussel", "mnm", 
                     "joefm", "qmusic", "nostalgie")

