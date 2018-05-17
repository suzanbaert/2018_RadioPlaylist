library(tidyverse)
# all_radios <- readRDS("playlist_project/data/allradios_30apr.RDS")





#------------------
# CHECKING THE DATA
#------------------

# cleaning title - removing items between brackets () and [], removing multiple punctuation at end of sentence
# cleaning artist - removing anything between brackets, removing punctuation
# all: removing double spaces, to lower

#basic cleaning
radios_clean1 <- all_radios %>%
  mutate(title = str_replace_all(title, "\\(.+\\)", ""),
         title = str_replace_all(title, "\\[.+\\]", ""),
         title = str_replace(title, "(\\w+)\\s?[[:punct:]]+$", "\\1")) %>% 
  mutate(artist = str_replace_all(artist, "\\(.+\\)", ""),
         artist = str_replace_all(artist, "[.*,-]", " ")) %>% 
  mutate_all(tolower) %>% 
  mutate_all(str_trim) %>% 
  mutate_all(~str_replace(., "\\s{2,}", " ")) %>% 
  unite(day, date, time, sep=" ") %>% 
  mutate(day = lubridate::ymd_hm(day)) 






#copy original artist
radios_clean1$artist_original <- radios_clean1$artist


#fixing typos. I found these by looking at same title song but different artists
source("playlist_project/2b_typos_cleaning.R")





keep_intact <- c("oscar and the wolf", "kc and the sunshine band", "kool and the gang", 
                 "of monsters and men", "mumford and sons", "christine and the queens",
                 "womack and womack", "flash and the pan", "ike and tina turner", "mel and kim",
                 "touch and go", "sam and dave", "simon and garfunkel", "echo and the bunnymen", 
                 "the mamas and the papas", "peter bjorn and john", "angus and julia stone",
                 "belle and sebastian", "samson and gert", "nicole and hugo", "eric and sanne",
                 "lamp lazarus and kris", "earth wind and fire", "c and c music factory",
                 "sly and family stone", "iron and wine", "moments and whatnauts", "me and my",
                 "martha and the muffins", "nelly and kelly rowland", "florence and the machine", 
                 "years and years", "c and c music factory")
                 

#regex: reducing ft. feat. vs. en/et & to and
#regex: if "the artist" exists as well, make it "the artist" - fixed cranberries/the cranberries etc

radios_clean2 <- radios_clean1 %>% 
  mutate(artist = str_replace_all(artist, " fe?a?t\\.? ", " and "),
         artist = str_replace_all(artist, " [+&x;\\\\/] ", " and "),
         artist = str_replace_all(artist, "[;\\\\/]", " and "),
         artist = str_replace_all(artist, " vs ", " and "),
         artist = str_replace_all(artist, " e[nt] ", " and ")) %>% 
  mutate(artist = ifelse(paste("the", artist) %in% artist, paste("the", artist), artist)) %>% 
  mutate(artist = ifelse(paste("de", artist) %in% artist, paste("de", artist), artist)) %>% 
  mutate(main_artist = case_when(artist %in% keep_intact ~ artist,
                                 TRUE ~ str_replace(artist, "(.+?) and .+", "\\1")))



saveRDS(radios_clean2, "playlist_project/data/radios_clean.RDS")
write.csv(radios_clean2, "playlist_project/data/radios_clean.csv")








#### check tot hier ####


#checking songs with more than one artist

collapse_titles_and_artists <- radios_clean2 %>% 
  group_by(title, main_artist) %>% 
  count(main_artist, sort=TRUE) %>% 
  ungroup()

test_via_titles_for_different_artist_writing <- collapse_titles_and_artists %>% 
  group_by(title) %>% 
  count(title, sort=TRUE) %>% 
  filter(nn>1)

collapse_titles_and_artists %>% 
  filter(title %in% test_via_titles_for_different_artist_writing$title) %>% 
  arrange(title) %>% 
  View()
 




