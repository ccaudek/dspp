# Adattare il modello di regressione ai dati {#regr-ml}



\begin{Summary}
In questo Capitolo verranno esposte alcune nozioni matematiche che
stanno alla base dell'inferenza per i modelli di regressione e un po' di
algebra che ci aiuterà a comprendere la stima della regressione lineare.
Spiegheremo anche la logica per l'uso della funzione bayesiana
\texttt{brm()} e la sua connessione con la regressione lineare classica.
\end{Summary}


## Minimi quadrati

Nel modello di regressione lineare classico, $y_i = a + b x_i + \varepsilon_i$, i coefficienti $a$ e $b$ sono stimati in modo tale da minimizzare gli errori $\varepsilon_i$. Se il numero dei dati $n$ è maggiore di 2, non è generalmente possibile trovare una retta che passi per tutte le osservazioni ($x, y$) (sarebbe $y_i = a + b x_i$, senza errori, per tutti i punti $i = 1, \dots, n$). L'obiettivo della stima dei minimi quadrati è quello di scegliere i valori ($\hat{a}, \hat{b}$) che minimizzano la somma dei quadrati dei residui,
\begin{equation}
e_i = y_i − (\hat{a} + \hat{b} x_i)\,.
\end{equation}
Distinguiamo tra i residui $e_i = y_i - (\hat{a} + \hat{b} x_i)$ e gli *errori* $\varepsilon_i = y_i − (a + b x_i)$. Il modello di regressione è scritto in termini degli errori, ma possiamo solo lavorare con i residui: non possiamo calcolare gli errori perché per farlo sarebbe necessario conoscere i parametri ignoti $a$ e $b$.

La somma dei residui quadratici (_residual sum of squares_) è
\begin{equation}
\text{RSS} = \sum_{i=1}^n (y_i = (\hat{a} + \hat{b} x_i))^2\,.
\end{equation}
I coefficienti ($\hat{a}, \hat{b}$) che minimizzano RSS sono chiamati stime dei minimi quadrati, o minimi quadrati ordinari (_ordinari least squares_), o stime OLS. 

### Stima della deviazione standard dei residui $\sigma$

