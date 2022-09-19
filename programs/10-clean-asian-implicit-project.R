# This a script to 
# clean the Asian's
# Implicit Project
# Race IAT Data

# Date: Sep 19th, 2022

### Open Implicit Data

Asian_IAT <- fread(Asian_Implicit_Harvard)

# filter incomplete responses
Asian_IAT <- Asian_IAT[session_status == "C"]
Asian_IAT <- as.data.frame(Asian_IAT)

# keep some variables
Asian_IAT <- Asian_IAT %>%
  select(session_id, D_biep.White_American_all, D_biep.White_American_36,
         att_7, D_biep.White_American_47, 
         raceomb, birthsex, politicalid, 
         politicalid_7, age, year, num, 
         religion, countrycit, religionid,
         MSANo, CountyNo, MSAName, STATE,
         pct_300, PCT_error_3467, 
         session_status, edu_14) %>%
  mutate(Implicit=D_biep.White_American_all, # create implicit prejudice var
         Explicit=att_7, # create explicit prejudice var
         
         # create an error variable to remove
         # participants with high rates (more
         # than 30%) or too many fast trials (
         # more than 10%)
         Error = case_when(pct_300 <= 10 & PCT_error_3467<= 30 ~ 'No',
                           pct_300 >  10 | PCT_error_3467 > 30 ~ 'Yes'),
         # recode sex variable into female variable
         Female = case_when(birthsex == 2 ~ 1,
                            birthsex == 1 ~ 0)) %>% 
  filter(Error == 'No')

Asian_IAT <- Asian_IAT %>% 
  mutate(
    # recode political ideology
    politics = ifelse(politicalid == -999, NA, politicalid),
    # recode political religiosity
    religiosity=religionid,
    # create number of iat test variable
    numiats = case_when(num == '0' ~ 1,
                        num == '1' ~ 2,
                        num == '2' ~ 3,
                        num == '3' ~ 4,
                        num == '3-5' ~ 4,
                        num == '6+' ~ 5),
    # create age groups
    Age_group = case_when(age >= 0 & age <= 20   ~ 1,
                          age >= 21 & age <= 30  ~ 2,
                          age >= 31 & age <= 40  ~ 3,
                          age >= 41 & age <= 50  ~ 4,
                          age >= 51 & age <= 60  ~ 5,
                          age >= 61 & age <= 200 ~ 6)) %>% 
  rename("state" = "STATE")

# save data

write_csv(Asian_IAT, file.path(datasets,"Asian_IAT_Clean.csv"))
