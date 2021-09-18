# Modello gerarchico {#mod-hier-stan}



## Modello gerarchico

I modelli lineari misti, o modelli lineari gerarchici/multilivello, sono diventati uno strumento fondamentale della ricerca sperimentale in psicologia, linguistica e scienze cognitive, dove i progetti di ricerca a misure ripetute sono la norma. Il presente Capitolo fornisce un'introduzione a tali modelli considerando soltanto il caso più semplice, conosciuto anche col nome di _Random Intercept Model_.

Per fare un esempio concreto useremo il set di dati a misure ripetute con due condizioni di @gibson2013processing [si veda @sorensen2015bayesian]. La variabile dipendente `rt` dell'esperimento di @gibson2013processing è il tempo di lettura in millisecondi del soggetto di una proposizione relativa in un testo. I tempi di reazione sono stati registrati in due condizioni (ovvero, in presenza di un sostantivo riferito al soggetto oppure riferito all'oggetto della proposizione). I dati di @gibson2013processing provengono da un esperimento con 37 soggetti e 15 item. Gli item erano presentati in un disegno a quadrato latino, il che produce 37 $\times$ 15 = 555 dati. Risultano mancanti otto dati di un soggetto (id 27), il che ci porta ad un totale di 555 − 8 = 547 dati. Le prime righe del data.frame sono mostrate di seguito:


```r
rdat <- read.table(here::here("data", "gibsonwu2012data.txt"))
rdat$so <- ifelse(rdat$type == "subj-ext", -0.5, 0.5)
head(rdat)
#>    subj item     type pos word correct   rt region
#> 7     1   13  obj-ext   6 抓住       - 1140    de1
#> 20    1    6 subj-ext   6 男孩       - 1197    de1
#> 32    1    5  obj-ext   6   撞       -  756    de1
#> 44    1    9  obj-ext   6 監視       -  643    de1
#> 60    1   14 subj-ext   6 機師       -  860    de1
#> 73    1    4 subj-ext   6 男孩       -  868    de1
#>               type2   so
#> 7   object relative  0.5
#> 20 subject relative -0.5
#> 32  object relative  0.5
#> 44  object relative  0.5
#> 60 subject relative -0.5
#> 73 subject relative -0.5
```
La variabile di interesse che corrisponde alla manipolazione sperimentale è chiamata `so` ed è stata codificata con -0.5 se il sostantivo era riferito al soggetto e con +0.5 se il sostantivo era riferito all'oggetto della frase.

Calcoliamo la media dei tempi di reazione su scala logaritmica e per poi ritrasformare il risultato sulla scala originale:


```r
rdat %>% 
  group_by(type2) %>% 
  summarise(
    avg = exp(mean(log(rt), na.rm = TRUE))
  )
#> # A tibble: 2 x 2
#>   type2              avg
#>   <chr>            <dbl>
#> 1 object relative   551.
#> 2 subject relative  589.
```

Quando il sostantivo si riferisce al soggetto, i tempi di reazione sono più lenti di circa 30 ms. Questa descrizione dei dati, però non tiene conto né delle differenze tra i soggetti né delle differenze tra gli item. Per tenere in considerazioni queste diverse fonti della variabilità dei dati è necessario utilizzare un modello detto gerarchico. 


## Modello ad effetti fissi

Iniziamo con il modello "ad effetti fissi" che non tiene conto della struttura gerarchica dei dati, ovvero del fatto che c'è una covariazione all'interno dei cluster di dati definiti dalle variabili "soggetto" e "item".

Assumiamo che la variabile dipendente `rt` (del tempo di lettura) sia approssimativamente distribuita in modo logaritmico [@rouder2005unshifted]. Ciò presuppone che il logaritmo di `rt` sia distribuito approssimativamente in maniera normale. Il modello per il logaritmo dei tempi di lettura, $\log$ `rt`, diventa
\begin{equation}
\log rt_i = \beta_0 + \beta_1 so_i + \varepsilon_i,
\end{equation}
ovvero
\begin{equation}
rt \sim LogNormal(\beta_0 + \beta_1 so,\sigma)
\end{equation}
dove $\beta_0$ è la media generale di $\log$ `rt` e $\beta_1 so$ codifica la differenza $\E(\log rt_{o}) - \E(\log rt_{s})$ quando si passa dalla condizione nella quale il sostantivo è riferito all'oggetto alla condizione nella quale il sostantivo è riferito all'soggetto -- valori negativi significano che i tempi di reazioni sono maggiori nella condizione `s` che nella condizione `o`.

