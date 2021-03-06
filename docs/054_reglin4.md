# Inferenza sul modello lineare {#inference-reg-lin-stan}



<!-- I minimi quadrati o la massima verosimiglianza trovano i parametri che meglio si adattano ai dati (secondo un criterio prestabilito), ma senza altrimenti vincolare la stima. Ma di solito il ricercatore dispone di informazioni preliminari sui parametri del modello. L'inferenza bayesiana produce invece un compromesso tra tali informazioni pregresse e i dati.  -->

<!-- moltiplicando la funzione di verosimiglianza con una distribuzione a priori che codifica probabilisticamente le informazioni sui parametri possedute dal ricercatore prima di avere osservato i dati. Il prodotto della verosimiglianza \@ref(eq:ml-reg) e della distribuzione a priori è chiamata distribuzione a posteriori e riassume la nostra conoscenza del parametro _dopo_ aver visto i dati.  -->

<!-- La soluzione dei minimi quadrati è una stima puntuale che rappresenta il vettore dei coefficienti che fornisce il miglior adattamento complessivo ai dati. Per un modello bayesiano, la stima puntuale corrispondente è la _moda a posteriori_, che fornisce il miglior adattamento complessivo ai dati e alla distribuzione a priori. Si noti inoltre che la stima dei minimi quadrati (o di massima verosimiglianza) corrisponde alla moda a posteriori di un modello bayesiano con una distribuzione a priori uniforme. -->

## Rappresentazione grafica dell'incertezza della stima

Un primo modo per rappresentare l'incertezza dell'inferenza in un ottica bayesiana è quella di rappresentare graficamente la retta specificata dal modello lineare. Continuando con l'esempio descritto nel Capitolo precedente (ovvero, i dati `kid_score` e `mom_iq` centrati), usando la funzione `rstan::read_stan_csv`, leggiamo i file CSV  generati da `cmdstan` e trasformiamo le stime a posteriori dei parametri in formato `stanfit`:




```r
stanfit <- rstan::read_stan_csv(fit2$output_files())
posterior <- extract(stanfit)
```

Creiamo ora un diagramma a dispersione dei dati con sovrapposto il valore atteso della $y$:

```r
tibble(
  kid_score = df$kid_score,
  mom_iq = df$mom_iq - mean(df$mom_iq)
) %>% 
  ggplot(aes(mom_iq, kid_score)) + 
  geom_point() + 
  geom_abline(intercept = mean(posterior$alpha), slope = mean(posterior$beta)) 
```



\begin{center}\includegraphics[width=0.8\linewidth]{054_reglin4_files/figure-latex/unnamed-chunk-4-1} \end{center}

Un modo per visualizzare l'incertezza della stima della retta specifiata dal modello lineare è quello di tracciare molteplici rette, ciascuna delle quali definita da una diversa stima dei parametri $\alpha$ e $\beta$; le diverse stime dei parametri $\alpha$ e $\beta$ vengono estratta a caso dalle rispettive distribuzioni a posteriori.

Per ottenere questo risultato dobbiamo estrarre le informazioni richieste dall'oggetto `stanfit` che abbiamo creato. Per fare questo usiamo le funzionalità di `tidybayes`. Per esempio

```r
tidybayes::get_variables(stanfit)
#>  [1] "alpha_std"     "beta_std"      "sigma_std"     "alpha"        
#>  [5] "beta"          "sigma"         "lp__"          "accept_stat__"
#>  [9] "treedepth__"   "stepsize__"    "divergent__"   "n_leapfrog__" 
#> [13] "energy__"
```
\noindent
Creiamo un Dataframe in formato tidy che contiene le stime a posteriori di $\alpha$ e $\beta$ nel modo seguente:

```r
draws <- stanfit %>%
  spread_draws(beta, alpha) 
```


```r
draws %>%
  head(10)
#> # A tibble: 10 × 5
#>   .chain .iteration .draw  beta alpha
#>    <int>      <int> <int> <dbl> <dbl>
#> 1      1          1     1 0.609  88.2
#> 2      1          2     2 0.611  86.4
#> 3      1          3     3 0.579  86.2
#> 4      1          4     4 0.630  86.7
#> 5      1          5     5 0.588  86.5
#> 6      1          6     6 0.661  87.2
#> # … with 4 more rows
```
\noindent
Possiamo ora generare il diagramma a dispersione con `ggplot()`:


```r
tibble(
  kid_score = df$kid_score,
  mom_iq = df$mom_iq - mean(df$mom_iq)
) %>% 
  ggplot(aes(mom_iq, kid_score)) + 
  geom_point() + 
  geom_abline(data = draws, aes(intercept = alpha, slope = beta),
    size = 0.2, alpha = 0.01, color = "skyblue") +
  geom_abline(intercept = mean(posterior$alpha), slope = mean(posterior$beta)) +
  labs(
    x = "Quoziente di intelligenza della madre",
    y = "Quoziente di intelligenza del bambino"
  )
```



