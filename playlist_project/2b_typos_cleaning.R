

##umloat o a u a acent
radios_clean1$artist <- str_replace_all(radios_clean1$artist, "ö", "o")




radios_clean1$artist <- str_replace(radios_clean1$artist, "blof", "bløf")
radios_clean1$artist <- str_replace(radios_clean1$artist, "blÃ¸f", "bløf")

radios_clean1$artist <- str_replace(radios_clean1$artist, "^1?0cc", "10 cc")
radios_clean1$artist <- str_replace(radios_clean1$artist, "^jimi hendri.+", "jimi hendrix")
radios_clean1$artist <- str_replace(radios_clean1$artist, "^p\\!nk", "pink")
radios_clean1$artist <- str_replace(radios_clean1$artist, "^rudimental .+", "rudimental")
radios_clean1$artist <- str_replace(radios_clean1$artist, "^c.nd. lauper", "cyndi lauper")
radios_clean1$artist <- str_replace(radios_clean1$artist, "and victoria bergsman", "")
radios_clean1$artist <- str_replace(radios_clean1$artist, "keala and", "keala settle and")
radios_clean1$artist <- str_replace(radios_clean1$artist, "gorky", "gorki")
radios_clean1$artist <- str_replace(radios_clean1$artist, "mc fiott?i .+", "mc fioti")
radios_clean1$artist <- str_replace(radios_clean1$artist, "mc fiott?i", "mc fioti")
radios_clean1$artist <- str_replace(radios_clean1$artist, "todiefor .+", "todiefor")
radios_clean1$artist <- str_replace(radios_clean1$artist, "omd", "orchestral manoeuvres in the dark")
radios_clean1$artist <- str_replace(radios_clean1$artist, "jayz", "jay z")
radios_clean1$artist <- str_replace(radios_clean1$artist, "tourist lemc", "tourist le mc")
radios_clean1$artist <- str_replace(radios_clean1$artist, "ceelo green", "cee lo green")
radios_clean1$artist <- str_replace(radios_clean1$artist, "rag.+n.+bone man", "rag'n'bone man")
radios_clean1$artist <- str_replace(radios_clean1$artist, "the weekend", "the weeknd")
radios_clean1$artist <- str_replace(radios_clean1$artist, "guns.+n.+roses", "guns n' roses")
radios_clean1$artist <- str_replace(radios_clean1$artist, "youssou .+", "youssou n'dour")
radios_clean1$artist <- str_replace(radios_clean1$artist, "louis fonsi", "luis fonsi")
radios_clean1$artist <- str_replace(radios_clean1$artist, "popgun", "pop gun")
radios_clean1$artist <- str_replace(radios_clean1$artist, "ub 40", "ub40")
radios_clean1$artist <- str_replace(radios_clean1$artist, "rob.+n.+raz", "rob 'n' raz")
radios_clean1$artist <- str_replace(radios_clean1$artist, "reel 2 real", "reel to real")


radios_clean1$artist <- str_replace(radios_clean1$artist, "(the)? jackson 5", "the jackson five")
radios_clean1$artist <- str_replace(radios_clean1$artist, "ph d", "phd")



radios_clean1$artist <- str_replace(radios_clean1$artist, "\\bwith\\b", "and")
radios_clean1$artist <- str_replace(radios_clean1$artist, "mark and a k", "mark with a k")
radios_clean1$artist <- str_replace(radios_clean1$artist, "sin and sebastian", "sin with sebastian")
radios_clean1$artist <- str_replace(radios_clean1$artist, "tom robinson band", "tom robinson")
radios_clean1$artist <- str_replace(radios_clean1$artist, "popgun", "pop gun")
radios_clean1$artist <- str_replace(radios_clean1$artist, "wizstars", "the wiz stars")
radios_clean1$artist <- str_replace(radios_clean1$artist, "a caus' des ", "a cause des")
radios_clean1$artist <- str_replace(radios_clean1$artist, "rafaella carra", "raffaella carra")
radios_clean1$artist <- str_replace(radios_clean1$artist, "elvis", "raffaella carra")

radios_clean1$artist <- str_replace(radios_clean1$artist, "témé tan", "teme tan")
radios_clean1$artist <- str_replace(radios_clean1$artist, "tatu", "t a t u")
radios_clean1$artist <- str_replace(radios_clean1$artist, "de booy", "de booij")
radios_clean1$artist <- str_replace(radios_clean1$artist, "polarkreiss", "polarkreis")
radios_clean1$artist <- str_replace(radios_clean1$artist, "rené froger", "rene froger")
radios_clean1$artist <- str_replace(radios_clean1$artist, "don mcclean", "don mclean")
radios_clean1$artist <- str_replace(radios_clean1$artist, "greenday", "green day")
radios_clean1$artist <- str_replace(radios_clean1$artist, "patti smith group", "patti smith")
radios_clean1$artist <- str_replace(radios_clean1$artist, "jasper stervelinck", "jasper steverlinck")
radios_clean1$artist <- str_replace(radios_clean1$artist, "2pac", "2 pac")






radios_clean1$title <- str_replace(radios_clean1$title, "!!!embargo tot vrijdag 02/02!!! ", "")
radios_clean1$title <- str_replace(radios_clean1$title, "a caus' des ", "a cause des")