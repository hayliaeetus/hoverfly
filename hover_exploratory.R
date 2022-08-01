# Load in data
hover <- readRDS("hover_1K.Rds")
hover_visits <- hover[["visit_data"]]
hover_recorder <- hover[["recorder_data"]]
hover_site <- hover[["site_data"]]

# Load in other datasets provided in case they are of use
# Simple polygon of UK
UKpoly <- readRDS("uk_simple.Rds")
plot(UKpoly)
# Info on who has recorded which species
hoverXYrecorder <- read.csv("hoverflyXYrecorder.csv")
# Identification difficulty ratings
phtoIDgrades <- read.csv("photoIDgrades.csv")


# Find which species have the most recorded sightings
a <- colSums(hover_visits==1)
b <- sort(a, decreasing = TRUE)
b[4:8]
