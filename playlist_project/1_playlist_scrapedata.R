library(tidyverse)

#contains function read_playlist(radio, date)
#for iterative: read_playlist_and_sleep <- function(radio, date)
source("PlaylistScrape.R")


#------------------
# SCRAPING THE DATA
#------------------

#function tests - still works?
#https://www.relisten.be/playlists/studiobrussel/09-01-2018.html
test1 <- read_playlist("studiobrussel", "09-01-2018")


#allowed to scrape?
robotstxt::paths_allowed("https://www.relisten.be/playlists/")


#all radio stations on the Belgian version of the site
#remoed hitfm, clubfm and radiofg because too many missing playlist days
radio_selection <- c("radio1", "radio2", "studiobrussel", "mnm", 
                     "joefm", "qmusic", "nostalgie")


#date selection. 
dates_jan <- paste0(1:31, "-01-2018")
dates_feb <- paste0(1:28, "-02-2018")
dates_mar <- paste0(1:15, "-03-2018")
date_selection <- c(dates_jan, dates_feb, dates_mar)


#test stubru only
# input_df_stubru <- data.frame(date = date_selection)
# input_df_stubru$radio <- "studiobrussel"
# 
# stubru <- map2_df(input_df_stubru$radio, input_df_stubru$date, read_playlist_and_sleep)
# saveRDS(stubru, "playlist_project/data/4weeks_stubru.RDS")



#get them all
input_df <- merge(date_selection, radio_selection)
names(input_df) <- c("date", "radio")

all_radios <- map2_df(input_df$radio, input_df$date, read_playlist_and_sleep)
saveRDS(all_radios, "playlist_project/data/10weeks_allradios.RDS")




#quick check
#do i have all the dates for all radios
table(all_radios$radio, all_radios$date)
