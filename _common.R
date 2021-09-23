suppressPackageStartupMessages(library("here"))
suppressPackageStartupMessages(library("tidyverse"))
suppressPackageStartupMessages(library("patchwork"))
suppressPackageStartupMessages(library("bayesplot"))
suppressPackageStartupMessages(library("ggExtra"))
suppressPackageStartupMessages(library("ggpubr"))
suppressPackageStartupMessages(library("khroma"))

# R options set globally
options(width = 60)
set.seed(42)
SEED <- 374237 # set random seed for reproducibility
# theme_set(bayesplot::theme_default(base_family = "sans"))
theme_set(bayesplot::theme_default())
# bayesplot::color_scheme_set("brightblue") 
colors <- colour("bright", names = FALSE)(4)
ggplot <- function(...) ggplot2::ggplot(...) + scale_color_bright()
theme_update(plot.title = element_text(hjust = 0.5))

# chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  message = FALSE, 
  warning = FALSE,
  error = FALSE,
  tidy = "styler",
  fig.height = 3, 
  fig.width = 6,
  fig.align = "center",
  knitr::opts_chunk$set(cache.extra = knitr::rand_seed)
  )


