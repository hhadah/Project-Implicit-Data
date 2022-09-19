# Import data with geographic variables from Github
Race_IAT <- read.csv(file.path(datasets,"Race_IAT_Clean.csv"))

# this .csv contains all state abbrevs, state nos., and lowercase state names
state_info <- read.csv(file.path(datasets,"state_info.csv"))

# Remove people who don't report their state 
Race_IAT <- Race_IAT[Race_IAT$state != "",]

# merge state info with iat data
Race_IAT <- merge(Race_IAT, state_info, 
                  by = "state", 
                  all = TRUE) %>% 
  rename(state_abr = state)

Race_IAT <- Race_IAT %>% 
  rename(state = state.name)

race_grouped_bystate_year <- Race_IAT %>% 
  group_by(state, year) %>% 
  summarise(value = mean(Implicit, na.rm = TRUE)) %>% 
  select(state, 
         value,
         year)

### Get lat & long info -----

# this "states" dataframe has the lat & long info needed for mapping.
states <- st_as_sf(map('state', plot = TRUE, fill = TRUE))
# states <- map_data("state")
states <- states %>% 
  rename(state = ID)

# join IAT + lowercase names to df that has lat & long
race_grouped_bystate_year <- inner_join(race_grouped_bystate_year, 
                                   states, 
                                   by = "state") 
race_grouped_bystate_year <- st_as_sf(race_grouped_bystate_year)


# use for loop to plot all maps

