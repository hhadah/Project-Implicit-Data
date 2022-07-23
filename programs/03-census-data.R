# This a script to 
# clean the Harvard's
# Implicit Project
# race IAT
# Data

# Date: July 22nd, 2022

### Open Implicit Data

censusdata <- read_sav(file.path(raw,"census_data_county_level.sav"))

# save data

write_csv(censusdata, file.path(datasets,"census_data_county_level.csv"))
