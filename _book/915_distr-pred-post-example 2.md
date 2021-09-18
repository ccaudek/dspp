# Inferenza su una proporzione con Stan {#inference-one-prop}



Il Capitolo \@ref(chapter-ppc) discute il codice Stan necessario per calcolare $p(y^{rep} \mid y)$ nel caso dell'inferenza su una proporzione. Questa Appendice approfondisce alcuni aspetti di tale analisi statistica.

Assumiamo che il codice Stan descritto nel Capitolo \@ref(chapter-ppc) abbia prodotto l'oggetto `fit`.


Trasformiamo `fit` in un oggetto di classe `stanfit`:


```r
stanfit <- rstan::read_stan_csv(fit$output_files())
```

\noindent
e esaminiamo il risultato ottenuto. Per i dati dell'esempio, l'esatta distribuzione a posteriori è una Beta(25, 17):


```r
summarize_beta_binomial(alpha = 2, beta = 10, y = 23, n = 30)
#>       model alpha beta      mean mode         var        sd
#> 1     prior     2   10 0.1666667  0.1 0.010683761 0.1033623
#> 2 posterior    25   17 0.5952381  0.6 0.005603016 0.0748533
```


```r
plot_beta(alpha = 25, beta = 17) + 
  lims(x = c(0, 1))
```



\begin{center}\includegraphics{915_distr-pred-post-example_files/figure-latex/unnamed-chunk-5-1} \end{center}

\noindent
L'approssimazione della distribuzione a posteriori per $\theta$ ottenuta mediante la simulazione MCMC è


```r
mcmc_dens(stanfit, pars = "theta") + 
  lims(x = c(0, 1))
```



\begin{center}\includegraphics{915_distr-pred-post-example_files/figure-latex/unnamed-chunk-6-1} \end{center}

La funzione `tidy()` nel pacchetto `broom.mixed` fornisce alcune utili statistiche per i 16000 valori della catena Markov memorizzati in `stanfit`:


```r
broom.mixed::tidy(
  stanfit, 
  conf.int = TRUE, 
  conf.level = 0.95, 
  pars = "theta"
)
#> # A tibble: 1 x 5
#>   term  estimate std.error conf.low conf.high
#>   <chr>    <dbl>     <dbl>    <dbl>     <dbl>
#> 1 theta    0.598    0.0750    0.444     0.739
```

\noindent
laddove, per esempio, la media esatta della corretta distribuzione a posteriori  è


```r
25 / (25 + 17)
#> [1] 0.5952381
```

La funzione `tidy()` non consente di calcolare altre statistiche descrittive, oltre alla media. Ma questo risultato può essere ottenuto direttamente utilizzando i valori delle catene di Markov. Iniziamo ad esaminare il contenuto dell'oggetto `stanfit`:


```r
list_of_draws <- extract(stanfit)
print(names(list_of_draws))
#> [1] "theta"   "y_rep"   "log_lik" "lp__"
```

\noindent
Possiamo estrarre i campioni della distribuzione a posteriori nel modo seguente:


```r
head(list_of_draws$theta)
#> [1] 0.543056 0.773923 0.691257 0.589060 0.705326 0.508107
```

\noindent
Creiamo un data.frame con le stime a posteriori $\hat{\theta}$:


```r
df <- data.frame(
  theta = list_of_draws$theta
)
```

\noindent
Le statistiche descrittive della distribuzione a posteriori possono ora essere ottenute usando direttamente i valori $\hat{\theta}$:


```r
df %>% 
  summarize(
    post_mean = mean(theta), 
    post_median = median(theta),
    post_mode = sample_mode(theta),
    lower_95 = quantile(theta, 0.025),
    upper_95 = quantile(theta, 0.975)
  )
#>   post_mean post_median post_mode  lower_95  upper_95
#> 1 0.5960131    0.597521 0.6008425 0.4440288 0.7391304
```

\noindent
È anche possibile calcolare, ad esempio, la probabilità di $\hat{\theta} > 0.5$:


```r
df %>% 
  mutate(exceeds = theta > 0.50) %>% 
  janitor::tabyl(exceeds)
#>  exceeds     n   percent
#>    FALSE  1689 0.1055625
#>     TRUE 14311 0.8944375
```



