# This a script to 
# clean the Harvard's
# Implicit Project
# Race IAT Data

# Date: July 22nd, 2022

### Open Race IAT Data
# temp = list.files(file.path(Race_Implicit_Harvard), pattern = "*.sav")
# for (i in 1:length(temp)) assign(temp[i], read_sav(paste0(Race_Implicit_Harvard, temp[i])))
# 
# write_csv(`Race IAT.public.2016.sav`, file.path(Race_Implicit_Harvard,"Race_IAT_2016.csv"))
# write_csv(`Race_IAT.public.2017.sav`, file.path(Race_Implicit_Harvard,"Race_IAT_2017.csv"))
# write_csv(`Race_IAT.public.2018.sav`, file.path(Race_Implicit_Harvard,"Race_IAT_2018.csv"))
# write_csv(`Race_IAT.public.2019.sav`, file.path(Race_Implicit_Harvard,"Race_IAT_2019.csv"))
# write_csv(`Race.IAT.public.2020.sav`, file.path(Race_Implicit_Harvard,"Race_IAT_2020.csv"))
# write_csv(`Race IAT.public.2021.sav`, file.path(Race_Implicit_Harvard,"Race_IAT_2021.csv"))
# 
# rm(list=c(ls()[grepl("Race IAT", ls())]))
# rm(list=c(ls()[grepl("Race_IAT.", ls())]))
# rm(list=c(ls()[grepl("Race.IAT.", ls())]))

temp = list.files(file.path(Race_Implicit_Harvard), pattern = "*.csv")
for (i in 1:length(temp)) assign(temp[i], read_csv(paste0(Race_Implicit_Harvard, temp[i])))

# temp = list.files(file.path(Race_Implicit_Harvard), pattern = "*.sav")
# for (i in 1:length(temp)) assign(temp[i], read_sav(paste0(Race_Implicit_Harvard, temp[i])))

# append the three datasets
`Race IAT.public.2010.csv`$"MSANo"  <-  as.numeric(`Race IAT.public.2010.csv`$"MSANo")
`Race IAT.public.2012.csv`$"MSANo"  <-  as.numeric(`Race IAT.public.2012.csv`$"MSANo")
`Race IAT.public.2014.csv`$"MSANo"  <-  as.numeric(`Race IAT.public.2014.csv`$"MSANo")
Race_IAT_2016.csv$"date"   <-  as.character(Race_IAT_2016.csv$"date")
Race_IAT_2016.csv$"MSANo"  <-  as.numeric(Race_IAT_2016.csv$"MSANo")
Race_IAT_2016.csv$"countrycit"  <-  as.character(Race_IAT_2016.csv$"countrycit")
Race_IAT_2016.csv$"countryres"  <-  as.character(Race_IAT_2016.csv$"countryres")

Race_IAT_2017.csv$"date"   <-  as.character(Race_IAT_2017.csv$"date")
Race_IAT_2017.csv$"MSANo"  <-  as.numeric(Race_IAT_2017.csv$"MSANo")

Race_IAT_2018.csv$"date"   <-  as.character(Race_IAT_2018.csv$"date")
Race_IAT_2018.csv$"MSANo"  <-  as.numeric(Race_IAT_2018.csv$"MSANo")
Race_IAT_2018.csv$"iatevaluations001"  <-  as.character(Race_IAT_2018.csv$"iatevaluations001")
Race_IAT_2018.csv$"iatevaluations002"  <-  as.character(Race_IAT_2018.csv$"iatevaluations002")
Race_IAT_2018.csv$"iatevaluations003"  <-  as.character(Race_IAT_2018.csv$"iatevaluations003")

Race_IAT_2019.csv$"date"   <-  as.character(Race_IAT_2019.csv$"date")
Race_IAT_2019.csv$"MSANo"  <-  as.numeric(Race_IAT_2019.csv$"MSANo")
Race_IAT_2019.csv$"iatevaluations001"  <-  as.character(Race_IAT_2019.csv$"iatevaluations001")
Race_IAT_2019.csv$"iatevaluations002"  <-  as.character(Race_IAT_2019.csv$"iatevaluations002")
Race_IAT_2019.csv$"iatevaluations003"  <-  as.character(Race_IAT_2019.csv$"iatevaluations003")
Race_IAT_2019.csv$"raceombmulti"  <-  as.character(Race_IAT_2019.csv$"raceombmulti")