\begin{center}\includegraphics[width=0.8\linewidth]{054_reglin4_files/figure-latex/unnamed-chunk-8-1} \end{center}


## Intervalli di credibilità

L'incertezza inferenziale sui parametri può anche essere rappresentata mediante gli _intervalli di credibilità_, ovvero gli intervalli che contengono la quota desiderata (es., il 95%) della distribuzione a posteriori. Per l'esempio che stiamo discutendo, gli intervalli di credibilità al 95% si ottengono nel modo seguente:


```r
rstantools::posterior_interval(as.matrix(stanfit), prob = 0.95)
#>                2.5%     97.5%
#> alpha_std   -0.0838    0.0845
#> beta_std     0.3633    0.5324
#> sigma_std    0.8404    0.9580
#> alpha       85.0865   88.5229
#> beta         0.4943    0.7244
#> sigma       17.1538   19.5538
#> lp__      -172.8280 -168.2490
```

Un grafico che riporta l'intervallo di credibilità ai livelli di probabilità desiderati per i parametri $\alpha$, $\beta$ e $\sigma$ (nel caso dei dati standardizzati) si ottiene con la seguente istruzione:


```r
mcmc_areas(
  fit2$draws(c("alpha_std", "beta_std", "sigma_std")),
  prob = 0.8,
  prob_outer = 0.95
  )
```



\begin{center}\includegraphics[width=0.8\linewidth]{054_reglin4_files/figure-latex/unnamed-chunk-10-1} \end{center}
\noindent
Oppure

```r
stanfit %>%
  mcmc_intervals(
    pars = c("alpha_std", "beta_std", "sigma_std"), 
    prob = 0.8,
    prob_outer = 0.95
  )
```



\begin{center}\includegraphics[width=0.8\linewidth]{054_reglin4_files/figure-latex/unnamed-chunk-11-1} \end{center}


## Rappresentazione grafica della distribuzione a posteriori

Non c'è niente di "magico" o necessario relativamente al livello di 0.95: il valore  0.95 è arbitrario. Sono possibili tantissime altre soglie per quantificare la nostra incertezza: alcuni ricercatori usano il livello di 0.89, altri quello di 0.5. Se l'obiettivo è quello di descrivere il livello della nostra incertezza relativamente alla stima del parametro, allora dobbiamo riconoscere che la nostra incertezza è descritta dall'*intera* distribuzione a posteriori. Per cui il metodo più semplice, più diretto e più completo per descrivere la nostra incertezza rispetto alla stima dei parametri è semplicemente quello di riportare graficamente _tutta_ la distribuzione a posteriori. Una rappresentazione della distribuzione a posteriori dei parametri del modello dell'esempio si ottiene nel modo seguente:


```r
stan_dens(
  stanfit, 
  pars = c("alpha", "beta", "sigma"),
  fill = "#4ca5ff"
)
```



\begin{center}\includegraphics[width=0.8\linewidth]{054_reglin4_files/figure-latex/unnamed-chunk-12-1} \end{center}


## Test di ipotesi

È facile valutare ipotesi direzionali usando Stan. Per esempio, la probabilità  $Pr(\hat{\beta} > 0)$ è


```r
sum(posterior$beta > 0) / length(posterior$beta)
#> [1] 1
```

\noindent
ovvero, la probabilità $Pr(\hat{\beta} \leq 0)$ è


```r
sum(posterior$beta < 0) / length(posterior$beta)
#> [1] 0
```


## Modello lineare robusto

Spesso i ricercatori devono affrontare il problema degli outlier: in presenza di outlier, un modello statistico basato sulla distribuzione Normale produrrà delle stime dei parametri che non si generalizzano ad altri campioni di dati. Il metodo tradizoinale per affrontare questo problema è quello di eliminare gli outlier prima di eseguire l'analisi statistica. Il problema di questo approccio, però, è che il criterio utilizzato per eliminare gli outlier, quale esso sia, è arbitrario; dunque, usando criteri diversi per eliminare gli outlier, i ricercatori finiscono per trovare risultati diversi.

Questo problema trova una semplice soluzione nell'approccio bayesiano. Nel modello lineare che abbiamo dicusso finora è stato ipotizzato che $\varepsilon \sim \mathcal{N}(0, \sigma_{\varepsilon})$. Per un modello formulato in questi termini, la presenza di solo un valore anomalo e influente può avere un effetto drammatico sulle stime dei parametri. 

Per fare un esempio, introduciamo un singlo valore anomalo nel set dei dati dell'esempio che stiamo discutendo:


