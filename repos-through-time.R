library("ggplot2")
library("readr")
library("dplyr")
library("incidence")

##### Define Carpentries Colors ####
carpentries_blue <- "#071159"
carpentries_red <- "#D45214"
carpentries_orange <- "#F0A202"
carpentries_light_blue <- "#3D7BBA"
two_colors <- c(carpentries_blue, carpentries_red)
three_colors <- c(carpentries_blue, carpentries_red, carpentries_orange)
four_colors <- c(carpentries_blue, carpentries_red, carpentries_orange, carpentries_light_blue)
five_colors <- c(carpentries_blue, carpentries_red, carpentries_orange, carpentries_light_blue, "grey14")


repos <- read_csv("repos.csv", col_types = cols(
  carpentry = col_character(),
  repo = col_character(),
  created = col_datetime(format = ""),
  stars = col_double(),
  branch = col_character(),
  issues = col_double()
))



p <- repos |>
  filter(!carpentry %in% c("carpentries", "carpentrieslab")) |>
  mutate(carpentry = case_when(
    carpentry == "carpentries-incubator" ~ "Incubator",
    carpentry == "datacarpentry" ~ "Data",
    carpentry == "swcarpentry" ~ "Software",
    carpentry == "LibraryCarpentry" ~ "Library",
  )) |>
  mutate(carpentry = factor(carpentry, levels = c("Software", "Data", "Library", "Incubator"))) |>
  mutate(created = as.Date(created)) |>
  with(incidence(created, interval = "quarter", groups = carpentry)) |>
  cumulate() |>
  plot(border = "black", alpha = 1) +
  scale_fill_manual(values = four_colors) +
  scale_x_date(date_labels = "%Y-Q1") +
  ylim(c(0, 150)) +
  labs(
    y = "Lessons",
    x = "Quarter",
    fill = "Carpentry"
  ) +
  theme_bw(base_size = 24, base_family = "Droid Sans") %+replace%
    theme(
      axis.text.x = element_text(angle = 0, vjust = 0.5),
      axis.title = element_text(face = "bold", vjust = 0.5, family = "Open Sans"),
      strip.text = element_text(face = "bold"),
      strip.background = element_blank(),
      panel.grid.major.y = element_line(color = "grey30", size = .25),
      panel.grid.major.x = element_line(linetype = 2, size = 0.25),
      panel.grid.minor = element_blank(),
      legend.position = "top",
      legend.title = element_blank()
    )

ggsave("lesson-growth.png", p)

