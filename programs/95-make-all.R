#######################################################################
# Master script
#######################################################################

## Clear out existing environment
rm(list = ls()) 

## Set master directory where all sub-directories are located
Skin_Implicit_Harvard <- "~/Dropbox/Research/My Research Data and Ideas/ProjectImplicit/skin_tone_iat/Skin IAT.public.2004-2021.csv"

Race_Implicit_Harvard <- "~/Dropbox/Research/My Research Data and Ideas/ProjectImplicit/race_iat/"

### GiT directories
git_mdir <- "~/Documents/GiT/Project-Implicit-Data"
datasets <- paste0(git_mdir,"/data/datasets")
raw <- paste0(git_mdir,"/data/raw")
tables_wd <- paste0(git_mdir,"/output/tables")
figures_wd <- paste0(git_mdir,"/output/figures")
programs <- paste0(git_mdir,"/programs")

### run do files and scripts

source(file.path(programs,"01-packages-wds.r")) # set up package
source(file.path(programs,"02-clean-skin-implicit-project.R")) # clean skin iat
source(file.path(programs,"03-census-data.R")) # open sav file for census data
source(file.path(programs,"04-clean-race-implicit-project.R")) # clean race iat


### summary stats

# Send Message

textme(message = "👹 Back to work! You're not paid to run around and drink ☕ all day!")