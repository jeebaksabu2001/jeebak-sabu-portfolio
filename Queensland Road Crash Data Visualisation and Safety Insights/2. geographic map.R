# 2.	Map visualization to illustrate the geographic distribution of road crashes across 

#Note: Since it is a geographic map it takes time to load

# Loading the required libraries 
library(tidyverse)
library(ggmap)

# Using the Google API as it is needed for this visualization

register_google(key = Sys.getenv("GOOGLE_MAPS_API_KEY"))

# Reading the cleaned CSV file
df <- read_csv("CrashData_clean.csv", na = c("", "NA")) %>%
  filter(
    !is.na(Crash_Longitude),
    !is.na(Crash_Latitude)
  ) %>%
  mutate(
    Crash_Longitude = as.numeric(Crash_Longitude),
    Crash_Latitude  = as.numeric(Crash_Latitude)
  ) %>%
  # Keeping the boundaries such that it is Queensland
  filter(
    Crash_Longitude >= 138,  
    Crash_Longitude <= 154,  
    Crash_Latitude  >= -29,  
    Crash_Latitude  <= -9    
  )

# Defining center and fetching the Google Roadmap of QLD
qld_center <- c(lon = 148, lat = -23)

qld_base <- get_map(
  location = qld_center,
  zoom     = 6,
  maptype  = "roadmap",
  source   = "google"
)

# Plotting the map
ggmap(qld_base) +
  stat_density_2d(
    data       = df,
    aes(
      x    = Crash_Longitude,
      y    = Crash_Latitude,
      fill = ..level..,
    ),
    geom       = "polygon",
    contour    = TRUE,
    bins       = 6,   
    adjust     = 1.2    
  ) +
  scale_fill_gradient(
    low  = alpha("#FFCC00", 1),     
    high = alpha("#CC0000", 1),    
    name = "Crash Density"
  ) +
  scale_alpha(range = c(1, 3), guide = FALSE) +
  # Draw all crash points on top
  geom_point(
    data  = df,
    aes(x = Crash_Longitude, y = Crash_Latitude),
    color = alpha("red",2),
    alpha = 0.1,  
    size  = 0.2          # small dot size
  ) +
  labs(
    title    = "Road Crash Density in Queensland (All Points Shown)",
    subtitle = "Yellow→Red heat = increasing concentration; red dots = each crash",
    x        = "Longitude",
    y        = "Latitude"
  ) +
  theme(
    plot.title     = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle  = element_text(size = 12, hjust = 0.5),
    legend.position = "right"
  )


