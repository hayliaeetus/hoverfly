# Loading and sorting ####
library(tidyverse)
library(occuR)
source("hover_exploratory.R")

site_data <- hover_site[,1:4]
# Include only the three species of interest
visit_data <- hover_visits[,c(2:4, 99, 121, 260)]
names(visit_data) <- c("site", "occasion", "visit", "balt", "corol", "script")
# Get no. 1s in each row = list length
lists <- hover_visits[,8:292]
list_length <- as.vector(rowSums(lists))
visit_data$list_length <- list_length
visit_data_balt <- visit_data[,c(1:4, 7)]
names(visit_data_balt)[4] <- "obs"
visit_data_corol <- visit_data[,c(1:3, 5, 7)]
names(visit_data_corol)[4] <- "obs"
visit_data_script <- visit_data[,c(1:3, 6:7)]
names(visit_data_script)[4] <- "obs"


# Frequencies of each species
library("epiDisplay")
hoverXYrecorder$species <- as.factor(hoverXYrecorder$species)
specs <- droplevels(hoverXYrecorder[hoverXYrecorder$species %in% 
                                      c("Episyrphus balteatus",
                                        "Sphaerophoria scripta",
                                        "Eristalis tenax"), ])
tab1(specs$species,
     sort.group = "decreasing",
     cum.percent = TRUE,
     col = c("chocolate",
             "brown1",
             "brown3"),
     main = "Number of visits where each species was recorded")

tab1(hoverXYrecorder$species,
     sort.group = "decreasing",
     cum.percent = TRUE,
     col = c("chocolate",
             "brown1",
             "brown3"),
     main = "Number of visits where each species was recorded")
