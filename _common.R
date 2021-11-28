# Common packages
suppressPackageStartupMessages({
  library("here")
  library("tidyverse")
  library("patchwork")
  library("bayesplot")
  library("ggExtra")
  library("ggpubr")
  library("ggokabeito")
})  
  
# R options set globally
# options(width = 60)
options(digits = 3)
set.seed(42)
SEED <- 374237 # set random seed for reproducibility

# theme_set(bayesplot::theme_default(base_family = "sans"))
# theme_set(bayesplot::theme_default(base_size = 12))
bayesplot::color_scheme_set("brightblue")
theme_update(plot.title = element_text(hjust = 0.5))

theme_clean <- function() {
  theme_minimal() +
    theme(
      panel.grid.minor = element_blank(),
      strip.background = element_rect(fill = "grey80", color = NA)
    )
}
theme_set(theme_clean())

# knitr chunk options ----------------------------------------------------------

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  error = FALSE,
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618, # 1 / phi
  fig.show = "hold",
  dpi = 300,
  fig.pos = "h",
  cache.extra = knitr::rand_seed,
  tidy.opts = list(width.cutoff = 70),
  tidy = "styler"
)

if (knitr::is_html_output()) {
  knitr::opts_chunk$set(out.width = "90%")
} else if (knitr::is_latex_output()) {
  knitr::opts_chunk$set(out.width = "80%")
}

# dplyr options ----------------------------------------------------------------

options(dplyr.print_min = 6, dplyr.print_max = 6)
