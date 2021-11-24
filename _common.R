suppressPackageStartupMessages(library("here"))
suppressPackageStartupMessages(library("tidyverse"))
suppressPackageStartupMessages(library("patchwork"))
suppressPackageStartupMessages(library("bayesplot"))
suppressPackageStartupMessages(library("ggExtra"))
suppressPackageStartupMessages(library("ggpubr"))
suppressPackageStartupMessages(library("khroma"))

# R options set globally
# options(width = 60)
options(digits = 3)
set.seed(42)
SEED <- 374237 # set random seed for reproducibility
# theme_set(bayesplot::theme_default(base_family = "sans"))
theme_set(bayesplot::theme_default(base_size = 12))
# bayesplot::color_scheme_set("brightblue") 
colors <- colour("bright", names = FALSE)(4)
ggplot <- function(...) ggplot2::ggplot(...) + scale_color_bright()
theme_update(plot.title = element_text(hjust = 0.5))

# knitr chunk options ----------------------------------------------------------

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  message = FALSE, 
  warning = FALSE,
  error = FALSE,
  tidy = "styler",
  # fig.height = 3, 
  # fig.width = 4.854,
  # fig.align = "center",
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold",
  dpi = 300,
  fig.pos = "h",
  knitr::opts_chunk$set(cache.extra = knitr::rand_seed)
  )

if (knitr::is_html_output()) {
  knitr::opts_chunk$set(out.width = "90%")
} else if (knitr::is_latex_output()) {
  knitr::opts_chunk$set(out.width = "80%")
}

# dplyr options ----------------------------------------------------------------

options(dplyr.print_min = 6, dplyr.print_max = 6)



