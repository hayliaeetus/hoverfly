# Loading and sorting ####
library(tidyverse)
library(occuR)
source("hover_exploratory.R")

site_data <- hover_site[,1:4]
rm(hover_site)
# Include only the three species of interest
visit_data <- hover_visits[,c(2:4, 99, 113, 260)]
names(visit_data) <- c("site", "occasion", "visit", "balt", "tenax", "script")
# Get no. 1s in each row = list length
lists <- hover_visits[,8:292]
list_length <- as.vector(rowSums(lists))
visit_data$list_length <- list_length

# Separate visit datasets for each species
visit_data_balt <- visit_data[,c(1:4, 7)]
names(visit_data_balt)[4] <- "obs"
visit_data_tenax <- visit_data[,c(1:3, 5, 7)]
names(visit_data_tenax)[4] <- "obs"
visit_data_script <- visit_data[,c(1:3, 6:7)]
names(visit_data_script)[4] <- "obs"

# Frequencies of each species
library("epiDisplay")
hoverXYrecorder <- read.csv("hoverflyXYrecorder.csv")
hoverXYrecorder$species <- as.factor(hoverXYrecorder[,1])
# Keep only data for species of interest
specs <- droplevels(hoverXYrecorder[hoverXYrecorder$species %in% 
                                      c("Episyrphus balteatus",
                                        "Sphaerophoria scripta",
                                        "Eristalis tenax"), ])
# Plot frequencies of each species
tab1(specs$species,
     sort.group = "decreasing",
     cum.percent = TRUE,
     col = c("chocolate",
             "brown1",
             "brown3"),
     main = "Number of visits where each species was recorded")