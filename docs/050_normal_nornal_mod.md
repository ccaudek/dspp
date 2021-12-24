# Modello Normale-Normale {#normal-normal-mod-stan}




## Distribuzione Normale-Normale con varianza nota

Per $\sigma^2$ nota, la v.c. Normale è distribuzione a priori coniugata della v.c. Normale. Siano $Y_1, \dots, Y_n$ $n$ variabili casuali i.i.d. che seguono la distribuzione Normale:

$$
Y_1, \dots, Y_n  \stackrel{iid}{\sim} \mathcal{N}(\mu, \sigma).
$$
Si vuole stimare $\mu$ sulla base di $n$ osservazioni $y_1, \dots, y_n$. Considereremo qui solamente il caso in cui $\sigma^2$ sia supposta perfettamente nota.

Ricordiamo che la densità di una Normale è
$$
p(y_i \mid \mu, \sigma) = \frac{1}{{\sigma \sqrt {2\pi}}}\exp\left\{{-\frac{(y_i - \mu)^2}{2\sigma^2}}\right\}.
$$
\noindent
Essendo le variabili i.i.d., possiamo scrivere la densità congiunta come il prodotto delle singole densità e quindi si ottiene
$$
p(y \mid \mu) = \, \prod_{i=1}^n p(y_i \mid \mu).
$$

Una volta osservati i dati $y$, la verosimiglianza diventa 

\begin{align}
\mathcal{L}(\mu \mid y) =& \, \prod_{i=1}^n p(y_i \mid \mu) = \notag\\
& \frac{1}{{\sigma \sqrt {2\pi}}}\exp\left\{{-\frac{(y_1 - \mu)^2}{2\sigma^2}}\right\} \times \notag\\
 & \frac{1}{{\sigma \sqrt {2\pi}}}\exp\left\{{-\frac{(y_2 - \mu)^2}{2\sigma^2}}\right\} \times  \notag\\
& \vdots \notag\\
 & \frac{1}{{\sigma \sqrt {2\pi}}}\exp\left\{{-\frac{(y_n - \mu)^2}{2\sigma^2}}\right\}.
\end{align}

