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
dates_selection <- c("15-01-2018", "16-01-2018")


#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")

#mapping
caution
playlist_TheCranberries <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)

#save to avoid rescraping
saveRDS(playlist_TheCranberries, "data/playlist_TheCranberries.RDS")


#reading file
playlist_TheCranberries <- readRDS("data/playlist_TheCranberries.RDS")


#check return
playlist_TheCranberries %>%
  group_by(radio) %>%
  summarise(n=n())



#check whether it was spelled differently for some
str_view(playlist_TheCranberries$artist, "berrie", match=TRUE)





#exploring cranberries
#cranberries
playlist_TheCranberries %>%
  filter(artist == "The Cranberries") %>%
  summarise(n=n())

playlist_TheCranberries %>%
  filter(artist == "The Cranberries") %>%
  group_by(radio) %>%
  summarise(n=n()) %>%
  arrange(desc(n))


playlist_TheCranberries %>%
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
playlist_FranceGall <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)
#test_list <- map2(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)


saveRDS(playlist_FranceGall, "data/playlist_FranceGall.RDS")

playlist_FranceGall <- readRDS("data/playlist_FranceGall.RDS")


#exploring france gall
#double checking alternative spellings
str_view(playlist_FranceGall$artist, "all", match=TRUE)


playlist_FranceGall %>%
  filter(artist == "France Gall") %>%
  summarise(n=n())

playlist_FranceGall %>%
  filter(artist == "France Gall") %>%
  group_by(radio) %>%
  summarise(n=n()) %>%
  arrange(desc(n))


playlist_FranceGall %>%
  filter(artist == "France Gall") %>%
  group_by(title) %>%
  summarise(n=n()) %>%
  arrange(desc(n))





###################
#SCRAPING FOR CHESTER BEINNINGTON - LINKIN PAR
####################"

#making the selection
dates_selection <- c("20-07-2017", "21-07-2017")


#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")

#mapping
caution
playlist_LinkinPark <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)
#test_list <- map2(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)


saveRDS(playlist_LinkinPark, "data/playlist_LinkinPark.RDS")

playlist_LinkinPark <- readRDS("data/playlist_LinkinPark.RDS")


#exploring france gall
#double checking alternative spellings
str_view(playlist_LinkinPark$artist, "inkin", match=TRUE)
LinkinPark_match <- c("Linkin Park", "Linkin Park Ft. Jay-Z", "Linkin Park Ft. Kiiara", "Jay Z & Linkin Park")

playlist_LinkinPark %>%
  filter(artist %in% LinkinPark_match) %>%
  summarise(n=n())

playlist_LinkinPark %>%
  filter(artist %in% LinkinPark_match) %>%
  group_by(radio) %>%
  summarise(n=n()) %>%
  arrange(desc(n))


playlist_LinkinPark %>%
  filter(artist %in% LinkinPark_match) %>%
  group_by(title) %>%
  summarise(n=n()) %>%
  arrange(desc(n))







###################
#SCRAPING FOR LEONARD COHEN
#NEWS broke on 11/11
####################"

#making the selection
dates_selection <- c("10-11-2016", "11-11-2016", "12-11-2016")


#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")

#mapping
caution
playlist_LeonardCohen <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)
#test_list <- map2(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)


saveRDS(playlist_LeonardCohen, "data/playlist_LeonardCohen.RDS")

playlist_LeonardCohen <- readRDS("data/playlist_LeonardCohen.RDS")


#exploring leonard cohen
#double checking alternative spellings
str_view(playlist_LeonardCohen$artist, "ohen", match=TRUE)
LCohen_match <- c("Leonard Cohen", "Leonard Cohen & Jennifer Warnes", "Leonard Cohen + Editors")

playlist_LeonardCohen %>%
  filter(artist %in% LCohen_match) %>%
  summarise(n=n())

playlist_LeonardCohen %>%
  filter(artist %in% LCohen_match) %>%
  group_by(radio, date) %>%
  summarise(n=n()) %>%
  arrange(desc(n))


playlist_LeonardCohen %>%
  filter(artist %in% LCohen_match) %>%
  group_by(title) %>%
  summarise(n=n()) %>%
  arrange(desc(n))







###################
#SCRAPING FOR DAVID BOWIE
#NEWS broke on 11/01
####################"

#making the selection
dates_selection <- c("11-01-2016", "12-01-2016")


#making all pair combinations
all_pairs <- merge(dates_selection, radio_selection)
colnames(all_pairs) <- c("date", "radio")

#mapping
caution
playlist_DavidBowie <- map2_df(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)
#test_list <- map2(all_pairs$radio, all_pairs$date, read_playlist_and_sleep)


saveRDS(playlist_DavidBowie, "data/playlist_DavidBowie.RDS")

playlist_DavidBowie <- readRDS("data/playlist_DavidBowie.RDS")


#exploring leonard cohen
#double checking alternative spellings
str_view(playlist_DavidBowie$artist, "owie", match=TRUE)
match <- str_detect(playlist_DavidBowie$artist, "Bowie")
playlist_matchBowie <- playlist_DavidBowie[match,]

playlist_matchBowie %>%
  summarise(n=n())

playlist_matchBowie %>%
  group_by(radio) %>%
  summarise(n=n()) %>%
  arrange(desc(n)) %>%
  print(n=nrow(.))


playlist_matchBowie %>%
  group_by(title) %>%
  summarise(n=n()) %>%
  arrange(desc(n))
