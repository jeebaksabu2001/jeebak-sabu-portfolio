# 1. Annual Road-Crash Counts (2001 – 2023) - Time-Series Line Chart

# Loading the required libraries 
library(tidyverse)   # data‐wrangling and ggplot2
library(ggmap)       # for get_map() and ggmap()


# Reading the cleaned CSV file
df <- read_csv("CrashData_clean.csv")

# Displaying the first 10 rows to verify data loaded
print("First 10 rows of df:")
print(head(df, 10))

#Calculating Annual Crash counts
annual_counts <- df %>%
  group_by(Crash_Year) %>%
  summarise(
    Crash_Count = n(),
    .groups = "drop"
  ) %>%
  arrange(Crash_Year)

# Plotting the line graph
ggplot(annual_counts, aes(x = Crash_Year, y = Crash_Count)) +
  geom_point(color = "darkblue", size = 2) +
  geom_line(color = "steelblue", size = 0.8) +
  geom_smooth(method = "loess", se = FALSE, color = "red", linetype = "dotted") +
  labs(
    title = "Annual Road Crash Counts (Queensland)",
    x     = "Year",
    y     = "Number of Crashes"
  ) +
  scale_x_continuous(breaks = annual_counts$Crash_Year) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title  = element_text(face = "bold")
  )