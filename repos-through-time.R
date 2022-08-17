library("ggplot2")
library("readr")
library("dplyr")
library("tidyr")
library("incidence")

##### Define Carpentries Colors ####
carpentries_blue <- "#E3E6FC"
carpentries_red <- "#F99697"
carpentries_orange <- "#40AEAD"
carpentries_light_blue <- "#D2BDF2"
buttercup <- "#FFF7F1"
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



dat <- repos |>
  filter(!carpentry %in% c("carpentries", "carpentries-lab")) |>
  mutate(carpentry = case_when(
    carpentry == "carpentries-incubator" ~ "Incubator",
    carpentry == "datacarpentry" ~ "Data",
    carpentry == "swcarpentry" ~ "Software",
    carpentry == "LibraryCarpentry" ~ "Library",
  )) |>
  mutate(created = as.Date(created)) |>
  with(incidence(created, groups = carpentry)) |>
  cumulate() |>
  as.data.frame() |>
  pivot_longer(
    cols = c("Software", "Data", "Library", "Incubator"),
    names_to = "carpentry",
    values_to = "lessons"
  ) |>
  mutate(carpentry = factor(carpentry, levels = c("Incubator", "Library", "Data", "Software")))
{
p <- dat |>
  ggplot(aes(x = dates, y = lessons, group = carpentry)) +
  geom_area(aes(fill = carpentry), color = "black") +
  scale_fill_manual(values = four_colors) +
  scale_x_date(expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 10*ceiling(nrow(repos)/10)), expand = c(0, 0)) +
  labs(
    y = "Lessons",
    x = "Date",
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
      panel.background = element_rect(fill = buttercup),
      plot.background = element_blank(),
      legend.position = c(0.01, 0.99),
      legend.justification = c("left", "top"),
      legend.box.background = element_blank(),
      legend.background = element_blank(),
      legend.margin = margin(0, 0, 0, 10),
      legend.title = element_blank()
    ) +
    annotate("segment",
      x = as.Date("2020-01-01"), xend = max(dat$dates),
      y = 130, yend = dat$lessons |> tail(4) |> sum(),
      color = "grey14", size = 2,
      arrow = arrow()
    ) +
    annotate("label",
      x = as.Date("2019-01-01"), y = 130,
      label = paste(dat$lessons |> tail(4) |> sum(), "lessons"),
      size = 7, family = "Droid Sans", label.padding = unit(0.5, "lines")
    )

print(p)
}
ggsave("lesson-growth.png", p, width = 7, height = 3.9375)
ggsave("lesson-growth.svg", p, width = 7, height = 3.9375)

