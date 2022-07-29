# This a script to downlaod
# packages and set working
# directories

# author: Hussain Hadah

# date: July 22nd, 2022

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tictoc, parallel, pbapply, future, 
               future.apply, furrr, RhpcBLASctl, memoise, 
               here, foreign, mfx, tidyverse, hrbrthemes, 
               estimatr, ivreg, fixest, sandwich, lmtest, 
               margins, vtable, broom, modelsummary, 
               stargazer, fastDummies, recipes, dummy, 
               gplots, haven, huxtable, kableExtra, 
               gmodels, survey, gtsummary, data.table, 
               tidyfast, dtplyr, microbenchmark, ggpubr, 
               tibble, viridis, wesanderson, censReg, 
               rstatix, srvyr, formatR, sysfonts, 
               showtextdb, showtext, thematic, 
               sampleSelection, textme, paletteer, 
               wesanderson, patchwork, RStata, car,
               #textme, lodown, 
               BiocManager, maps, sf, Polychrome, cdlTools)

options("RStata.StataPath" = "/Applications/Stata/StataSE.app/Contents/MacOS/stata-se")
options("RStata.StataVersion" = 17)
            
# devtools::install_github("thomasp85/patchwork")
# devtools::install_github("ajdamico/lodown")
## My preferred ggplot2 plotting theme (optional)
## https://github.com/hrbrmstr/hrbrthemes
# scale_fill_ipsum()
# scale_color_ipsum()
font_add_google("Fira Sans", "firasans")
font_add_google("Fira Code", "firasans")

showtext_auto()

theme_customs <- theme(
  text = element_text(family = 'firasans', size = 16),
  plot.title.position = 'plot',
  plot.title = element_text(
    face = 'bold', 
    colour = "black",
    #colour = thematic::okabe_ito(8)[6],
    margin = margin(t = 2, r = 0, b = 7, l = 0, unit = "mm")
  ),
)

colors <-  thematic::okabe_ito(5)

# theme_set(theme_minimal() + theme_customs)
theme_set(hrbrthemes::theme_ipsum() + theme_customs)
## Set master directory where all sub-directories are located
# mdir <- "/Users/hhadah/Dropbox/Research/My Research Data and Ideas/"
# mdir <- "C:\\Users\\16023\\Dropbox\\Research\\My Research Data and Ideas\\Identification_Paper"
## Set working directories
# workdir  <- paste0(mdir,"/Data/Datasets")
# rawdatadir  <- paste0(mdir,"/Data/Raw")
# tables_plots_dir <- paste0(mdir, "/Users/hhadah/Documents/GiT/Depression_Idea/outputs")

## Set working directory

# COLOR PALLETES
library(paletteer) 
# paletteer_d("awtools::a_palette")
# paletteer_d("suffrager::CarolMan")

### COLOR BLIND PALLETES
paletteer_d("colorblindr::OkabeIto")
paletteer_d("colorblindr::OkabeIto_black")
paletteer_d("colorBlindness::paletteMartin")
paletteer_d("colorBlindness::Blue2DarkRed18Steps")
paletteer_d("colorBlindness::SteppedSequential5Steps")
paletteer_d("colorBlindness::PairedColor12Steps")
paletteer_d("colorBlindness::ModifiedSpectralScheme11Steps")
colorBlindness <- paletteer_d("colorBlindness::Blue2Orange12Steps")
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# scale_colour_paletteer_d("colorBlindness::ModifiedSpectralScheme11Steps", dynamic = FALSE)
# To use for fills, add
scale_fill_manual(values="colorBlindness::Blue2Orange12Steps")
scale_color_paletteer_d("nord::aurora")
scale_color_paletteer_d("colorBlindness::Blue2Orange12Steps")

# To use for line and point colors, add
scale_colour_manual(values="colorBlindness::Blue2Orange12Steps")
