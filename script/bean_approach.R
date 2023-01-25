
# =============================================================================#
# load libraries and functions
# =============================================================================#
library(ranger)
library(extRemes)
library(tidyverse)
library(matrixStats)
library(future)
library(future.apply)

 # Source the R file
source(file = "R/tree_gev_fitting.R")



# ===========================================================================#
# load data and preprocess
# ===========================================================================#
df <- read.csv("data-raw/data.csv") # Read the data from data.csv file


df <- df %>%
  dplyr::mutate(
    logSNWD = log(maxv_SNWD),
    logPPTWT = log(PPTWT)
  ) %>%
  dplyr::rename(
    SMONTH = snow_month_SNWD,
    D2C = dist2coast,
    ELEV = ELEVATION,
    RATIO = maxRatio
  )


# Filter stations with annual max more than 30
id <- df %>%
  count(ID) %>%
  filter(n >= 30)

df <- df %>%
  filter(ID %in% id$ID)


# Convert dataframe of data into list by ID
ls_df <- df %>%
  dplyr::mutate(ID = factor(ID, levels = unique(ID))) %>%
  dplyr::group_split(ID) %>%
  stats::setNames(., unique(df$ID))




# ===========================================================================#
# Fit different decision trees and get GEV parameters
# ===========================================================================#


tictoc::tic()

## Run the analysis in parallel on the local computer
future::plan("multisession", workers = 14)


converted_load_para_mean <- do.call(rbind,
                                    future_lapply(ls_df,
    FUN = tree_gev_fitting,
    n_trees = 1000,
    mean_para = TRUE,
    future.scheduling = 2,
    future.seed = TRUE,
    future.packages = c("extRemes", "tidyverse", "matrixStats", "ranger")
  )
)



converted_load_para_q_75 <- do.call(rbind,
  future_lapply(ls_df,
    FUN = tree_gev_fitting,
    n_trees = 1000,
    probs = 0.75,
    mean_para = TRUE,
    future.scheduling = 2,
    future.seed = TRUE,
    future.globals = TRUE,
    future.packages = c("extRemes", "tidyverse", "matrixStats", "ranger")
  )
)



tictoc::toc()


## Shut down parallel workers
future::plan("sequential")



# append station id
ID <- rownames(converted_load_para_mean)
converted_load_para_mean <- cbind(ID, converted_load_para_mean)


# append station id
ID <- rownames(converted_load_para_q_75)
converted_load_para_q_75 <- cbind(ID, converted_load_para_q_75)



#save output
save(converted_load_para_mean, file = "data-raw/RObject/converted_load_para_mean.RData")
save(converted_load_para_q_75, file = "data-raw/RObject/converted_load_para_q_75.RData")





