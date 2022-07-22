#######################################################################
# Master script
#######################################################################

## Clear out existing environment
rm(list = ls()) 

## Set master directory where all sub-directories are located
Implicity_Harvard <- "~/Dropbox/Research/My Research Data and Ideas/ProjectImplicit/skin_tone_iat/Skin IAT.public.2004-2021.csv"

### GiT directories
git_mdir <- "~/Documents/GiT/Project-Implicit-Data/"
datasets <- paste0(git_mdir,"/data/datasets")
raw <- paste0(git_mdir,"/data/raw")
tables_wd <- paste0(git_mdir,"/output/tables")
figures_wd <- paste0(git_mdir,"/output/figures")
programs <- paste0(git_mdir,"/programs")

### run do files and scripts

source(file.path(programs,"01-packages-wds.r")) # set up package
source(file.path(programs,"02-clean-implicit-project.r")) # set up package


### summary stats

# Send Message

textme(message = "👹 Back to work! You're not paid to run around and drink ☕ all day!")