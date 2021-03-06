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
  RDS <- paste0("postmortem_project/data/playlist_", artist0, ".RDS")
  saveRDS(playlist_df, RDS)
  
  return(playlist_df)
}



#SCRAPING POST MORTEM (or after the news broke)

#news in paper on 15/01/2018 om 18:22 
playlist_TheCranberries <- read_all_playlists_on_dates("15-01-2018", "The Cranberries")

#news in paper on 07/01/2018 om 14:54 
playlist_FranceGall <- read_all_playlists_on_dates("7-01-2018", "France Gall")

#news in paper on 25/10/2017 om 17:36
playlist_FatsDomino <- read_all_playlists_on_dates("25-10-2017", "Fats Domino")

#news in paper on 06/12/2017 om 07:28 
playlist_JohnnyHallyday <- read_all_playlists_on_dates("06-12-2017", "Johnny Hallyday")

#news in paper on 20/07/2017 om 21:09
playlist_LinkinPark <- read_all_playlists_on_dates("20-07-2017", "Linkin Park")

#news in paper on 03/10/2017 om 06:23
playlist_TomPetty <- read_all_playlists_on_dates("03-10-2017", "Tom Petty")

#news in paper on 11/11/2016 om 09:31
playlist_LeonardCohen <- read_all_playlists_on_dates("11-11-2016", "Leonard Cohen")

#news in paper on 21/04/2016 om 19:19
playlist_Prince <- read_all_playlists_on_dates("21-04-2016", "Prince")

#news in paper on 11/01/2016 om 16:13
playlist_DavidBowie <- read_all_playlists_on_dates("11-01-2016", "David Bowie")



#reading in data


#news in paper on 15/01/2018 om 18:22 
playlist_TheCranberries <- readRDS("postmortem_project/data/playlist_TheCranberries.RDS")

#news in paper on 07/01/2018 om 14:54 
playlist_FranceGall <- readRDS("postmortem_project/data/playlist_FranceGall.RDS")

#news in paper on 25/10/2017 om 17:36
playlist_FatsDomino <- readRDS("postmortem_project/data/playlist_FatsDomino.RDS")

#news in paper on 06/12/2017 om 07:28 
playlist_JohnnyHallyday <- readRDS("postmortem_project/data/playlist_JohnnyHallyday.RDS")

#news in paper on 20/07/2017 om 21:09
playlist_LinkinPark <- readRDS("postmortem_project/data/playlist_LinkinPark.RDS")

#news in paper on 03/10/2017 om 06:23
playlist_TomPetty <- readRDS("postmortem_project/data/playlist_TomPetty.RDS")

#news in paper on 11/11/2016 om 09:31
playlist_LeonardCohen <- readRDS("postmortem_project/data/playlist_LeonardCohen.RDS")

#news in paper on 21/04/2016 om 19:19
playlist_Prince <- readRDS("postmortem_project/data/playlist_Prince.RDS")

#news in paper on 11/01/2016 om 16:13
playlist_DavidBowie <- readRDS("postmortem_project/data/playlist_DavidBowie.RDS")






#TO ONE DATAFRAME

find_match <- function(playlist, pattern) {
  match <- grepl(pattern, playlist$artist, ignore.case = TRUE)
  match_df <- playlist[match,]
}



#building input 
input_playlist <- list(playlist_DavidBowie, playlist_FatsDomino, playlist_FranceGall,
              playlist_JohnnyHallyday, playlist_LeonardCohen,
              playlist_LinkinPark, playlist_Prince, playlist_TheCranberries,
              playlist_TomPetty)
              
input_pattern <- c("Bowie", "Fats", "France Gall", "Hall[iy]day", "Cohen",
             "Linkin", "Prince [^M]", "Cranberries", "Petty")

#by looking manual in case i had something i didn't want:
str_view(playlist_TomPetty$artist, "Petty", match=TRUE)


#combining all matching rows in one dataframe
match_df <- map2_df(input_playlist, input_pattern, find_match)

#saving to avoid future computing time
saveRDS(match_df, "postmortem_project/data/match_df.RDS")

match_df <- readRDS("postmortem_project/data/match_df.RDS")





#ANALYSIS

#contingency table
cont_table <- as.data.frame(table(match_df$death, match_df$timing))


summary_table <- match_df %>%
  group_by(death, timing) %>%
  summarise(n=n()) 

#ensuring descending plot
levels <- summary_table %>%
  filter(timing=="post")%>%
  arrange(desc(n)) %>%
  pull(death)


#comparing pre and post
summary_table <- match_df %>%
  group_by(death, timing) %>%
  summarise(n=n()) %>%
  spread(timing, n) %>%
  mutate(ratio = post/pre) %>%
  arrange(desc(post))

levels <- summary_table %>%
  arrange(post) %>%
  pull(death)

# match_df$death <- ordered(match_df$death, levels=levels)



#plotting pre and post
colors <- c("#7a337c", "#CFCCCF")
levels_artists <- summary_table %>%
  arrange(post) %>%
  pull(death)


ggplot(match_df, aes(x=death, fill=timing)) +
  geom_bar(position = position_dodge(preserve = "single"))+
  scale_fill_manual(values=colors) +
  labs(title ="Times played pre- versus post mortem", 
        x = "Artist", y = "Frequency over 2 days") +
  scale_x_discrete(limits = levels_artists) +
  coord_flip()




#which radio?
radio_summary <- match_df %>%
  group_by(radio, timing) %>%
  summarise(n=n()) %>%
  spread(timing, n) %>%
  arrange(desc(post))






#oldies
match_df %>%
  filter(death %in% c("Fats Domino")) %>%
  group_by(radio, timing) %>%
  summarise(n=n()) %>%
  spread(timing, n) %>%
  arrange(desc(post))

match_df %>%
  filter(death %in% c("France Gall", "Fats Domino", "Johnny Hallyday")) %>%
  group_by(radio, timing) %>%
  summarise(n=n()) %>%
  spread(timing, n) %>%
  arrange(desc(post))


#master singer-songwriters
match_df %>%
  filter(death %in% c("Leonard Cohen", "Tom Petty")) %>%
  group_by(radio, timing) %>%
  summarise(n=n()) %>%
  spread(timing, n) %>%
  arrange(desc(post))


#transcending 
match_df %>%
  filter(death %in% c("David Bowie", "Prince")) %>%
  group_by(radio, timing) %>%
  summarise(n=n()) %>%
  spread(timing, n) %>%
  arrange(desc(post))


levels_radios <- radio_summary %>%
  arrange(post) %>%
  pull(radio)


ggplot(match_df, aes(x=radio, fill=timing)) +
  geom_bar(position = position_dodge(preserve = "single"))+
  scale_fill_manual(values=colors) +
  labs(title ="Times played pre- versus post mortem", 
       x = "Radio", y = "Frequency over 2 days") +
  scale_x_discrete(limits = levels_radios) +
  coord_flip()
