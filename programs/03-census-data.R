# This a script to 
# clean the Harvard's
# Implicit Project
# race IAT
# Data

# Date: July 22nd, 2022

### Open Implicit Data

censusdata <- read_sav(file.path(raw,"census_data_county_level.sav"))

census_state_data <- read_sav(file.path(raw,"countyno_state_cbsa.2014.sav"))

# save data

write_csv(censusdata, file.path(datasets,"census_data_county_level.csv"))
write_csv(census_state_data, file.path(datasets,"countyno_state_cbsa.csv"))
