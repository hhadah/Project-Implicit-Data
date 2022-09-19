# Import data with geographic variables from Github
Arab_IAT <- read.csv(file.path(datasets,"Arab_IAT_Clean.csv"))

# this .csv contains all state abbrevs, state nos., and lowercase state names
state_info <- read.csv(file.path(datasets,"state_info.csv"))

# Remove people who don't report their state 
Arab_IAT <- Arab_IAT[Arab_IAT$state != "",]

# merge state info with iat data
Arab_IAT <- merge(Arab_IAT, state_info, 
                  by = "state", 
                  all = TRUE) %>% 
  rename(state_abr = state)

Arab_IAT <- Arab_IAT %>% 
  rename(state = state.name)

arab_grouped_bystate <- Arab_IAT %>% 
  group_by(state, year) %>% 
  summarise(value = mean(Implicit, na.rm = TRUE)) %>% 
  select(state,
         year,
         value)

### Get lat & long info -----

# this "states" dataframe has the lat & long info needed for mapping.
states <- st_as_sf(map('state', plot = TRUE, fill = TRUE))
# states <- map_data("state")
states <- states %>% 
  rename(state = ID)

# join IAT + lowercase names to df that has lat & long
arab_grouped_bystate <- inner_join(arab_grouped_bystate, 
                                   states, 
                                   by = "state") 
arab_grouped_bystate <- st_as_sf(arab_grouped_bystate)


# use for loop to plot all maps

for (year_map in seq(2004,2021)) {
  map <- ggplot() + geom_sf(data = arab_grouped_bystate |> filter(year == year_map), 
                            aes(fill = value), 
                            color = "white")+
    scale_fill_viridis_c(option = "D", direction = -1) +
    theme_customs() +
    theme(legend.position = "bottom") +
    labs(title = paste0("Implicit Arab Prejeduice 
       Scores: by State ", year_map))
  map
  ggsave(path = figures_wd, filename = paste0(year_map,"arabmap.png"))
}
