# Regressione lineare in Stan {#reg-lin-stan}




## La specificazione del modello in linguaggio Stan

Obiettivo di questo Capitolo è illustrare come svolgere l'analisi di regressione  bayesiana usando il linguaggio Stan.^[Una descrizione dell'approccio frequentista all'analisi di regressione è fornita nell'Appendice \@ref(regr-lin-frequentista).] Per fare un esempio concreto useremo un famoso dataset chiamato `kidiq` [@gelman2020regression] che riporta i dati di un'indagine del 2007 su un campione di donne americane adulte e sui loro bambini di età compres tra i 3 e i 4 anni. I dati sono costituiti da 434 osservazioni e 4 variabili:

- `kid_score`: QI del bambino; è il punteggio totale del _Peabody Individual Achievement Test_ (PIAT) costituito dalla somma dei punteggi di tre sottoscale (Mathematics, Reading comprehension, Reading recognition);
- `mom_hs`: variabile dicotomica (0 or 1) che indica se la madre del bambino ha completato le scuole superiori (1) oppure no (0);
- `mom_iq`: QI della madre;
- `mom_age`: età della madre.

Leggiamo i dati in \R:


```r
library("foreign")
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

Calcoliamo alcune statistiche descrittive:


```r
summary(df)
#>    kid_score         mom_hs          mom_iq         mom_work      mom_age    
#>  Min.   : 20.0   Min.   :0.000   Min.   : 71.0   Min.   :1.0   Min.   :17.0  
#>  1st Qu.: 74.0   1st Qu.:1.000   1st Qu.: 88.7   1st Qu.:2.0   1st Qu.:21.0  
#>  Median : 90.0   Median :1.000   Median : 97.9   Median :3.0   Median :23.0  
#>  Mean   : 86.8   Mean   :0.786   Mean   :100.0   Mean   :2.9   Mean   :22.8  
#>  3rd Qu.:102.0   3rd Qu.:1.000   3rd Qu.:110.3   3rd Qu.:4.0   3rd Qu.:25.0  
#>  Max.   :144.0   Max.   :1.000   Max.   :138.9   Max.   :4.0   Max.   :29.0
```

Il QI medio dei bambini è di circa 87 mentre quello della madre è di 100. La gamma di età delle madri va da 17 a 29 anni con una media di circa 23 anni. Si noti infine che il 79% delle mamme ha un diploma di scuola superiore.

Ci poniamo il problema di descrivere l'associazione tra il QI dei figli e il QI delle madri mediante un modello di regressione lineare. Per farci un'idea del valore dei parametri, adattiamo il modello di regressione ai dati mediante la procedura di massima verosimiglianza:


```r
coef(lm(kid_score ~ mom_iq, data = df))
#> (Intercept)      mom_iq 
#>       25.80        0.61
```

Il modello statistico bayesiano di regressione lineare è:
$$
\begin{aligned}
y_i &\sim \mathcal{N}(\mu_i, \sigma) \\
\mu_i &= \alpha + \beta x_i \\
\alpha &\sim \mathcal{N}(25, 10) \\
\beta &\sim \mathcal{N}(0, 1) \\
\sigma &\sim \text{Cauchy}(18, 5) 
\end{aligned}
$$
La prima riga definisce la funzione di verosimiglianza e righe successive definiscono le distribuzioni a priori dei parametri. Il segno $\sim$ (tilde) si può leggere "si distribuisce come". La prima riga, dunque, ci dice che ciascuna osservazione $y_i$ è una variabile casuale che segue la distribuzione Normale di parametri $\mu_i$ e $\sigma$. La seconda riga specifica, in maniera deterministica, che ciascun $\mu_i$ è una funzione lineare di $x_i$, con parametri $\alpha$ e $\beta$. Le due righe successive specificano le distribuzioni a priori per $\alpha$ e $\beta$; per $\alpha$, la distribuzione a priori è una distribuzione Normale di parametri $\mu_{\alpha} = 25$ e deviazione standard $\sigma_{\alpha} = 10$; per  $\beta$, la distribuzione a priori è una distribuzione Normale standardizzata. L'ultima riga definisce la la distribuzione a priori di $\sigma$, ovvero una Cauchy di parametri 18 e 5.

Poniamoci ora il problema di specificare il modello bayesiano descritto sopra in linguaggio Stan^[Nella discussione che segue ripeto pari pari ciò che è riportato nel manuale del linguaggio [Stan](https://mc-stan.org/docs/2_27/stan-users-guide/standardizing-predictors-and-outputs.html).]. Il codice Stan viene eseguito più velocemente se l'input è standardizzato così da avere una media pari a zero e una varianza unitaria.^[Si noti un punto importante. Il fatto di standardizzare i dati fa in modo che le distribuzioni a priori sui parametri andranno espresse sulla scala delle v.c. normali standardizzate.  Se centriamo sullo 0 tali distribuzioni a priori, con una deviazione standard dell'ordine di grandezza dell'unità, i discorsi sull'arbitrarietà delle distribuzioni a priori perdono di significato: nel caso di dati standardizzati le distribuzioni a priori formulate come indicato sopra sono sicuramente distribuzioni vagamente informative il cui unico scopo è quello della regolarizzazione dei dati, ovvero l'obiettivo di mantenere le inferenze in una gamma ragionevole di valori; ciò contribuisce nel contempo a limitare l'influenza eccessiva delle osservazioni estreme (valori anomali) --- certamente tali distribuzioni a priori non introducono alcuna distorsione sistematica nella stima a posteriori.] 
<!-- Poniamoci dunque il problema di eseguire il campionamento MCMC sulle variabili standardizzate per poi riconvertire i parametri trovati sulla stessa scala di misura dei punteggi grezzi.  -->
Ponendo $y = (y_1, \dots, y_n)$ e $x = (x_1, \dots, x_n)$, il modello di regressione può essere scritto come 
$$
y_i = \alpha + \beta x_i + \varepsilon_i,
$$
\noindent
dove 
$$
\varepsilon_i \sim \mathcal{N}(0, \sigma).
$$

<!-- Se uno dei due vettori $x$ o $y$ ha valori molto grandi o molto piccoli o se la media campionaria dei valori è lontana da 0, allora può essere più efficiente standardizzare la variabile risposta $y$ e i predittori $x$.  -->
I dati devono essere prima centrati sottraendo la media campionaria, quindi scalati dividendo per la deviazione standard campionaria. Quindi un'osservazione $u$ viene standardizzata dalla funzione $z$ definita da
$$
z_y(u) = \frac{u - \bar{y}}{\texttt{sd}(y)}
$$
\noindent
dove la media $\bar{y}$ è
$$
\bar{y} = \frac{1}{n} \sum_{i=1}^n y_i,
$$
\noindent
e la deviazione standard è
$$
\texttt{sd} = \left(\frac{1}{n}\sum_{i=1}^n(y_i - \bar{y})^2\right)^{-\frac{1}{2}}.
$$

La trasformata inversa è definita invertendo i due passaggi precedenti, ovvero usando la deviazione standard per scalare di nuovo i valori $u$ per poi traslarli con la media campionaria:
$$
z_y^{-1}(u) = \texttt{sd}(y)u + \bar{y}.
$$

<!-- La standardizzazione eseguita all'interno del codice Stan per l'analisi di regressione cambia la scala delle variabili, e quindi cambia anche la scala delle distribuzioni a priori dei parametri.  -->
Consideriamo il seguente modello iniziale nel linguaggio Stan:


```r
modelString <- "
data {
  int<lower=0> N;
  vector[N] y;
  vector[N] x;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  // priors
  alpha ~ normal(25, 10);
  beta ~ normal(0, 1);
  sigma ~ cauchy(18, 5);
  // likelihood
  for (n in 1:N)
    y[n] ~ normal(alpha + beta * x[n], sigma);
}
"
writeLines(modelString, con = "code/simpleregkidiq.stan")
```
\noindent
La funzione `modelString()` registra una stringa di testo mentre `writeLines()` crea un file nell'indirizzo specificato. Tale file deve avere l'estensione `.stan`. 

Qui sotto è invece riportato il modello per i dati standardizzati. Il blocco `data` è identico a quello del caso precedente. I predittori e la risposta standardizzati sono definiti nel blocco `transformed data`. Per semplificare la notazione (e per velocizzare l'esecuzione), nel blocco `model` l'istruzione di campionamento è espressa in forma vettorializzata: `y_std ~ normal(alpha_std + beta_std * x_std, sigma_std);`.


```r
modelString <- "
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
}
model {
  alpha_std ~ normal(0, 2);
  beta_std ~ normal(0, 2);
  sigma_std ~ cauchy(0, 2);
  y_std ~ normal(alpha_std + beta_std * x_std, sigma_std);
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
writeLines(modelString, con = "code/simpleregstd.stan")
```
Si noti che i parametri vengono rinominati per indicare che non sono i parametri "naturali", ma per il resto il modello è identico. Le distribuzioni a priori per i parametri sono vagamente informative. 

I parametri originali possono essere recuperati con un po' di algebra. 

\begin{align}
y_n &= \textrm{z}_y^{-1}(\textrm{z}_y(y_n)) \notag\\
    &= \textrm{z}_y^{-1}
\left( \alpha' + \beta' \textrm{z}_x(x_n) + \epsilon_n' \right) \notag\\
    &= \textrm{z}_y^{-1}
\left( \alpha' + \beta' \left( \frac{x_n - \bar{x}}{\texttt{sd}(x)} \right) + \epsilon_n' \right) \notag\\
    &= \texttt{sd}(y)
\left( \alpha' + \beta' \left( \frac{x_n - \bar{x}}{\texttt{sd}(x)} \right) + \epsilon_n' \right) + \bar{y} \notag\\
    &=
\left( \texttt{sd}(y) \left( \alpha' - \beta' \frac{\bar{x}}{\texttt{sd}(x)} \right) + \bar{y} \right)
+ \left( \beta' \frac{\texttt{sd}(y)}{\texttt{sd}(x)} \right) x_n
+ \texttt{sd}(y) \epsilon'_n,
\end{align}

\noindent
da cui
$$
\alpha
=
\texttt{sd}(y)
      \left(
          \alpha'
          - \beta' \frac{\bar{x}}{\texttt{sd}(x)}
      \right)
  + \bar{y};
\qquad
\beta = \beta' \frac{\texttt{sd}(y)}{\texttt{sd}(x)};
\qquad
\sigma = \texttt{sd}(y) \sigma'.
$$
\noindent
I valori dei parametri sulle scale originali vengono calcolati nel blocco `generated quantities`.

Per svolgere l'analisi bayesiana sistemiamo i dati nel formato appropriato per Stan:

```r
data_list <- list(
  N = length(df$kid_score),
  y = df$kid_score,
  x = df$mom_iq
)
```
\noindent
La funzione `file.path()` ritorna l'indirizzo del file con il codice Stan:

```r
file <- file.path("code", "simpleregstd.stan")
```
\noindent
Prendendo come input un file contenente un programma Stan, la funzione `cmdstan_model()` ritorna un oggetto di classe `CmdStanModel`. In pratica, `CmdStan` traduce un programma Stan in C++ e crea un eseguibile compilato. 

```r
mod <- cmdstan_model(file)
```
\noindent
Il codice Stan può essere stampato usando il metodo `$print()`:

```r
mod$print()
#> 
#> data {
#>   int<lower=0> N;
#>   vector[N] y;
#>   vector[N] x;
#> }
#> transformed data {
#>   vector[N] x_std;
#>   vector[N] y_std;
#>   x_std = (x - mean(x)) / sd(x);
#>   y_std = (y - mean(y)) / sd(y);
#> }
#> parameters {
#>   real alpha_std;
#>   real beta_std;
#>   real<lower=0> sigma_std;
#> }
#> model {
#>   alpha_std ~ normal(0, 2);
#>   beta_std ~ normal(0, 2);
#>   sigma_std ~ cauchy(0, 2);
#>   y_std ~ normal(alpha_std + beta_std * x_std, sigma_std);
#> }
#> generated quantities {
#>   real alpha;
#>   real beta;
#>   real<lower=0> sigma;
#>   alpha = sd(y) * (alpha_std - beta_std * mean(x) / sd(x))
#>            + mean(y);
#>   beta = beta_std * sd(y) / sd(x);
#>   sigma = sd(y) * sigma_std;
#> }
```
\noindent
L'indirizzo dell'eseguibile compilato viene ritornato da `$exe_file()`:

```r
mod$exe_file()
#> [1] "/Users/corrado/_repositories/dspp/code/simpleregstd"
```

Applicando il metodo `$sample()` ad un oggetto `CmdStanModel` eseguiamo il campionamento MCMC: 

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
\noindent
Al metodo `$sample()` possono essere passati molti argomenti. La pagina di documentazione è disponibile al seguente [link](https://mc-stan.org/cmdstanr/reference/model-method-sample.html).

Un sommario della distribuzione a posteriori per i parametri stimati si ottiene con il metodo `$summary()`, il quale chiama la funzione `summarise_draws()` del pacchetto `posterior`:

```r
fit$summary(c("alpha", "beta", "sigma"))
#> # A tibble: 3 x 10
#>   variable   mean median     sd    mad     q5    q95  rhat ess_bulk ess_tail
#>   <chr>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl>    <dbl>    <dbl>
#> 1 alpha    25.8   25.9   5.98   5.97   15.8   35.7    1.00   16460.   11859.
#> 2 beta      0.610  0.609 0.0594 0.0590  0.513  0.709  1.00   16455.   11999.
#> 3 sigma    18.3   18.3   0.616  0.611  17.3   19.3    1.00   16786.   12022.
```
\noindent
Da questo output possiamo valutare rapidamente la convergenza del modello osservando i valori di Rhat per ciascun parametro. Quando questi sono pari o vicini a 1, le catene hanno realizzato la convergenza. Ci sono molti altri test diagnostici, ma questo test è importante per Stan.

Oppure è possibile usare:

```r
fit$cmdstan_summary()
```

Le statistiche diagnostiche sono fornite dal metodo `$cmdstan_diagnose()`:

```r
fit$cmdstan_diagnose()
#> Processing csv files: /var/folders/hl/dt523djx7_q7xjrthzjpdvc40000gn/T/RtmpOPzI0G/simpleregstd-202111250808-1-9446f6.csv, /var/folders/hl/dt523djx7_q7xjrthzjpdvc40000gn/T/RtmpOPzI0G/simpleregstd-202111250808-2-9446f6.csv, /var/folders/hl/dt523djx7_q7xjrthzjpdvc40000gn/T/RtmpOPzI0G/simpleregstd-202111250808-3-9446f6.csv, /var/folders/hl/dt523djx7_q7xjrthzjpdvc40000gn/T/RtmpOPzI0G/simpleregstd-202111250808-4-9446f6.csv
#> 
#> Checking sampler transitions treedepth.
#> Treedepth satisfactory for all transitions.
#> 
#> Checking sampler transitions for divergences.
#> No divergent transitions found.
#> 
#> Checking E-BFMI - sampler transitions HMC potential energy.
#> E-BFMI satisfactory.
#> 
#> Effective sample size satisfactory.
#> 
#> Split R-hat values satisfactory all parameters.
#> 
#> Processing complete, no problems detected.
```

È anche possibile creare un oggetto di classe `stanfit`

```r
stanfit <- rstan::read_stan_csv(fit$output_files())
```
\noindent
per poi utilizzare le funzioni del pacchetto `bayesplot`:

```r
stanfit %>%
  mcmc_trace(pars = c("alpha", "beta", "sigma"))
```



\begin{center}\includegraphics[width=0.8\linewidth]{053_reglin3_files/figure-latex/unnamed-chunk-17-1} \end{center}

Infine, eseguendo la funzione `launch_shinystan(fit)` è possibile analizzare oggetti di classe `stanfit` mediante le funzionalità del pacchetto `ShinyStan`.


## Interpretazione dei parametri

Assegnamo ai parametri la seguente interpretazione.

- L'intercetta pari a 25.8 indica il QI medio dei bamini la cui madre ha un QI = 0. Ovviamente questo non ha alcun significato. Vedremo nel modello successivo come trasformare il modello in modo da potere assegnare all'intercetta un'interpretazione sensata.
- La pendenza di 0.61 indica che, all'aumentare di un punto del QI delle madri, il QI medio dei loro bambini aumenta di 0.61 unità. Se consideriamo la gamma di variazione del QI delle madri nel campione, il QI medio dei bambini cambia di 41 punti. Questo  indica un sostanziale effetto del QI delle madri sul QI dei loro bambini:

```r
(138.89 - 71.04) * 0.61
#> [1] 41.4
```

- Il parametro $\sigma$ fornisce una stima della dispersione delle osservazioni attorno al valore predetto dal modello di regressione, ovvero fornisce una stima della deviazione standard dei residui attorno alla retta di regressione.


### Centrare i predittori

Per migliorare l'interpretazione dell'intercetta possiamo "centrare" la $x$, ovvero esprimere la $x$ nei termini di scarti dalla media: $x - \bar{x}$. In tali circostanze, la pendenza della retta di regressione resterà immutata, ma l'intercetta corrisponderà a $\E(y \mid x = \bar{x})$. Per ottenere questo risultato, modifichiamo i dati da passare a Stan:


```r
data2_list <- list(
  N = length(df$kid_score),
  y = df$kid_score,
  x = df$mom_iq - mean(df$mom_iq)
)
```

\noindent
Adattiamo il modello:


```r
fit2 <- mod$sample(
  data = data2_list,
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
Trasformiamo l'oggetto `fit` in un oggetto di classe `stanfit`:

```r
stanfit <- rstan::read_stan_csv(fit2$output_files())
```
\noindent
Le stime a posteriori dei parametri si ottengono con

```r
fit2$summary(c("alpha", "beta", "sigma"))
#> # A tibble: 3 x 10
#>   variable   mean median     sd    mad     q5    q95  rhat ess_bulk ess_tail
#>   <chr>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl>    <dbl>    <dbl>
#> 1 alpha    86.8   86.8   0.872  0.863  85.4   88.2    1.00   16613.   12276.
#> 2 beta      0.610  0.609 0.0591 0.0592  0.512  0.708  1.00   17947.   12419.
#> 3 sigma    18.3   18.3   0.616  0.616  17.3   19.3    1.00   16622.   11073.
```
\noindent
Si noti che la nuova intercetta, ovvero 86.8, corrisponde al QI medio dei bambini le cui madri hanno un QI pari alla media del campione. Centrare i dati consente dunque di assegnare un'interpretazione utile all'intercetta.


<!-- ### Rappresentazione grafica dell'incertezza della stima -->

<!-- Mediante la funzione `extract()` salvo le stime a posteriori dei parametri in  formato `list`: -->
<!-- ```{r} -->
<!-- stanfit <- rstan::read_stan_csv(fit2$output_files()) -->
<!-- posterior <- extract(stanfit) -->
<!-- ``` -->
<!-- \noindent -->
<!-- Un diagramma a dispersione dei dati con sovrapposto il valore atteso della $y$ in base al modello bayesiano si ottiene nel modo seguente: -->
<!-- ```{r} -->
<!-- plot( -->
<!--   df$kid_score ~ I(df$mom_iq - mean(df$mom_iq)),  -->
<!--   pch = 20, -->
<!--   xlab = "mom_iq (centered)", -->
<!--   ylab = "kid_score" -->
<!-- ) -->
<!-- abline(mean(posterior$alpha), mean(posterior$beta), col = 6, lw = 2) -->
<!-- ``` -->
<!-- \noindent -->
<!-- Un modo per visualizzare l'incertezza della stima della retta di regressione è quello di tracciare molteplici rette di regressione, ciascuna delle quali definita da una diversa stima dei parametri $\alpha$ e $\beta$ che vengono estratti a caso dalle rispettive distribuzioni a posteriori. -->
<!-- ```{r} -->
<!-- plot( -->
<!--   df$kid_score ~ I(df$mom_iq - mean(df$mom_iq)),  -->
<!--   pch = 20, -->
<!--   xlab = "mom_iq (centered)", -->
<!--   ylab = "kid_score" -->
<!-- ) -->
<!-- for (i in 1:50) { -->
<!--  abline(posterior$alpha[i], posterior$beta[i], col = "gray", lty = 1) -->
<!-- } -->
<!-- abline(mean(posterior$alpha), mean(posterior$beta), col = 6, lw = 2) -->
<!-- ``` -->