```r
df2 <- df
df2$kid_score[434] <- -500
df2$mom_iq[434] <- 140
```
Per comodità, calcoliamo le stime di $\alpha$ e $\beta$ con il metodo dei minimi quadrati (le stime dei parametri sono simili a quelle di un modello bayesiano Normale con distribuzioni a priori vagamente informative). Sappiamo che, nel campione originari di dati, $\hat{\beta} \approx 0.6$. In presenza di un solo outlier troviamo 
che

```r
coef(lm(kid_score ~ mom_iq, data = df2))
#> (Intercept)      mom_iq 
#>      49.188       0.363
```
\noindent
la stima di $\beta$ viene drammaticamente ridotta (di quasi la metà!). 

Non è però necessario assumere $\varepsilon \sim \mathcal{N}(0, \sigma_{\varepsilon})$. È altrettanto valido un modello che ipotizza una diversa distribuzione di densità per i residui come, ad esempio, la distribuzione $t$ di Student con un piccolo numero di gradi di libertà. Una caratteristica della $t$ di Student è che le code della distribuzione contengono una massa di probabilità maggiore della Normale. Ciò fornisce alla $t$ di Student la possibilità di "rendere conto" della presenza di osservazioni lontane dalla media della distribuzione. In altri termini, se in modello lineare usiamo la $t$ di Student quale distribuzione dei residui, la presenza di outlier avrà una minore influenza sulle stime dei parametri di quanto avvenga nel modello Normale.

Per verificare questa affermazione, modifichiamo il codice Stan in modo tale da ipotizzare che la distribuzione della $y$ segua una $t$ di Student con un numero $\nu$ gradi di libertà stimato dal modello: `student_t(nu, mu, sigma)`.^[È equivalente scrivere $y_i = \mu_i + \varepsilon_i$, dove $\mu_i = \alpha + \beta x_i, \varepsilon_i \sim \mathcal{N}(0, \sigma_\varepsilon),$ oppure $y_i \sim \mathcal{N}(\mu_i, \sigma_\varepsilon).$]


```r
modelString = "
data {
  int<lower=0> N;
  vector[N] y;
  vector[N] x;
}
transformed data {
  vector[N] x_std;
  vector[N] y_std;
  x_std = (x - mean(x)) / sd(x);
  y_std = (y - mean(y)) / sd(y);
}
parameters {
  real alpha_std;
  real beta_std;
  real<lower=0> sigma_std;
  real<lower=1> nu;    // degrees of freedom is constrained >1
}
model {
  alpha_std ~ normal(0, 2);
  beta_std ~ normal(0, 2);
  sigma_std ~ cauchy(0, 2);
  nu ~ gamma(2, 0.1);   // Juárez and Steel(2010)
  y_std ~ student_t(nu, alpha_std + beta_std * x_std, sigma_std);
}
generated quantities {
  real alpha;
  real beta;
  real<lower=0> sigma;
  alpha = sd(y) * (alpha_std - beta_std * mean(x) / sd(x))
           + mean(y);
  beta = beta_std * sd(y) / sd(x);
  sigma = sd(y) * sigma_std;
}
"
writeLines(modelString, con = "code/simpleregstdrobust.stan")
```

\noindent
Costruiamo la lista dei dati usando il data.frame `df2` che include l'outlier:


```r
data3_list <- list(
  N = length(df2$kid_score),
  y = df2$kid_score,
  x = df2$mom_iq - mean(df2$mom_iq)
)
```

\noindent
Adattiamo il modello lineare robusto ai dati:


```r
file <- file.path("code", "simpleregstdrobust.stan")
mod <- cmdstan_model(file)

fit4 <- mod$sample(
  data = data3_list,
  iter_sampling = 4000L,
  iter_warmup = 2000L,
  seed = SEED,
  chains = 4L,
  parallel_chains = 2L,
  refresh = 0,
  thin = 1
)
```

\noindent
Esaminando le stime dei parametri


```r
fit4$summary(c("alpha", "beta", "sigma", "nu"))
#> # A tibble: 4 × 10
#>   variable   mean median     sd    mad     q5    q95  rhat ess_bulk
#>   <chr>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl>    <dbl>
#> 1 alpha    87.8   87.8   0.887  0.899  86.3   89.3    1.00   13776.
#> 2 beta      0.603  0.603 0.0585 0.0577  0.506  0.698  1.00   14185.
#> 3 sigma    15.9   15.9   0.806  0.812  14.6   17.3    1.00   12699.
#> 4 nu        5.58   5.44  1.15   1.11    3.94   7.65   1.00   12258.
#> # … with 1 more variable: ess_tail <dbl>
```

\noindent
notiamo che la stima di $\beta$ è rimasta praticamente immutata. Il modello lineare robustao non risente dunque della presenza degli outlier.

