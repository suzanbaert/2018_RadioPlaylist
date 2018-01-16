library(rvest)
library(xml2)

library(tidyverse)
source("PlaylistScrape.R")




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
test_df <- map2_df(three_pairs$radio, three_pairs$date, read_playlist_and_sleep)
test_list <- map2(three_pairs$radio, three_pairs$date, read_playlist_and_sleep)



studiobrussel <- filter(test, radio =="studiobrussel")

studiobrussel %>%
  group_by(artist) %>%
  summarise(n=n())%>%
  arrange(desc(n))

studiobrussel %>%
  group_by(artist) %>%
  summarise(n=n())%>%
  arrange(desc(n))


studiobrussel %>%
  group_by(title) %>%
  summarise(n=n())%>%
  arrange(desc(n))

studiobrussel %>%
  filter(title == "Kiwi")