Nel modello di regressione, gli errori $\varepsilon_i$ provengono da una distribuzione con media 0 e deviazione standard $\sigma$: la media è zero per definizione (qualsiasi media diversa da zero viene assorbita nell'intercetta, $a$), e  la deviazione standard degli errori può essere stimata dai dati. Un modo apparentemente naturale per stimare $\sigma$ potrebbe essere quello di calcolare la deviazione standard dei residui, $\sqrt{\frac{1}{n} \sum_{i=1}^n e_i^2} = \sqrt{ \frac{1}{n} \sum_{i=1}^n y_i - (\hat{a} + \hat{b} x_i))^2}$, ma questo approccio finisce per sottostimare $\sigma$.
<!-- a causa del *overfitting*, in quanto i coefficienti $\hat{a}$ e $\hat{b}$ sono stati stimati dai dati per minimizzare la somma dei residui quadratici.   -->
La correzione standard di questa sottostima consiste nel sostituire $n$ con $n - 2$ al denominatore (la sottrazione di 2 deriva dal fatto che il valore atteso della regressione è stato calcolato utilizzando i due coefficienti nel modello, l'intercetta e la pendenza, i quali sono stati stimati dai dati campionari -- si dice che, in questo modo, abbiamo perso due gradi di libertà). Così facendo otteniamo
\begin{equation}
\hat{\sigma} = \sqrt{\frac{1}{n-2} \sum_{i=1}^n (y_i - (\hat{a} + \hat{b} x_i))^2}\,.
\end{equation}
Quando $n = 1$ o $2$ l'equazione precedente è priva di significato, il che ha senso: con solo due osservazioni è possibile adattare esattamente una retta al diagramma di dispersione e quindi non c'è modo di stimare l'errore dai dati. 


## Calcolare la somma dei quadrati

Seguendo [Solomon Kurz](https://github.com/ASKurz/Working-through-Regression-and-other-stories/blob/main/08.Rmd), creiamo una funzione per calcolare la somma dei quadrati per diversi valori di $a$ e $b$:


```r
rss <- function(x, y, a, b) {  
  # x and y are vectors, 
  # a and b are scalars 
  resid <- y - (a + b * x)
  return(sum(resid^2))
  }
```

Useremo i dati ....

```r
df <- read.dta(here("data", "kidiq.dta"))
head(df)
#>   kid_score mom_hs mom_iq mom_work mom_age
#> 1        65      1  121.1        4      27
#> 2        98      1   89.4        4      25
#> 3        85      1  115.4        4      27
#> 4        83      1   99.4        3      25
#> 5       115      1   92.7        4      27
#> 6        98      0  107.9        1      18
```

Nell'esempio, `kid_score` è la variabile $y$ e `mom_iq` è il predittore. Le stime dei minimi quadrati sono fornite dalla funzione `lm()`:


```r
fm <- lm(kid_score ~ mom_iq, data = df)
fm %>%
  tidy() %>% 
  filter(term == c("(Intercept)", "mom_iq")) %>% 
  pull(estimate)
#> [1] 25.80  0.61
```

Calcoliamo la somma dei residui quadratici in base al modello di regressione $\hat{y}_i = 25.8 + 0.61 x_i$:


```r
rss(df$mom_iq, df$kid_score, 25.8, 0.61)
#> [1] 144137
```

Esploriamo ora i valori assunti da $rss$ per diversi valori di $a$ e $b$. Per iniziare, utilizziamo un vettore di valori `a`, mantenendo costante `b = 0.61`. 


```r
# set the global plotting theme
# theme_set(theme_linedraw() +
#             theme(panel.grid = element_blank()))
# simulate
tibble(a = seq(20, 30, length.out = 30)) %>% 
  mutate(
    rss = map_dbl(
      a, 
      rss, 
      x = df$mom_iq, 
      y = df$kid_score,  
      b = 0.61)
    ) %>% 
  
  # plot
  ggplot(aes(x = a, y = rss)) +
  geom_point() +
  labs(subtitle = "Il valore b è tenuto costante (b = 0.61)") 
```



\begin{center}\includegraphics[width=0.8\linewidth]{052_reglin2_files/figure-latex/unnamed-chunk-7-1} \end{center}
Ora variamo sia `a` che `b`, facendo assumere a ciascun parametro un insieme di valori in un intevallo, e rappresentiamo i risultati in una heat map che rappresenta l'intensitè di `rss` in funzione dei valori `a` e `b`.


```r
d <-
  crossing(a = seq(-20, 70, length.out = 400),
           b = seq(-0.2, 1.4, length.out = 400)) %>% 
  mutate(rss = map2_dbl(a, b, rss, x = df$mom_iq, y = df$kid_score))
d %>%
  ggplot(aes(x = a, y = b, fill = rss)) +
  geom_tile() +
  scale_fill_viridis_c("RSS", option = "A") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0))
```



\begin{center}\includegraphics[width=0.8\linewidth]{052_reglin2_files/figure-latex/unnamed-chunk-8-1} \end{center}
Poiché la stima dei minimi quadrati enfatizza il valore RSS minimo, la soluzione che cerchiamo corrisponde alle combinazione di `a` e `b` nell'intervallo più scuro rappresentato nella figura. Tra gli `a` e `b` che abbiamo preso in considerazione, la coppia di valori a cui è associato il minimo valore `rss` si trova nel modo seguente:

```r
d %>% 
  arrange(rss) %>% 
  slice(1)
#> # A tibble: 1 x 3
#>       a     b     rss
#>   <dbl> <dbl>   <dbl>
#> 1  25.8 0.610 144137.
```
Si noti che i valori trovati in questo modo corrispondono alla soluzione fornita nell'output della funzione `lm()`. 


## Massima verosimiglianza 

Se gli errori del modello lineare sono indipendenti e distribuiti normalmente, in modo che $y_i \sim \mathcal{N}(a + b x_i, \sigma^2)$ per ogni $i$, allora la stima ai minimi quadrati di (`a`, `b`) è anche la stima di massima verosimiglianza. La *funzione di verosimiglianza* in un modello di regressione è definita come la densità di probabilità delle osservazioni dati i parametri e i predittori; quindi, in questo esempio,
 $$
 p(y \mid a, b, \sigma, x) = \prod_{i=1}^n \mathcal{N}(y_i \mid a + b x_i, \sigma^2),
 $$

dove $\mathcal{N}(\cdot | \cdot, \cdot)$ è la funzione di densità di probabilità normale,
$$
\mathcal{N}(y \mid \mu, \sigma^2) = \frac{1}{\sqrt{2 \pi \sigma}} \exp \left(-\frac{1}{2} \left( \frac{y - \mu}{\sigma} \right)^2 \right).
$$

Un studio della funzione precedente rivela che la massimizzazione della verosimiglianza richiede la minimizzazione della somma dei quadrati dei residui; quindi la stima dei minimi quadrati $\hat{\beta} = (\hat{a}, \hat{b})$ può essere vista come una stima di massima verosimiglianza nel modello normale:

```r
ll <- function(x, y, a, b) {
  resid <- y - (a + b * x)
  sigma <- sqrt(sum(resid^2) / length(x))
  d <- dnorm(y, mean = a + b * x, sd = sigma, log = TRUE)
  tibble(sigma = sigma, ll = sum(d))
}
```
Calcoliamo dunque le stime di verosimiglianza logaritmica per varie combinazioni di (`a`, `b`), date due colonne di dati, `x` e `y`. La funzione resituisce anche il valore $\hat{\sigma}$.


```r
d <-
  crossing(a = seq(-20, 70, length.out = 200),
           b = seq(-0.2, 1.4, length.out = 200)) %>% 
  mutate(ll = map2(a, b, ll, x = df$mom_iq, y = df$kid_score)) %>% 
  unnest(ll)
p1 <-
  d %>%
  ggplot(aes(x = a, y = b, fill = ll)) +
  geom_tile() +
  scale_fill_viridis_c(option = "A", breaks = NULL) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(subtitle = "Verosimiglianza, p(a, b | y)")
p1
```



\begin{center}\includegraphics[width=0.8\linewidth]{052_reglin2_files/figure-latex/unnamed-chunk-11-1} \end{center}

Le stime di $\hat{a}, \hat{b}$ ottenute mediante il metodo di massima verosimiglianza sono:

```r
d %>% 
  arrange(desc(ll)) %>% 
  slice(1)
#> # A tibble: 1 x 4
#>       a     b sigma     ll
#>   <dbl> <dbl> <dbl>  <dbl>
#> 1  25.7 0.612  18.2 -1876.
```

### Inferenza bayesiana

Usiamo ora la funzione `brms::brm()` per eseguire l'analisi mediante un approccio bayesiano:


```r
m <-
  brm(
    kid_score ~ mom_iq,
    data = df, 
    backend = "cmdstan",
    refresh = 0
  )
#> Running MCMC with 4 chains, at most 8 in parallel...
#> 
#> Chain 1 finished in 0.0 seconds.
#> Chain 2 finished in 0.0 seconds.
#> Chain 3 finished in 0.0 seconds.
#> Chain 4 finished in 0.0 seconds.
#> 
#> All 4 chains finished successfully.
#> Mean chain execution time: 0.0 seconds.
#> Total execution time: 0.3 seconds.
```

Utilizzando i coefficienti calcolati da `brms::brm()`, aggiungiamo la stima della retta di regressione al diagramma di dispersione dei dati:

```r
df %>% 
  ggplot(aes(x = mom_iq, y = kid_score)) +
  geom_point() +
  geom_abline(
    intercept = fixef(m, robust = TRUE)[1, 1], 
    slope = fixef(m, robust = TRUE)[2, 1],
    size = 1/3
  ) +
  annotate(
    geom = "text",
    x = 130, y = 30,
    label = expression(y == 25.7 + 0.61 * x)
  ) +
  labs(
    subtitle = "Dati e retta di regressione",
    x = "x",
    y = "y"
  ) 
```



\begin{center}\includegraphics[width=0.8\linewidth]{052_reglin2_files/figure-latex/unnamed-chunk-14-1} \end{center}

La funzione `brms::posterior_samples()` consente di estrarre molti campioni dalla distribuzione a posteriori del modello `m`. In questo modo otteniamo un vettore di valori per ciascuno dei tre parametri, i quali, in questo output sono chiamati `b_Intercept`, `b_mom_iq` e `sigma`. Abbiamo quindi usato `slice_sample()` per ottenere un sottoinsieme casuale di 50 righe. Per semplicità, qui ne stampiamo solo 5.


```r
set.seed(8)

posterior_samples(m) %>% 
  slice_sample(n = 5)
#>   b_Intercept b_mom_iq sigma Intercept  lp__
#> 1        18.7    0.671  19.2      85.8 -1883
#> 2        20.4    0.663  17.9      86.7 -1881
#> 3        33.3    0.546  18.5      87.8 -1882
#> 4        25.5    0.620  18.3      87.5 -1881
#> 5        29.0    0.577  18.2      86.7 -1881
```

Possiamo interpretare i valori `b_Intercept`, `b_mom_iq` come un insieme di valori credibili per i parametri $a$ e $b$. Dati questi valori credibili per i parametri del modello di regressione, possiamo aggiungere al diagramma a dispersione 50 stime possibili della retta di regressione, alla luce dei dati osservati.


```r
set.seed(8)

posterior_samples(m) %>% 
  slice_sample(n = 50) %>% 
  
  ggplot() +
  geom_abline(
    aes(intercept = b_Intercept, slope = b_mom_iq),
        size = 1/4, alpha = 1/2, color = "grey25") +
  geom_point(
    data = df,
    aes(x = mom_iq, y = kid_score)
  ) +
  labs(
    subtitle = "Dati e possibili rette di regressione",
    x = "x",
    y = "y"
  ) 
```



\begin{center}\includegraphics[width=0.8\linewidth]{052_reglin2_files/figure-latex/unnamed-chunk-16-1} \end{center}

I minimi quadrati o la massima verosimiglianza trovano i parametri che meglio si adattano ai dati (secondo un criterio prestabilito), ma senza altrimenti vincolare o guidare l'adattamento. Ma di solito abbiamo informazioni preliminari sui parametri del modello. L'inferenza bayesiana produce un compromesso tra informazioni a priori e i dati, moltiplicando la verosimiglianza con una distribuzione a priori che codifica probabilisticamente le informazioni esterne sui parametri. Il prodotto della verosimiglianza $p(y \mid a, b, \sigma)$ e della distribuzione a priori è chiamato _distribuzione a posteriori_ e, dopo aver visto i dati, riassume la nostra credenza sui valori dei parametri. 

La soluzione dei minimi quadrati fornisce una stima puntuale dei coefficienti che producono il miglior adattamento complessivo ai dati. Per un modello bayesiano, la corrispondente stima puntuale è la moda a posteriori, la quale fornisce il miglior adattamento complessivo ai dati e alla distribuzione a priori. La stima dei minimi quadrati o di massima verosimiglianza è la moda a posteriori corrispondente al modello bayesiano che utilizza una distribuzione a priori uniforme.

Ma non vogliamo solo una stima puntuale; vogliamo anche una misura dell'incertezza della stima. La figura precedente fornisce, in forma grafica, una descrizione di tale incertezza.

Gli intervalli di credibilità al 95% si ottengono nel modo seguente: 

```r
print(m, robust = TRUE)
#>  Family: gaussian 
#>   Links: mu = identity; sigma = identity 
#> Formula: kid_score ~ mom_iq 
#>    Data: df (Number of observations: 434) 
#>   Draws: 4 chains, each with iter = 1000; warmup = 0; thin = 1;
#>          total post-warmup draws = 4000
#> 
#> Population-Level Effects: 
#>           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
#> Intercept    25.83      5.80    14.44    37.47 1.00     3329     3005
#> mom_iq        0.61      0.06     0.49     0.72 1.00     3310     3009
#> 
#> Family Specific Parameters: 
#>       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
#> sigma    18.26      0.61    17.13    19.53 1.00     3824     3105
#> 
#> Draws were sampled using sample(hmc). For each parameter, Bulk_ESS
#> and Tail_ESS are effective sample size measures, and Rhat is the potential
#> scale reduction factor on split chains (at convergence, Rhat = 1).
```

In alternativa, è possibile usare la funzione `posterior_interval()`:

```r
posterior_interval(m)
#>                  2.5%     97.5%
#> b_Intercept    14.445    37.471
#> b_mom_iq        0.495     0.722
#> sigma          17.132    19.529
#> Intercept      85.119    88.563
#> lp__        -1885.190 -1880.580
```




