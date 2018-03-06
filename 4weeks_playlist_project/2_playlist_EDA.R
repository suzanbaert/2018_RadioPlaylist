library(tidyverse)


#getting the data 
all_radios <- readRDS("4weeks_playlist_project/data/4weeks_allradios.RDS")
radios_clean <- readRDS("4weeks_playlist_project/data/4weeks_radios_clean.RDS")


#top artits
radios_clean %>% 
  count(artist, sort = TRUE) %>% 
  top_n(20) %>% 
  mutate(artist = reorder(artist, n)) %>%
  ggplot(aes(x=artist, y=n)) +
  geom_col(fill="darkcyan") + 
  coord_flip() +
  labs(title = "Artists by number of times played across all radios in 4 weeks",
       xlab = "Number of times played between 8/1/2018 and 11/2/2018", ylab="Artist")


View(radios_clean %>% count(artist))
