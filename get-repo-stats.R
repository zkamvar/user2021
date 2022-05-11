library("gh")
library("purrr")
library("jsonlite")

comm_less_src <- "https://feeds.carpentries.org/community_lessons.json"
less_src <- "https://feeds.carpentries.org/lessons.json"
community_lessons <- jsonlite::read_json(comm_less_src)
lessons <- jsonlite::read_json(less_src)
lesson_urls <- c(lessons, community_lessons) |> purrr::map_chr(~.x$repo_url)

less_repos <- purrr::map_chr(lessons, ~.x$carpentries_org) |>
  unique() |>
  c("carpentries-incubator", "carpentries-lab") |>
  purrr::map(~gh::gh("/orgs/{org}/repos", org = .x, .limit = Inf, per_page = 300)) |>
  purrr::flatten()


all_lessons <- purrr::keep(less_repos, ~.x$html_url %in% lesson_urls)

stopifnot(
  "Mismatched lessons" = length(all_lessons) == length(lessons) + length(community_lessons))

res <- map_dfr(all_lessons, ~list(
  carpentry = .x$owner$login,
  repo = .x$name,
  created = .x$created_at,
  stars = .x$stargazers_count,
  branch = .x$default_branch,
  issues = .x$open_issues_count
))

write.csv(res, "repos.csv", row.names = FALSE, fileEncoding = "utf-8")
