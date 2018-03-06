library(tidyverse)

#contains function read_playlist(radio, date)
#for iterative: read_playlist_and_sleep <- function(radio, date)
source("PlaylistScrape.R")

#function tests - still works?
#○https://www.relisten.be/playlists/studiobrussel/09-01-2018.html
test1 <- read_playlist("studiobrussel", "09-01-2018")


#allowed to scrape?
robotstxt::paths_allowed("https://www.relisten.be/playlists/")


#all radio stations on the Belgian version of the site
radio_selection <- c("radio1", "radio2", "studiobrussel", "mnm", 
                     "joefm", "qmusic", "nostalgie", "antwerpen",
                     "clubfm", "familyradio", "radiofg",
                     "topradio", "vbro", "hitfm")



#date selection. i want to hit radios between xmas and "crocus holiday"
#so dates from monday 8/1/2018 to 11/2/2018
date_jan_n <- 8:31
dates_jan <- paste0(date_jan_n,"-01-2018")
date_feb_n <- 1:11
dates_feb <- paste0(date_feb_n,"-02-2018")
date_selection <- c(dates_jan, dates_feb)



#test stubru only
input_df_stubru <- data.frame(date = date_selection)
input_df_stubru$radio <- "studiobrussel"

stubru <- map2_df(input_df_stubru$radio, input_df_stubru$date, read_playlist_and_sleep)
saveRDS(stubru, "playlist_project/data/4weeks_stubru.RDS")



#get them all
input_df <- merge(date_selection, radio_selection)
names(input_df) <- c("date", "radio")

all_radios <- map2_df(input_df$radio, input_df$date, read_playlist_and_sleep)
saveRDS(all_radios, "playlist_project/data/4weeks_allradios.RDS")




#first things first

count(stubru, artist, sort = TRUE)
count(stubru, artist, title, sort = TRUE)




