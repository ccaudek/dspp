# Common packages
suppressPackageStartupMessages({
  library("here")
  library("tidyverse")
  library("patchwork")
  library("bayesplot")
  library("ggExtra")
  library("ggpubr")
  library("viridis")
  library("ggokabeito")
})  
  
# R options set globally
options(
  digits = 3,
  width = 68,
  str = strOptions(strict.width = "cut"),
  crayon.enabled = TRUE
)
knitr::opts_chunk$set(width = 68)

set.seed(42)
SEED <- 374237 # set random seed for reproducibility

# theme_set(bayesplot::theme_default(base_family = "sans"))
theme_set(bayesplot::theme_default(base_size = 12))
bayesplot::color_scheme_set("brightblue") #  mix-blue-green
# theme_update(plot.title = element_text(hjust = 0.5))

# LaTeX options ----------------------------------------------------------------

if (knitr::is_latex_output()) {
  options(crayon.enabled = FALSE)
  options(cli.unicode = TRUE)
}

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
