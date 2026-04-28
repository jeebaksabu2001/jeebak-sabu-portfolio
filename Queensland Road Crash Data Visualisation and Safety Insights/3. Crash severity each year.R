# 3.	Crash severity each year

# Loading the required libraries 
library(tidyverse)  

# Reading the cleaned CSV file
df <- read_csv("CrashData_clean.csv", na = c("", "NA"))

# Making sure Crash_Year is numeric and Crash_Severity is an ordered factor
df <- df %>%
  mutate(
    Crash_Year     = as.integer(Crash_Year),
    Crash_Severity = factor(
      Crash_Severity,
      levels = c(
        "Fatal",
        "Hospitalisation",
        "Medical treatment",
        "Minor Injury",
        "Property damage only"
      ),
      ordered = TRUE
    )
  )

# Grouping by year and severity and counting how many crashes fall into each group
yearly_severity_raw <- df %>%
  filter(!is.na(Crash_Year), !is.na(Crash_Severity)) %>%
  group_by(Crash_Year, Crash_Severity) %>%
  summarise(Count = n(), .groups = "drop")

# “Complete” the missing Year and Severity combos with Count = 0
yearly_severity <- yearly_severity_raw %>%
  complete(
    Crash_Year,
    Crash_Severity,
    fill = list(Count = 0)
  ) %>%
  arrange(Crash_Year, Crash_Severity)

# Finding the biggest crash count in the table and rounding it up such that it numbers to the nearest thousand
y_max <- ceiling(max(yearly_severity$Count, na.rm = TRUE) / 1000) * 1000

# Plottin the graph
ggplot(yearly_severity, aes(x = Crash_Year, y = Count, color = Crash_Severity)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_color_manual(
    values = c(
      "Fatal"               = "#CC0000",   # dark red
      "Hospitalisation"     = "#FF6633",   # orange‐red
      "Medical treatment"   = "#FFCC33",   # golden yellow 
      "Minor Injury"        = "#66CC66",   # green
      "Property damage only"= "#3366CC"    # blue
    ),
    name = "Severity"
  ) +
  #adding labels
  labs(
    title    = "Annual Trend of Crash Severity in Queensland",
    subtitle = "Counts of Fatal, Hospitalisation, Medical Treatment,\nMinor Injury, and Property Damage–Only Crashes by Year",
    x        = "Crash Year",
    y        = "Number of Crashes"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title       = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle    = element_text(size = 12, hjust = 0.5),
    axis.text.x      = element_text(angle = 45, hjust = 1),
    legend.position  = "top",
    legend.title     = element_text(face = "bold"),
    legend.text      = element_text(size = 11)
  ) +
  # showing the x axis every 2 years so it's not clutered
  scale_x_continuous(
    breaks = seq(
      min(yearly_severity$Crash_Year, na.rm = TRUE),
      max(yearly_severity$Crash_Year, na.rm = TRUE),
      by    = 2
    )
  ) +
  #showing the y axis from 1,1000,2000... to y_max and limit to y_max
  scale_y_continuous(
    breaks = seq(0, y_max, by = 1000),  
    limits = c(0, y_max)
  )