Se viene scelta una densità a priori Normale, ciò fa sì che anche la densità a posteriori sia Normale. Supponiamo che
\begin{equation}
p(\mu) = \frac{1}{{\tau_0 \sqrt {2\pi}}}\exp\left\{{-\frac{(\mu - \mu_0)^2}{2\tau_0^2}}\right\},
(\#eq:prior-mu-norm-norm)
\end{equation}
\noindent
ovvero che la distribuzione a priori di $\mu$ sia Normale con media $\mu_0$ e varianza $\tau_0^2$. Possiamo dire che $\mu_0$ rappresenta il valore ritenuto più probabile per $\mu$ e $\tau_0^2$ il grado di incertezza che abbiamo rispetto a tale valore. 

Svolgendo una serie di passaggi algebrici, si arriva a
\begin{equation}
p(\mu \mid y) = \frac{1}{{\tau_p \sqrt {2\pi}}}\exp\left\{{-\frac{(\mu - \mu_p)^2}{2\tau_p^2}}\right\},
(\#eq:post-norm-norm)
\end{equation}

\noindent
dove
\begin{equation}
\mu_p = \frac{\frac{1}{\tau_0^2}\mu_0+ \frac{n}{\sigma^2}\bar{y}}{\frac {1}{\tau_0^2} + \frac{n}{\sigma^2}} 
(\#eq:post-norm-mup)
\end{equation}

\noindent
e 
\begin{equation}
\tau_p^2 = \frac{1}{\frac {1}{\tau_0^2}+ \frac{n}{\sigma^2}}.
(\#eq:post-norm-taup2)
\end{equation}

\noindent
In altri termini, se la distribuzione a priori per $\mu$ è Normale, la distribuzione a posteriori è anch'essa Normale con valore atteso (a posteriori) $\mu_p$ e varianza (a posteriori) $\tau_p^2$ date dalle espressioni precedenti.

In conclusione, il risultato trovato indica che:

- il valore atteso a posteriori è una media pesata fra il valore atteso a priori $\mu_0$ e la media campionaria $\bar{y}$; il peso della media campionaria è tanto maggiore tanto più è grande $n$ (il numero di osservazioni) e $\tau_0^2$ (l'incertezza iniziale); 
- l'incertezza (varianza) a posteriori $\tau_p^2$ è sempre più piccola dell'incertezza a priori $\tau_0^2$ e diminuisce al crescere di $n$.


## Il modello Normale con Stan

Per esaminare un esempio pratico, consideriamo i 30 valori BDI-II dei soggetti clinici di @zetschefuture2019:


```r
df <- data.frame(
  y = c(
    26.0, 35.0, 30, 25, 44, 30, 33, 43, 22, 43, 
    24, 19, 39, 31, 25, 28, 35, 30, 26, 31, 41, 
    36, 26, 35, 33, 28, 27, 34, 27, 22
  )
)
```

\noindent
Calcoliamo le statistiche descrittive del campione di dati:


```r
df %>% 
  summarise(
    sample_mean = mean(y),
    sample_sd = sd(y)
  )
#>   sample_mean sample_sd
#> 1        30.9      6.61
```

Nella discussione seguente assumeremo che $\mu$ e $\sigma$ siano indipendenti. Assegneremo a $\mu$ una distribuzione a priori $\mathcal{N}(25, 2)$ e a $\sigma$ una distribuzione a priori $Cauchy(0, 3)$.

Il modello statistico diventa:

\begin{align}
Y_i &\sim \mathcal{N}(\mu, \sigma) \notag\\
\mu &\sim \mathcal{N}(\mu_{\mu} = 25, \sigma_{\mu} = 2) \notag\\
\sigma &\sim \Cauchy(0, 3) \notag
\end{align}

In base al modello definito, la variabile casuale $Y$ segue la distribuzione Normale di parametri $\mu$ e $\sigma$. Il parametro $\mu$ è sconosciuto e abbiamo deciso di descrivere la nostra incertezza relativa ad esso mediante una distribuzione a priori Normale con media uguale a 25 e deviazione standard pari a 2. L'incertezza relativa a $\sigma$ è quantificata da una distribuzione a priori half-Cauchy(0, 5), come indicato nella figura seguente:


```r
data.frame(x = c(0, 20)) %>% 
  ggplot(aes(x)) +
  stat_function(
    fun = dcauchy, 
    n = 1e3, 
    args = list(location = 0, scale = 3)
  ) +
  ylab("P(x)") +
  theme(legend.position = "none")
```



\begin{center}\includegraphics[width=0.8\linewidth]{050_normal_nornal_mod_files/figure-latex/unnamed-chunk-4-1} \end{center}

Dato che il modello è Normale-Normale, è possibile una soluzione analitica, come descritto in precedenza per il caso in cui $\sigma$ è noto. In tali condizioni, la distribuzione a posteriori per $\mu$ può essere trovata con la funzione `bayesrules:::summarize_normal_normal()`:


```r
bayesrules:::summarize_normal_normal(
  mean = 25, sd = 2, sigma = sd(df$y), y_bar = mean(df$y), n = 30
)
#>       model mean mode  var   sd
#> 1     prior 25.0 25.0 4.00 2.00
#> 2 posterior 29.4 29.4 1.07 1.03
```

La rappresentazione grafica della funzione a priori, della verosimiglianza e della distribuzione a posteriori per $\mu$ è fornita da:


```r
bayesrules:::plot_normal_normal(
  mean = 25, sd = 2, sigma = sd(df$y), y_bar = mean(df$y), n = 30
)
```



\begin{center}\includegraphics[width=0.8\linewidth]{050_normal_nornal_mod_files/figure-latex/unnamed-chunk-6-1} \end{center}

La procedura MCMC utilizzata da Stan è basata su un campionamento Monte Carlo Hamiltoniano che non richiede l'uso di distribuzioni a priori coniugate. Pertanto per i parametri è possibile scegliere una qualunque distribuzione a priori arbitraria.

Per continuare con l'esempio, poniamoci il problema di trovare le distribuzioni a posteriori dei parametri $\mu$ e $\sigma$ usando le funzioni del pacchetto `cmdstanr`. Il modello statistico descritto sopra si può scrivere in Stan nel modo seguente:


```r
modelString = "
data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  mu ~ normal(25, 2);
  sigma ~ cauchy(0, 3);
  y ~ normal(mu, sigma);
}
"
writeLines(modelString, con = "code/normalmodel.stan")
```

\noindent
Si noti che, nel modello, il parametro $\sigma$ è considerato incognito.

Sistemiamo i dati nel formato appropriato per potere essere letti da Stan:

```r
data_list <- list(
  N = length(df$y),
  y = df$y
)
```

Leggiamo il file in cui abbiamo salvato il codice Stan

```r
file <- file.path("code", "normalmodel.stan")
```

\noindent
compiliamo il modello

```r
mod <- cmdstan_model(file)
```

\noindent
ed eseguiamo il campionamento MCMC:

```r
fit <- mod$sample(
  data = data_list,
  iter_sampling = 4000L,
  iter_warmup = 2000L,
  seed = SEED,
  chains = 4L,
  parallel_chains = 2L,
  refresh = 0,
  thin = 1
)
```

Le stime a posteriori dei parametri si ottengono con:

```r
fit$summary(c("mu", "sigma"))
#> # A tibble: 2 × 10
#>   variable  mean median    sd   mad    q5   q95  rhat ess_bulk
#>   <chr>    <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>    <dbl>
#> 1 mu       29.3   29.3  1.10  1.09  27.4  31.0   1.00    9057.
#> 2 sigma     6.88   6.78 0.956 0.907  5.50  8.58  1.00    9154.
#> # … with 1 more variable: ess_tail <dbl>
```

\noindent
oppure, dopo avere trasformato l'oggetto `fit` nel formato `stanfit`, 

```r
stanfit <- rstan::read_stan_csv(fit$output_files())
```

\noindent
con 

```r
out <- rstantools::posterior_interval(as.matrix(stanfit), prob = 0.95)
out
#>         2.5%  97.5%
#> mu     27.04  31.31
#> sigma   5.32   9.04
#> lp__  -77.93 -74.27
```

Possiamo dunque concludere, con un grado di certezza soggettiva del 95%, che siamo sicuri che la media della popolazione da cui abbiamo tratto i dati è compresa nell'intervallo [27.04, 31.31]. 


## Il modello normale con `quap()`

Ripetiamo l'analisi precedente usando le funzioni del pacchetto `rethinking` per trovare le distribuzioni a posteriori dei parametri $\mu$ e $\sigma$. Definiamo il modello statistico mediante la funzione `alist()`:


```r
flist <- alist(
  y ~ dnorm(mu, sigma), 
  mu ~ dnorm(25, 2),
  sigma ~ dcauchy(0, 3)
)
```

Le precedenti istruzioni `R` specificano una variabile casuale $Y$ che si distribuisce come una Normale di parametri $\mu$ e $\sigma$; questa è la verosimiglianza. La distribuzione a priori del parametro $\mu$ è una Normale di media 25 e deviazione standard 2. La distribuzione a priori del parametro $\sigma$ è una half-Cauchy di parametri `location` = 0 e `scale` = 3. 

Usiamo la funzione `quap()` per ottenere l'approssimazione quadratica delle distribuzioni a posteriori di $\mu$ e $\sigma$:


```r
set.seed(123)
m <- quap( 
  flist,
  data = df 
)
```

L'intervallo di credibilità al 95% è dato dalla funzione `precis()`:
  

```r
out <- precis(m, prob = 0.95)
out
#>       mean    sd  2.5% 97.5%
#> mu    29.4 1.063 27.30 31.47
#> sigma  6.5 0.847  4.84  8.16
```

I risultati sono simili a quelli trovati in precedenza.

<!-- Possiamo dunque dire che, con un grado di certezza soggettiva del 95%, siamo sicuri che la media della popolazione da cui abbiamo tratto i dati è compresa nell'intervallo [27.3, 31.47].  -->


## Il modello normale con `brm()`

Stimiamo ora la distribuzione a posteriori di $\mu$ usando la funzione `brms::brm()`.  In questo caso non è necessario scrivere il modello in forma esplicita, come abbiamo fatto usando linguaggio Stan. La sintassi specifiata di seguito viene comunque trasformata in linguaggio Stan prima di adattare il modello ai dati:


```r
fit3 <- brm(
  data = df, 
  family = gaussian(),
  y ~ 1,
  prior = c(
    prior(normal(25, 2), class = Intercept),
    prior(cauchy(0, 3), class = sigma)
  ),
  iter = 4000, 
  refresh = 0, 
  chains = 4
)
```

\noindent
I trace-plot si ottengono con l'istruzione seguente:


```r
plot(fit3)
```



\begin{center}\includegraphics[width=0.8\linewidth]{050_normal_nornal_mod_files/figure-latex/unnamed-chunk-19-1} \end{center}

\noindent
Le stime della distribuzione a posteriori si ottengono con la funzione `summary()`:


```r
summary(fit3)
#>  Family: gaussian 
#>   Links: mu = identity; sigma = identity 
#> Formula: y ~ 1 
#>    Data: df (Number of observations: 30) 
#>   Draws: 4 chains, each with iter = 4000; warmup = 2000; thin = 1;
#>          total post-warmup draws = 8000
#> 
#> Population-Level Effects: 
#>           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS
#> Intercept    29.27      1.10    27.03    31.37 1.00     4233
#>           Tail_ESS
#> Intercept     4933
#> 
#> Family Specific Parameters: 
#>       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
#> sigma     6.89      0.94     5.35     9.00 1.00     4522     5131
#> 
#> Draws were sampled using sampling(NUTS). For each parameter, Bulk_ESS
#> and Tail_ESS are effective sample size measures, and Rhat is the potential
#> scale reduction factor on split chains (at convergence, Rhat = 1).
```

\noindent
Nuovamente, i risultati sono molto simili a quelli ottenuti in precedenza.


## Considerazioni conclusive {-}

Questo esempio ci mostra come calcolare l'intervallo di credibilità per la media di una v.c. Normale. La domanda più ovvia di analisi dei dati, dopo  avere visto come creare l'intervallo di credibilità per la media di un gruppo, riguarda il confronto tra le medie di due gruppi. Questo però è un caso speciale di una tecnica di analisi dei dati più generale, chiamate analisi di regressione lineare. Prima di discutere il problema del confronto tra le medie di due gruppi è dunque necessario esaminare il modello statistico di regressione lineare.


