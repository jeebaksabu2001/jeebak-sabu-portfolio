# 5.	Severity distribution across different crash types

# Loading the required libraries 
library(tidyverse)

# Reading the cleaned CSV file
df <- read_csv("CrashData_clean.csv", na = c("", "NA"))

# Making sure Crash_Severity is an ordered factor and Convert Crash_Type is a factor 
df <- df %>%
  mutate(
    Crash_Severity = factor(
      Crash_Severity,
      levels = c(
        "Fatal",
        "Hospitalisation",
        "Medical treatment",
        "Minor injury",
        "Property damage only"
      ),
      ordered = TRUE
    ),
    Crash_Type = factor(Crash_Type)  
  )

# Filtering out rows which are missing missing Crash_Type or Crash_Severity
df_type <- df %>%
  filter(!is.na(Crash_Type), !is.na(Crash_Severity))

# Counting how many crashes per Crash_Type and Crash_Severity
type_severity_counts <- df_type %>%
  count(Crash_Type, Crash_Severity) %>%
  ungroup()

# Plotting the graph
ggplot(type_severity_counts, aes(
  x    = Crash_Severity,
  y    = Crash_Type,
  fill = n
)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(
    option = "plasma",
    name   = "Crash Count"
  ) +
  #labels
  labs(
    title    = "Heatmap: Crash Severity vs. Crash Type",
    subtitle = "Darker tiles indicate more crashes of that type × severity",
    x        = "Crash Severity",
    y        = "Crash Type"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title      = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle   = element_text(size = 12, hjust = 0.5),
    axis.text.x     = element_text(angle = 45, hjust = 1, size = 11),
    axis.text.y     = element_text(size = 11),
    legend.title    = element_text(face = "bold"),
    legend.text     = element_text(size = 10),
    panel.grid      = element_blank()
  )
# --------------------------------------------------
