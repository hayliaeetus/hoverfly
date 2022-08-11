# Load in data
hover <- readRDS("hover_1K.Rds")
hover_visits <- hover[["visit_data"]] # Visit data
hover_site <- hover[["site_data"]] # Site data

# Simple polygon of UK
UKpoly <- readRDS("uk_simple.Rds")
plot(UKpoly)


# Find which species have the most recorded sightings
a <- colSums(hover_visits==1)
b <- sort(a, decreasing = TRUE)
b[4:8]
