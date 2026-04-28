# 4.	Crash severity by hour of the day

# Loading the required libraries 
library(tidyverse)

# Reading the cleaned CSV file
df <- read_csv("CrashData_clean.csv", na = c("", "NA"))

# Making sure Crash_Hour is a number (0–23) and Crash_Severity to ordered factor
df <- df %>%
  mutate(
    Crash_Hour     = as.integer(Crash_Hour),
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
    )
  )

# Filtering out any rows with missing hour or missing severity
df2 <- df %>%
  filter(!is.na(Crash_Hour), !is.na(Crash_Severity)) %>%
  # Keep only valid hours 0–23
  filter(Crash_Hour >= 0, Crash_Hour <= 23)

# Plotting the graph
ggplot(df2, aes(x = Crash_Hour, fill = Crash_Severity)) +
  geom_bar(position = "fill", color = "black", width = 0.8) +
  scale_fill_manual(
    values = c(
      "Fatal"               = "#E26C6C",  # dark red
      "Hospitalisation"     = "#FFA45D",  # orange‐red
      "Medical treatment"   = "#FFD85C",  # golden yellow
      "Minor injury"        = "#7FCF83",  # green
      "Property damage only"= "#6CA6FF"   # blue
    ),
    name = "Severity" #label
  ) +
  #Ensures y axis shows percentages
  scale_y_continuous(
    labels = scales::percent_format(accuracy = 1),
    expand = expansion(mult = c(0, 0))
  ) +
  # Showing every hour from 0 to 23 on the x axis
  scale_x_continuous(
    breaks = 0:23
  ) +
  #adding labels
  labs(
    title    = "Crash Severity Proportions by Hour of Day",
    subtitle = paste0(
      "Each bar shows 100% of crashes that occurred during that hour,\n",
      "Stacked by Severity: Fatal → Hospitalisation → Medical Treatment → Minor Injury → Property Damage Only"
    ),
    x        = "Hour of Day (0 = midnight, 23 = 11 PM)",
    y        = "Proportion of Crashes (100% stacked)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title       = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle    = element_text(size = 11, hjust = 0.5),
    axis.text.x      = element_text(size = 10),
    axis.text.y      = element_text(size = 10),
    legend.position  = "right",
    legend.title     = element_text(face = "bold"),
    legend.text      = element_text(size = 10)
  )
