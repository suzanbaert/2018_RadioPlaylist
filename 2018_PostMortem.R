library(rvest)
library(xml2)
library(tidyverse)
library(lubridate)
source("PlaylistScrape.R")


#allowed to scrape?
robotstxt::paths_allowed("https://www.relisten.be/playlists/")



read_all_playlists_on_dates <- function(newsdate, artist) {
  
  #all available radio stations on the Belgian version of the site
  radio_selection <- c("radio1", "radio2", "studiobrussel", "mnm", 
                       "joefm", "qmusic", "nostalgie", "antwerpen",
                       "clubfm", "familyradio", "radiofg",
                       "topradio", "vbro", "hitfm")
  
  #date selection: day of the news and day after, same two days a week before
  newsdate <- dmy(newsdate)
  dates_post <- c(newsdate,  newsdate+1)
  dates_pre <- c(newsdate-7, newsdate-6)
  
  
  #making all pair combinations
  all_pairs_post <- merge(format(dates_post, "%d-%m-%Y"), radio_selection)
  all_pairs_pre <- merge(format(dates_pre, "%d-%m-%Y"), radio_selection)
  
  
  #map to iterate over all station-date combinations
  playlist_pre <- map2_df(all_pairs_pre$y, all_pairs_pre$x, read_playlist_and_sleep)
  playlist_post <- map2_df(all_pairs_post$y, all_pairs_post$x, read_playlist_and_sleep)
  
  
  #adding info and merging into one dataframe
  playlist_post$timing <- "post"
  playlist_pre$timing <- "pre"
  playlist_df <- bind_rows(playlist_post, playlist_pre)
  playlist_df$death <- artist
  
  
  #remove any space bars from artist name
  artist0 <- str_replace(artist, " ", "")

    #save to avoid rescraping
  RDS <- paste0("data/playlist_", artist0, ".RDS")
  saveRDS(playlist_df, RDS)
  
  return(playlist_df)
}



#SCRAPING POST MORTEM (or after the news broke)

#news in paper on 15/01/2018 om 18:22 
playlist_TheCranberries <- read_all_playlist_on_dates("15-01-2018", "The Cranberries")

#news in paper on 07/01/2018 om 14:54 
playlist_FranceGall <- read_all_playlist_on_dates("7-01-2018", "France Gall")

#news in paper on 25/10/2017 om 17:36
playlist_FatsDomino <- read_all_playlist_on_dates("25-10-2017", "Fats Domino")

#news in paper on 06/12/2017 om 07:28 
playlist_JohnnyHallyday <- read_all_playlist_on_dates("06-12-2017", "Johnny Hallyday")

#news in paper on 20/07/2017 om 21:09
playlist_LinkinPark <- read_all_playlist_on_dates("20-07-2017", "Linkin Park")

#news in paper on 03/10/2017 om 06:23
playlist_TomPetty <- read_all_playlist_on_dates("03-10-2017", "Tom Petty")

#news in paper on 11/11/2016 om 09:31
playlist_LeonardCohen <- read_all_playlist_on_dates("11-11-2016", "Leonard Cohen")

#news in paper on 21/04/2016 om 19:19
playlist_Prince <- read_all_playlist_on_dates("21-04-2016", "Prince")

#news in paper on 17/03/2016 om 04:24
playlist_FrankSinatra <- read_all_playlist_on_dates("17-03-2016", "Frank Sinatra")

#news in paper on 11/01/2016 om 16:13
playlist_DavidBowie <- read_all_playlist_on_dates("11-01-2016", "David Bowie")



#reading in dat


#news in paper on 15/01/2018 om 18:22 
playlist_TheCranberries <- readRDS(playlist_TheCranberries.RDS)

#news in paper on 07/01/2018 om 14:54 
playlist_FranceGall <- readRDS(playlist_FranceGall.RDS)

#news in paper on 25/10/2017 om 17:36
playlist_FatsDomino <- readRDS(playlist_FatsDomino.RDS)

#news in paper on 06/12/2017 om 07:28 
playlist_JohnnyHallyday <- readRDS(playlist_JohnnyHallyday.RDS)

#news in paper on 20/07/2017 om 21:09
playlist_LinkinPark <- readRDS(playlist_LinkinPark.RDS)

#news in paper on 03/10/2017 om 06:23
playlist_TomPetty <- readRDS(playlist_TomPetty.RDS)

#news in paper on 11/11/2016 om 09:31
playlist_LeonardCohen <- readRDS(playlist_LeonardCohen.RDS)

#news in paper on 21/04/2016 om 19:19
playlist_Prince <- readRDS(playlist_Prince.RDS)

#news in paper on 17/03/2016 om 04:24
playlist_FrankSinatra <- readRDS(playlist_FrankSinatra.RDS)

#news in paper on 11/01/2016 om 16:13
playlist_DavidBowie <- readRDS(playlist_DavidBowie.RDS)



#ANALYSIS



str_view(playlist_DavidBowie$artist, "[dD]avid Bowie", match=TRUE)
match <- str_detect(playlist_DavidBowie$artist, "Bowie")
match <- str_detect(playlist_DavidBowie$artist, regex("David Bowie", ignore_case = TRUE))

playlist_matchBowie <- playlist_DavidBowie[match,]





playlist_match <- function(playlist, artist) {
  
  #finding rows with artists name, and extracting only those in a subset
  match <- str_detect(playlist, regex(artist, ignore_case = TRUE))
  playlist[match,]
}



playlist_match(playlist_DavidBowie, "David Bowie")




findplaylist

findnumbersongs 



#REMEMBER
#Need to throw out any stations that don't have 4 days complete


glimpse(playlist_TheCranberries)

playlist_TheCranberries %>%
  group_by(radio,date) %>%
  summarise(n()) %>%
  group_by(radio) %>%
  summarise(n())

#or thecranberrries need to remove clubfm