Nel modello useremo le seguenti distribuzioni a priori:
\begin{equation}
\begin{aligned}
\beta[1] &\sim Normal(6, 1.5) \\
\beta[2] &\sim Normal(0, 1.0) \\
\sigma &\sim Cauchy(0, 1)\\
\end{aligned}
\end{equation}

<!-- https://bayesball.github.io/BOOK/bayesian-hierarchical-modeling.html#hierarchical-normal-modeling -->

<!-- https://vasishth.github.io/bayescogsci/book/sec-trial.html -->

In Stan, il modello diventa


```r
modelString = "
data {
  int<lower=1> N; //number of data points
  real rt[N]; //reading time
  real<lower=-0.5, upper=0.5> so[N]; //predictor
}
parameters {
  vector[2] beta; //fixed intercept and slope
  real<lower=0> sigma_e; //error sd
}
model {
  real mu;
  // likelihood
  beta[1] ~ normal(6, 1.5);
  beta[2] ~ normal(0, 1);
  sigma_e ~ cauchy(0, 1);
  for (i in 1:N){
    mu = beta[1] + beta[2] * so[i];
    rt[i] ~ lognormal(mu, sigma_e);
  }
}
"
writeLines(modelString, con = "code/fixeff_model.stan")

file <- file.path("code", "fixeff_model.stan")
mod <- cmdstan_model(file)
```

I dati sono contenuti nella lista `stan_dat`:

```r
stan_dat <- list(
  rt = rdat$rt,
  so = rdat$so,
  N = nrow(rdat)
)
```

Eseguiamo il campionamento MCMC:


```r
fit3 <- mod$sample(
  data = stan_dat,
  iter_sampling = 4000L,
  iter_warmup = 2000L,
  seed = SEED,
  chains = 4L,
  parallel_chains = 2L,
  refresh = 0,
  thin = 1
)
```

Otteniamo un oggetto di classe `stanfit`:

```r
stanfit <- rstan::read_stan_csv(fit3$output_files())
```

Calcoliamo gli intervalli di credibilità al 95%:

```r
ci95 <- rstanarm::posterior_interval(
  as.matrix(stanfit),
  prob = 0.95
)
round(ci95, 3)
#>              2.5%     97.5%
#> beta[1]     6.321     6.368
#> beta[2]    -0.113    -0.017
#> sigma_e     0.613     0.646
#> lp__    -2616.980 -2612.410
```

L'effetto medio, sulla scala in millisecondi, si trova nel modo seguente:x

```r
posterior <- extract(stanfit, permuted = TRUE)
exp(mean(posterior$beta[, 1] + posterior$beta[, 2])) - 
  exp(mean(posterior$beta[, 1]))
#> [1] -35.80053
```


## Modello gerarchico

Il modello a effetti fissi è inappropriato per i dati di @gibson2013processing perché non tiene conto del fatto che abbiamo più misure per ogni soggetto e per ogni item. In altre parole, il modello ad effetti fissi viola l'assunzione di indipendenza degli errori. Inoltre, i coefficienti di effetti fissi $\beta_0$ e $\beta_1$ rappresentano le medie calcolate su tutti i soggetti e tutti gli item, ignorando il fatto che alcuni soggetti sono più veloci e altri più lenti della media, e il fatto che alcuni item sono stati letti più velocemente della media e altri più lentamente.

Nei modelli lineari misti, teniamo in considerazione la variabilità dovuta alle differenze tra soggetti e tra item aggiungendo al modello i termini $u_{0j}$ e $w_{0k}$ che aggiustano $\beta_0$ stimando una componente specifica al soggetto $j$ e all'item $k$. Questa formulazione del modello scompone parzialmente $\varepsilon_i$ in una somma di termini $u_{0j}$ e $w_{0k}$ che, geometricamente, corrispondono a degli aggiustamenti dell'intercetta $\beta_0$ specifici per il soggetto $j$ e per l'item $k$. Se il soggetto $j$ è più lento della media di tutti i soggetti, $u_j$ sarà un numero positivo; se l'item $k$ viene letto più velocemente del tempo di lettura medio di tutti gli item, allora $w_k$ sarà un numero negativo. Viene stimato un aggiustamento $u_{0j}$ per ogni soggetto $j$ e un aggiustamento $w_{0k}$ per ogni item. Gli aggiustamenti $u_{0j}$ e $w_{0k}$ sono chiamati _random intercepts_ o _varying intercepts_ [@gelman2020regression]. La modifica di $\beta_0$ mediante  $u_{0j}$ e $w_{0k}$ consente dunque di tenere in considerazione la variabilità dovuta ai soggetti e agli item.