for (year_map in seq(2002,2021)) {
  map <- ggplot() + geom_sf(data = race_grouped_bystate_year |> filter(year == year_map), 
                            aes(fill = value), 
                            color = "white")+
    scale_fill_viridis_c(option = "D") +
    theme(legend.position = "bottom") +
    labs(title = paste0("Implicit Race IAT
       Scores: by State ", year_map))
  map
  ggsave(path = figures_wd, filename = paste0(year_map,"race_map.png"))
}

library(gganimate)

p <- race_grouped_bystate_year %>%
  #filter(Date=="2020-03-30") %>% # Commented it out so it won't run
  arrange(year) %>%
  ggplot(aes(fill=value)) +
  geom_sf(color="white", size=.1) +
  coord_sf(crs=st_crs(3857), ylim = c(-7842319, 12123480), expand = FALSE) +
  scale_fill_viridis_c(option = "D") +
  theme(legend.position="bottom") +
  labs(title="Arab IAT", tag="{current_frame}") +
  theme(legend.position=c(.15,-.09), legend.title=element_text(hjust=.5), plot.title=element_text(size=rel(1.5), family="sans", face="bold"), plot.subtitle=element_text(color="#5e5855"), plot.caption=element_text(color="#867e7a"), plot.tag=element_text(hjust=0.5, color="#5e5855"), plot.tag.position=c(0.5, 0.16), panel.background=element_rect(fill="#aad3df", color=NA)) +
  transition_manual(year)
guides(fill = guide_colorbar(barwidth = 20, barheight = 1.0)) 

animate(p, width=1080, height=755, renderer=file_renderer(dir="anim_img/"))

## # ggplot with state labels -----

# Use state_info to add state abbreviations to be used for labelling
state_info$region <- state_info$state.name
race_grouped_bystate <- merge(race_grouped_bystate, state_info, by = "region")

# Create dataframe of labels
statelabels <- aggregate(cbind(long, lat) ~ state, data = race_grouped_bystate, FUN = function(x) mean(range(x)))

# Some state labels aren't in good positions; can change here 
# View(statelabels)
statelabels[12, c(2:3)] <- c(-114.5, 43.5)  # alter idaho's coordinates
statelabels[17, c(2:3)] <- c(-92.5, 31.75)  # alter louisiana's coordinates
statelabels[21, c(2:3)] <- c(-84.5, 42.75)  # alter michigan's coordinates
statelabels[9, c(2, 3)] <- c(-81.5, 28.75)  # alter florida's angle and coordinates
statelabels[44, c(2, 3)] <- c(-79, 37)      # alter virginia's angle and coordinates
statelabels[45, c(2, 3)] <- c(-72.87, 45.7) # vermont
statelabels[29, c(2, 3)] <- c(-71.64, 43.5) # nh
statelabels[18, c(2, 3)] <- c(-70, 42.5)    # ma
statelabels[32, c(2, 3)] <- c(-116.5, 40)   # nevada 
statelabels[25, c(2, 3)] <- c(-109, 47)     # montana
statelabels[35, c(2, 3)] <- c(-97.5, 35.5)  # oklahoma
statelabels[22, c(2, 3)] <- c(-94, 47)      # minnesota
statelabels[38, c(2, 3)] <- c(-71, 41.3)    # ri
statelabels[30, c(2, 3)] <- c(-73.22, 40.15)    # nj
statelabels[8, c(2, 3)] <- c(-74.42, 38.9)    # de
statelabels[19, c(2, 3)] <- c(-74.2, 38)    # md
statelabels[7, c(2, 3)] <- c(-74.2, 37)    # dc
statelabels[26, c(2, 3)] <- c(-79.9, 35.6)    # nc
statelabels[44, c(2, 3)] <- c(-79, 37.5)    # va
statelabels[16, c(2, 3)] <- c(-85.68584, 37.5)    # ky
statelabels[4, c(2, 3)] <- c(-120.25830, 37.27950)    # ca

ggplot() + geom_polygon(data = race_grouped_bystate, 
                        aes(x = long, y = lat, group = group, fill = value), 
                        color = "white") +
  theme(legend.position = "bottom") +
  guides(fill = guide_colorbar(barwidth = 20, barheight = 1.0)) +
  coord_map("albers",  at0 = 45.5, lat1 = 29.5) +
  geom_text(data = statelabels, aes(long, lat, label = state), size = 4.0) 

## # ggplot with value labels -----

# Add IAT values to labels coordinates.
race_grouped_bystate2 <- Race_IAT %>% 
  group_by(state.name) %>% 
  summarize(value = mean(Implicit, na.rm = TRUE)) %>% 
  select(region = state.name, 
         value)

valuelabels_bystate <- merge(state_info, race_grouped_bystate2, 
                             by = "region", 
                             all = TRUE)
valuelabels_bystate <- valuelabels_bystate %>% select(state, state.name, value)
valuelabels_bystate <- merge(valuelabels_bystate, statelabels, 
                             by = "state",
                             all = TRUE)

valuelabels_bystate$value <- round(valuelabels_bystate$value, 2) # round for labelling map
valuelabels_bystate <- na.omit(valuelabels_bystate)

# remove leading 0s from values to take up less space on map
library(weights)
valuelabels_bystate$value <- rd(valuelabels_bystate$value) 

# change variable name to one I'd prefer to print on ggplot image
valuelabels_bystate$`IAT score` <- valuelabels_bystate$value

ggplot() + geom_polygon(data = race_grouped_bystate, 
                        aes(x = long, y = lat, group = group, fill = value), 
                        color = "white") +
  labs(fill='IAT score') +
  theme_void() +
  theme(legend.position = "bottom") +
  guides(fill = guide_colorbar(barwidth = 20, barheight = 1.0)) +
  coord_map("albers",  at0 = 45.5, lat1 = 29.5) +
  geom_text(data = valuelabels_bystate, 
            aes(long, lat, label = value), 
            size = 4.0) 

ggsave("raceiat_bystate_valuelabels.png", width = 8, height = 5, units = c("in"), dpi = 300)

# Use this to keep latitude & longtitude lines but remove axis titles and text  
#        axis.text.x = element_blank(),
#        axis.text.y = element_blank(),
#        axis.ticks = element_blank(),
#        axis.title.y = element_blank(),
#       axis.title.x = element_blank())


### References -----

# labelling chloropleths in ggplot from https://trinkerrstuff.wordpress.com/2013/07/05/ggplot2-chloropleth-of-supreme-court-decisions-an-tutorial/
