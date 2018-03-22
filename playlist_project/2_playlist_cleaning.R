library(tidyverse)
#all_radios <- readRDS("playlist_project/data/10weeks_allradios.RDS")

#------------------
# CHECKING THE DATA
#------------------

#basic cleaning
radios_clean1 <- all_radios %>% 
  mutate_all(tolower) %>% 
  mutate_all(str_trim) %>% 
  mutate_all(~str_replace(., "\\s{2,}", " ")) %>% 
  unite(day, date, time, sep=" ") %>% 
  mutate(day = lubridate::ymd_hm(day)) 


#### Cleaning up artist list ####

#artist list
artist_list <- count(radios_clean1, artist, sort=TRUE)
unlist(str_extract_all(artist_list$artist, ".+ e[nt] .+"))

artist_list2 <- count(radios_clean2, artist, sort=TRUE)
unlist(str_extract_all(artist_list2$artist, ".+ and .+"))




#changing all feat. ft. + & etc into "and"
radios_clean1$artist_original <- radios_clean1$artist

keep_intact <- c("oscar and the wolf", "kc and the sunshine band", "kool and the gang", 
                 "of monsters and men", "mumford and sons", "christine and the queens",
                 "womack and womack", "flash and the pan", "ike and tina turner", "mel and kim",
                 "touch and go", "sam and dave", "simon and garfunkel", "echo and the bunnymen", 
                 "the mamas and the papas", "peter bjorn and john", "angus and julia stone",
                 "belle and sebastian", "samson and gert", "nicole and hugo")


radios_clean2 <- radios_clean1 %>% 
  mutate(artist = str_replace_all(artist, "fe?a?t\\.", "and"),
         artist = str_replace_all(artist, " [+&-x] ", " and "),
         artist = str_replace_all(artist, " vs ", " and "),
         artist = str_replace_all(artist, " e[nt] ", " and ")) %>% 
  mutate(main_artist = case_when(
    artist %in% keep_intact ~ artist,
    TRUE ~ str_replace(artist, "(.+) and .+", "\\1")))




saveRDS(radios_clean2, "playlist_project/data/10weeks_radios_clean.RDS")