Race_IAT_2020.csv$"date"   <-  as.character(Race_IAT_2020.csv$"date")
Race_IAT_2020.csv$"MSANo"  <-  as.numeric(Race_IAT_2020.csv$"MSANo")
Race_IAT_2020.csv$"iatevaluations001"  <-  as.character(Race_IAT_2020.csv$"iatevaluations001")
Race_IAT_2020.csv$"iatevaluations002"  <-  as.character(Race_IAT_2020.csv$"iatevaluations002")
Race_IAT_2020.csv$"iatevaluations003"  <-  as.character(Race_IAT_2020.csv$"iatevaluations003")
Race_IAT_2020.csv$"raceombmulti"  <-  as.character(Race_IAT_2020.csv$"raceombmulti")

Race_IAT_2021.csv$"date"   <-  as.character(Race_IAT_2021.csv$"date")
Race_IAT_2021.csv$"MSANo"  <-  as.numeric(Race_IAT_2021.csv$"MSANo")
Race_IAT_2021.csv$"iatevaluations001"  <-  as.character(Race_IAT_2021.csv$"iatevaluations001")
Race_IAT_2021.csv$"iatevaluations002"  <-  as.character(Race_IAT_2021.csv$"iatevaluations002")
Race_IAT_2021.csv$"iatevaluations003"  <-  as.character(Race_IAT_2021.csv$"iatevaluations003")
Race_IAT_2021.csv$"raceombmulti"  <-  as.character(Race_IAT_2021.csv$"raceombmulti")
Race_IAT_2021.csv$"CountyNo"  <-  as.character(Race_IAT_2021.csv$"CountyNo")

Race_IAT <- dplyr::bind_rows(`Race IAT.public.2002-2003.csv`, `Race IAT.public.2004.csv`)
rm(`Race IAT.public.2002-2003.csv`, `Race IAT.public.2004.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2005.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2006.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2007.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2008.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2009.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2010.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2011.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2012.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2013.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2014.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, `Race IAT.public.2015.csv`)
Race_IAT <- dplyr::bind_rows(Race_IAT, Race_IAT_2016.csv)
rm(Race_IAT_2016.csv)
rm(list=c(ls()[grepl("Race IAT", ls())]))
Race_IAT <- dplyr::bind_rows(Race_IAT, Race_IAT_2017.csv)
rm(Race_IAT_2017.csv)
Race_IAT <- dplyr::bind_rows(Race_IAT, Race_IAT_2018.csv)
rm(Race_IAT_2018.csv)
Race_IAT <- dplyr::bind_rows(Race_IAT, Race_IAT_2019.csv)
rm(Race_IAT_2019.csv)
Race_IAT <- dplyr::bind_rows(Race_IAT, Race_IAT_2020.csv)
rm(Race_IAT_2020.csv)
Race_IAT <- dplyr::bind_rows(Race_IAT, Race_IAT_2021.csv)
rm(Race_IAT_2021.csv)


# Race_IAT_2 <- dplyr::bind_rows(Race_IAT_3, Race_IAT_4)
# rm(Race_IAT_3, Race_IAT_4)

# Race_IAT <- dplyr::bind_rows(Race_IAT_2, Race_IAT)
# rm(Race_IAT_2)

# keep some variables
Race_IAT <- Race_IAT %>%
  select(session_id, D_biep.White_Good_all, D_biep.White_Good_36,
         att_7, D_biep.White_Good_47, 
         raceomb, sex, politicalid, 
         politicalid_7, age, year, num, month,
         religion, countrycit, religionid,
         MSANo, CountyNo, MSAName, STATE,
         pct_300, PCT_error_3467, 
         session_status, edu_14,
         ethnicityomb, ethnic, raceombmulti) %>%
  mutate(Implicit=D_biep.White_Good_all, # create implicit prejudice var
         Explicit=att_7, # create explicit prejudice var
         
         # create an error variable to remove
         # participants with high rates (more
         # than 30%) or too many fast trials (
         # more than 10%)
         Error = case_when(pct_300 <= 10 & PCT_error_3467<= 30 ~ 'No',
                           pct_300 >  10 | PCT_error_3467 > 30 ~ 'Yes'),
         # recode sex variable into female variable
         Female = case_when(sex == "f" ~ 1,
                            sex == "m" ~ 0)) %>% 
  filter(Error == 'No')

Race_IAT <- Race_IAT %>% 
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

write_csv(Race_IAT, file.path(datasets,"Race_IAT_Clean.csv"))
