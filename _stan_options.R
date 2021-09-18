# Stan options 

suppressPackageStartupMessages(library("bayesrules")) 
suppressPackageStartupMessages(library("rstan")) 
suppressPackageStartupMessages(library("cmdstanr"))
set_cmdstan_path("/Users/corrado/.cmdstanr/cmdstan-2.27.0")
suppressPackageStartupMessages(library("posterior"))
suppressPackageStartupMessages(library("loo"))
rstan_options(auto_write = TRUE) # avoid recompilation of models
options(mc.cores = parallel::detectCores()) # parallelize across all CPUs
Sys.setenv(LOCAL_CPPFLAGS = '-march=native') # improve execution time
rstan_options(auto_write = TRUE) # avoid recompilation of models
options(mc.cores = parallel::detectCores()) # parallelize across all CPUs
Sys.setenv(LOCAL_CPPFLAGS = '-march=native') # improve execution time

