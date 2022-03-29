Packages <- c("dplyr","foreign","shiny", "DT", "leaflet", "datasets", "devtools", "maptools", "rgdal", "rmapshaper", "rgeos","tidyr")
lapply(Packages, library, character.only = TRUE)

# mapCo <- readShapePoly("QGIS/NCcountyMap.shp")
# mapCo <- rmapshaper::ms_simplify(mapCo)
# orderCo <- read.dbf("QGIS/NCcountyMap.dbf")
# coordinatesCo <- coordinates(mapCo)
# orderCo <- orderCo %>%
#   select(NAME) %>%
#   rename(County = NAME) %>%
#   mutate(County = as.character(County)) %>%
#   mutate(County=replace(County, County=="McDowell", "Mcdowell")) %>%
#   mutate(order = row_number())

load("QGIS/NCShp.RData") # Loads the workspace of the variables created by the comments above

fall2018 <- read.csv("data/Fall2018.csv")
fall2018Count <- fall2018 %>%
  select(c(1,7,11,12))
names(fall2018Count) <- c("Term","County","Rank","Headcount")

fall2017 <- read.csv("data/Fall2017.csv")
fall2017Count <- fall2017 %>%
  select(c(1,7,11,12))
names(fall2017Count) <- c("Term","County","Rank","Headcount")

all_data = rbind(fall2017Count,fall2018Count)


all_data <- left_join(orderCo, all_data)

all_data <- all_data %>%
  arrange(Term,County)


write.csv(all_data,"data/all_data.csv",row.names = FALSE)

