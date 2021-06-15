library("jsonlite")
library("ggplot2")
library("ggthemes")
library("forcats")

ssg <- "https://unpkg.com/staticsitegenerators@3.1.0-next.1592598397.da4a0ce9319b74643e365f01611eb40eb89df3dd/hydrated.json"
dat <- read_json(ssg, simplifyVector = TRUE)
langs <- dat$language |>
  table() |>
  sort() |>
  as.data.frame()

langs$Var1 <- as.character(langs$Var1)
tens <- tail(langs, 11)
tens$Var1[1] <- "(others)"
tens$Freq[1] <- sum(head(langs$Freq, -11))
tens$Var1 <- fct_inorder(tens$Var1)

ggplot(tens, aes(y = Var1, x = Freq)) +
  geom_col() +
  theme_economist_white(base_size = 24, base_family = "Droid Sans") +
  labs(title = "Static Site Generators by Language",
       subtitle = "Source: https://staticsitegenerators.net",
       x = NULL,
       y = NULL)
ggsave("static-site-generators.png", scale = 0.75)
