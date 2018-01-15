library(rvest)
library(xml2)

library(tidyverse)


robotstxt::paths_allowed("https://www.relisten.be/playlists/")


#Example page
html_page <- read_html("https://www.relisten.be/playlists/radio1/01-01-2018.html")


#playlist info
html_playlist <- html_page %>%
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

playlist <- data.frame(time, title, artist, stringsAsFactors = FALSE)