Il random intercept model assume che gli aggiustamenti $u_{0j}$ e $w_{0k}$ siano  distribuiti normalmente attorno allo zero con una deviazione standard sconosciuta: $u_0 ∼ \mathcal{N}(0, \sigma_u)$ e $w_0 ∼ \mathcal{N}(0, \sigma_w)$. Il modello include dunque tre fonti di varianza: la deviazione standard degli errori $\sigma_e$, la deviazione standard delle _random intercepts_ per i soggetti, $\sigma_u$, e la deviazione standard delle _random intercepts_ per gli item, $\sigma_w$. Queste tre fonti di variabilità sono dette _componenti della varianza_. Possiamo dunque scrivere:
\begin{equation}
\log rt_{ijk} = \beta_0 + \beta_1 so_i + u_{0j} + w_{0k} + \varepsilon_{ijk}.
\end{equation}

Il coefficiente $\beta_1$ è quello di interesse primario. Come conseguenza della codifica usata, avrà il valore $-\beta_1$ nella condizione in cui il sostantivo è riferito al soggetto e $+\beta_1$ nella condizione in cui il sostantivo è riferito all'oggetto della frase.

In Stan il modello diventa:


```r
modelString = "
data {
  int<lower=1> N; //number of data points
  real rt[N]; //reading time
  real<lower=-0.5, upper=0.5> so[N]; //predictor
  int<lower=1> J; //number of subjects
  int<lower=1> K; //number of items
  int<lower=1, upper=J> subj[N]; //subject id
  int<lower=1, upper=K> item[N]; //item id
}
parameters {
  vector[2] beta; //fixed intercept and slope
  vector[J] u; //subject intercepts
  vector[K] w; //item intercepts
  real<lower=0> sigma_e; //error sd
  real<lower=0> sigma_u; //subj sd
  real<lower=0> sigma_w; //item sd
}
model {
  real mu;
  //priors
  u ~ normal(0, sigma_u); //subj random effects
  w ~ normal(0, sigma_w); //item random effects
  // likelihood
  for (i in 1:N){
    mu = beta[1] + u[subj[i]] + w[item[i]] + beta[2] * so[i];
    rt[i] ~ lognormal(mu, sigma_e);
  }
}
"
writeLines(modelString, con = "code/random_intercepts_model.stan")

file <- file.path("code", "random_intercepts_model.stan")
mod <- cmdstan_model(file)
```

I dati sono


```r
stan_dat <- list(
  subj = as.integer(as.factor(rdat$subj)),
  item = as.integer(as.factor(rdat$item)),
  rt = rdat$rt,
  so = rdat$so,
  N = nrow(rdat),
  J = length(unique(rdat$subj)),
  K = length(unique(rdat$item))
)
```

Eseguiamo il campionamento MCMC:


```r
fit4 <- mod$sample(
  data = stan_dat,
  iter_sampling = 4000L,
  iter_warmup = 2000L,
  seed = SEED,
  chains = 4L,
  parallel_chains = 2L,
  refresh = 0,
  thin = 1
)
```

Otteniamo un oggetto di classe `stanfit`:


```r
stanfit <- rstan::read_stan_csv(fit4$output_files())
```

Le medie a posteriori si ottengono con


```r
fit4$summary(c("beta", "sigma_e", "sigma_w", "sigma_u"))
#> # A tibble: 5 x 10
#>   variable    mean  median      sd     mad      q5     q95
#>   <chr>      <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 beta[1]   6.35    6.35   0.0518  0.0507   6.26    6.43  
#> 2 beta[2]  -0.0604 -0.0602 0.0218  0.0217  -0.0962 -0.0246
#> 3 sigma_e   0.577   0.577  0.00785 0.00786  0.565   0.590 
#> 4 sigma_w   0.120   0.115  0.0291  0.0263   0.0810  0.174 
#> 5 sigma_u   0.238   0.235  0.0318  0.0308   0.192   0.295 
#> # ... with 3 more variables: rhat <dbl>, ess_bulk <dbl>,
#> #   ess_tail <dbl>
```

Gli intervalli di credibilità sono:


