library(tidyverse)


#getting the data 
radios_clean <- readRDS("playlist_project/data/3m_radios_clean.RDS")


#how many songs played
count(radios_clean, radio)



#how many unique songs played
radios_clean %>% 
  select(radio, title, main_artist) %>% 
  distinct() %>% 
  count(radio) %>% 
  mutate(radio = reorder(radio, n)) %>% 
  ggplot() +
    geom_col(aes(x = radio, y = n), fill = "darkcyan") +
    coord_flip() + 
    labs(title = "Number of unique songs played over 3 months",
         x = "Number of Songs",
         y = "Radio station")
  
  

#top artists
radios_clean %>% 
  count(main_artist, sort = TRUE) %>% 
  top_n(20) %>% 
  mutate(artist = reorder(main_artist, n)) %>%
  ggplot(aes(x=main_artist, y=n)) +
  geom_col(fill="darkcyan") + 
  coord_flip() +
  labs(title = "Artists by number of times played across all radios in 3 months",
       xlab = "Number of times played between 1/1/2018 and 31/3/2018", ylab="Artist")


radios_clean %>% 
  group_by(radio) %>% 
  count(artist2, sort = TRUE) %>% 
  top_n(10) %>% 
  spread(radio, n)


radios_clean %>% 
  group_by(radio) %>% 
  count(artist, sort = TRUE) %>% 
  top_n(5) %>% 
  mutate(artist = reorder(artist, n)) %>%
  ggplot(aes(x=artist, y=n)) +
  geom_col(fill="darkcyan") + 
  coord_flip() +
  facet_wrap(~radio, scales = "free_y", ncol=1) +
  labs(title = "Artists by number of times played across all radios in 4 weeks",
       xlab = "Number of times played between 8/1/2018 and 11/2/2018", ylab="Artist")




#Questions
#Max artist, how many times a day? do the hit radios do worse?
#max 10 artists, idem


