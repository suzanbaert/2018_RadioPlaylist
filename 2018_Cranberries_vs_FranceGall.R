library(rvest)
library(xml2)

library(tidyverse)

source("PlaylistScrape.R")




robotstxt::paths_allowed("https://www.relisten.be/playlists/")


#all radio stations on the Belgian version of the site
radio_selection <- c("radio1", "radio2", "studiobrussel", "mnm", 
                     "joefm", "qmusic", "nostalgie", "antwerpen",
                     "clubfm", "familyradio", "radiofg",
                     "topradio", "vbro", "hitfm")



#SCRAPING FOR THE CRANBERRIES
#making the selection
day <- 15:16
dates_selection <- paste0(day,"-01-2018")


#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")

#mapping
caution
playlist_1516 <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)
#test_list <- map2(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)


saveRDS(playlist_1516, "data/cranberriesplaylist.RDS")

playlist_1516 <- readRDS("data/cranberriesplaylist.RDS")


#check return
playlist_1516 %>%
  group_by(radio) %>%
  summarise(n=n())




#check whether it was spelled differently for some
str_view(playlist_1516$artist, "ranb", match=TRUE)
str_view(playlist_1516$title, "ombie", match=TRUE)

#exploring cranberries
#cranberries
playlist_1516 %>%
  filter(artist == "The Cranberries") %>%
  group_by(radio) %>%
  summarise(n=n()) %>%
  arrange(desc(n))


playlist_1516 %>%
  filter(artist == "The Cranberries") %>%
  group_by(title) %>%
  summarise(n=n()) %>%
  arrange(desc(n))







###################
#SCRAPING FOR FRANCE GALL
####################"

#making the selection
day <- 7:8
dates_selection <- paste0(day,"-01-2018")


#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")

#mapping
caution
playlist_0708 <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)
#test_list <- map2(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)


saveRDS(playlist_0708, "data/francegallplaylist.RDS")

playlist_0708 <- readRDS("data/francegallplaylist.RDS")


#exploring cranberries
#cranberries
playlist_0708 %>%
  filter(artist == "France Gall") %>%
  group_by(radio) %>%
  summarise(n=n()) %>%
  arrange(desc(n))


playlist_0708 %>%
  filter(artist == "France Gall") %>%
  group_by(title) %>%
  summarise(n=n()) %>%
  arrange(desc(n))

playlist_0708 %>%
  group_by(radio) %>%
  summarise(n=n())


#check whether it was spelled differently or some
str_view(playlist_0708$artist, "rance", match=TRUE)
str_view(playlist_0708$artist, "all", match=TRUE)



#•need error messages, for instance clubfm at 7-1 is empty