```r
ci95 <- rstanarm::posterior_interval(
  as.matrix(stanfit),
  prob = 0.95
)
round(ci95, 3)
#>              2.5%     97.5%
#> beta[1]     6.243     6.448
#> beta[2]    -0.103    -0.017
#> u[1]       -0.211     0.084
#> u[2]       -0.306    -0.010
#> u[3]       -0.127     0.169
#> u[4]       -0.212     0.087
#> u[5]       -0.076     0.216
#> u[6]       -0.048     0.246
#> u[7]       -0.162     0.136
#> u[8]       -0.124     0.175
#> u[9]       -0.098     0.200
#> u[10]      -0.011     0.286
#> u[11]       0.448     0.748
#> u[12]       0.148     0.444
#> u[13]      -0.168     0.130
#> u[14]      -0.154     0.142
#> u[15]       0.033     0.327
#> u[16]      -0.200     0.095
#> u[17]      -0.714    -0.417
#> u[18]      -0.420    -0.121
#> u[19]      -0.293     0.000
#> u[20]       0.162     0.459
#> u[21]       0.053     0.348
#> u[22]       0.127     0.420
#> u[23]      -0.201     0.099
#> u[24]      -0.087     0.300
#> u[25]       0.004     0.293
#> u[26]      -0.491    -0.200
#> u[27]      -0.236     0.062
#> u[28]      -0.332    -0.035
#> u[29]      -0.425    -0.124
#> u[30]      -0.408    -0.112
#> u[31]      -0.098     0.191
#> u[32]      -0.177     0.117
#> u[33]      -0.234     0.058
#> u[34]       0.259     0.553
#> u[35]      -0.396    -0.103
#> u[36]      -0.144     0.153
#> u[37]      -0.173     0.124
#> w[1]       -0.134     0.061
#> w[2]       -0.121     0.076
#> w[3]       -0.102     0.094
#> w[4]       -0.215    -0.015
#> w[5]       -0.008     0.190
#> w[6]       -0.146     0.052
#> w[7]       -0.284    -0.083
#> w[8]        0.112     0.312
#> w[9]       -0.187     0.009
#> w[10]      -0.041     0.152
#> w[11]      -0.139     0.056
#> w[12]      -0.032     0.161
#> w[13]      -0.179     0.019
#> w[14]       0.036     0.232
#> w[15]      -0.042     0.151
#> sigma_e     0.562     0.593
#> sigma_u     0.185     0.308
#> sigma_w     0.076     0.189
#> lp__    -2332.580 -2311.140
```

Questi risultati replicano i risultati che si ottengono con la funzione `brms::brm`:


```r
M1 <- brm(
  rt ~ so + (1 | subj) + (1 | item),
  family = lognormal(),
  prior = c(
    prior(normal(6, 1.5), class = Intercept),
    prior(normal(0, 1), class = sigma),
    prior(normal(0, 1), class = b)
    ),
  data = rdat
)
```


```r
summary(M1)
#>  Family: lognormal 
#>   Links: mu = identity; sigma = identity 
#> Formula: rt ~ so + (1 | subj) + (1 | item) 
#>    Data: rdat (Number of observations: 2735) 
#>   Draws: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
#>          total post-warmup draws = 4000
#> 
#> Group-Level Effects: 
#> ~item (Number of levels: 15) 
#>               Estimate Est.Error l-95% CI u-95% CI Rhat
#> sd(Intercept)     0.12      0.03     0.07     0.18 1.00
#>               Bulk_ESS Tail_ESS
#> sd(Intercept)     1082     2159
#> 
#> ~subj (Number of levels: 37) 
#>               Estimate Est.Error l-95% CI u-95% CI Rhat
#> sd(Intercept)     0.24      0.03     0.18     0.31 1.01
#>               Bulk_ESS Tail_ESS
#> sd(Intercept)      642      969
#> 
#> Population-Level Effects: 
#>           Estimate Est.Error l-95% CI u-95% CI Rhat
#> Intercept     6.34      0.05     6.24     6.45 1.01
#> so           -0.06      0.02    -0.11    -0.02 1.00
#>           Bulk_ESS Tail_ESS
#> Intercept      447      590
#> so            4890     3096
#> 
#> Family Specific Parameters: 
#>       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS
#> sigma     0.58      0.01     0.56     0.59 1.00     4603
#>       Tail_ESS
#> sigma     3008
#> 
#> Draws were sampled using sampling(NUTS). For each parameter, Bulk_ESS
#> and Tail_ESS are effective sample size measures, and Rhat is the potential
#> scale reduction factor on split chains (at convergence, Rhat = 1).
```



