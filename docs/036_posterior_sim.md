# Approssimazione della distribuzione a posteriori {#metropolis}



In questo Capitolo ci occuperemo di metodi numerici per l'approssimazione della distribuzione a posteriori. 

## Stima della distribuzione a posteriori

In un problema bayesiano i dati $y$ provengono da una densità $p(y \mid \theta)$ e al parametro $\theta$ viene assegnata una densità a priori $p(\theta)$. Dopo avere osservato un campione $Y = y$, la funzione di verosimiglianza è uguale a $\mathcal{L}(\theta) = p(y \mid \theta)$ e la densità a posteriori diventa
\begin{equation}
p(\theta \mid y) = \frac{p(\theta) \mathcal{L}(\theta)}{\int p(\theta) \mathcal{L}(\theta) d \theta}.
\end{equation}
Si noti che, quando usiamo il teorema di Bayes per calcolare la distribuzione a posteriori del parametro di un modello statistico, al denominatore troviamo un integrale 
<!-- Se vogliamo trovare la distribuzione a posteriori con metodi analitici è necessario usare distribuzioni a priori coniugate per la verosimiglianza. Questo però non è sempre giustificato dal punto di vista teorico. -->
<!-- Per quanto "semplice" in termini formali, questo approccio, però, limita di molto le possibili scelte del ricercatore.  -->
<!-- Non è però sempre sensato, dal punto di vista teorico, utilizzare distribuzioni a priori coniugate per la verosimiglianza per i parametri di interesse.  -->
<!-- Però, se usiamo delle distribuzioni a priori non coniutate per la verosimiglianza, ci troviamo in una condizione nella quale, per determinare la distribuzione a posteriori, è necessario calcolare un integrale  -->
che, nella maggior parte dei casi, non si può risolvere analiticamente. In altre parole: è possibile ottenere analiticamente la distribuzione a posteriori solo per alcune specifiche combinazioni di distribuzioni a priori e verosimiglianza, il che limita considerevolmente la flessibilità della modellizzazione. 
<!-- Inoltre, i sommari della distribuzione a posteriori sono espressi come rapporto di integrali. Ad esempio, la media a posteriori di $\theta$ è data da -->
<!-- \begin{equation} -->
<!-- \mathbb{E}(\theta \mid y) = \frac{\int \theta p(\theta) \mathcal{L}(\theta) d \theta}{\int p(\theta) \mathcal{L}(\theta) d \theta}. -->
<!-- \end{equation} -->
<!-- Il calcolo del valore atteso a posteriori richiede dunque la valutazione di due integrali, ciascuno dei quali non esprimibile in forma chiusa.  -->
Per questa ragione, la strada principale che viene seguita nella modellistica bayesiana è quella che porta a determinare la distribuzione a posteriori non per via analitica, ma bensì mediante metodi numerici. La simulazione fornisce dunque la strategia generale del calcolo bayesiano. 

Ci sono molte librerie $\R$ o Python che consentono di stimare la distribuzione a posteriori con metodi numerici, quindi in generale è molto improbabile che un ricercatore abbia bisogno di codificare un proprio algoritmo per risolvere questo problema. Ad oggi ci sono solo due buoni motivi per scrivere il codice che ha lo scopo di approssimare la distribuzione a posteriori per via numerica: o si sta progettando un nuovo metodo che sia in grado di migliorare quelli già esistenti (questo è un tipico problema da informatici o ingegneri) o si sta imparando come funzionano i metodi attuali. Dato che il nostro obiettivo è, appunto, quello di imparare, in questo capitolo vedremo come questo problema possa essere affrontato. Nel resto della dispensa useremo invece i metodi già disponibili nelle librerie $\R$. 

In questo Capitolo esaminando tre diverse tecniche che possono essere utilizzate per calcolare per via numerica la distribuzione a posteriori:

1. il metodo basato su griglia,
2. il metodo dell'approssimazione quadratica,
3. il metodo di Monte Carlo basato su Catena di Markov (MCMC).

## Metodo basato su griglia

Il metodo basato su griglia (_grid-based_) è un metodo di approsimazione numerica basato su una griglia di punti uniformemente spaziati. Anche se la maggior parte dei parametri è continua (ovvero, in linea di principio ciascun parametro può assumere un numero infinito di valori), possiamo ottenere un'eccellente approssimazione della distribuzione a posteriori considerando solo una griglia finita di valori dei parametri. In un tale metodo, la densità di probabilità a posteriori può dunque essere approssimata tramite le densità di probabilità calcolate in ciascuna cella della griglia.

Il metodo basato su griglia si sviluppa in quattro fasi:

- fissare una griglia discreta di possibili valori $\theta$;^[È chiaro che, per ottenere buone approssimazioni, è necessaria una griglia molto densa.]
- valutare la distribuzione a priori $p(\theta)$ e la funzione di verosimiglianza $\mathcal{L}(y \mid \theta)$ in corrispondenza di ciascun valore $\theta$ della griglia;
- ottenere un'approssimazione discreta della densità a posteriori: 
  - per ciascun valore $\theta$ della griglia, calcolare il prodotto $p(\theta) \mathcal{L} (y \mid \theta)$; 
  - normalizzare i prodotti così ottenuti in modo tale che la loro somma sia 1;
- selezionare $N$ valori casuali della griglia in modo tale da ottenere un campione casuale delle densità a posteriori normalizzate.

Possiamo migliorare l'approssimazione aumentando il numero di punti della griglia. Infatti utilizzando un numero infinito di punti si otterrebbe la descrizione esatta della distribuzione a posteriori, dovendo però pagare il costo dell'utilizzo di infinite risorse di calcolo. Il limite maggiore dell'approccio basato su griglia è che al crescere della dimensionalità $N$ dello spazio dei parametri i punti della griglia necessari per avere una buona stima crescerebbero esponenzialmente con $N$, rendendo questo metodo inattuabile.

### Modello Beta-Binomiale

Per fare un esempio, consideriamo il modello Beta-Binomiale di cui conosciamo la soluzione esatta. Supponiamo di avere osservato 9 sucessi in 10 prove Bernoulliane indipendenti.^[La discussione del modello Beta-Binomiale segue molto da vicino la presentazione di @Johnson2022bayesrules utilizzando anche lo stesso codice \R.] Imponiamo alla distribuzione a priori su $\theta$ (proabilità di successo in una singola prova) una Beta(2, 2) per descrivere la  nostra incertezza sul parametro prima di avere osservato i dati. Dunque, il modello diventa:
\begin{align}
Y \mid \theta & \sim \text{Bin}(10, \pi) \notag\\
\theta & \sim \mbox{Beta}(2, 2).\notag
\end{align}
In queste circostanze, l'aggiornamento bayesiano produce una distribuzione a posteriori Beta di parametri 11 ($y + \alpha$ = 9 + 2) e 3 ($n - y + \beta$ = 10 - 9 + 2):
\begin{equation}
\theta \mid (y = 9) \sim \mbox{Beta}(11, 3).\notag
\end{equation}
Per approssimare la distribuzione a posteriori, fissiamo una griglia di $n = 6$ valori equispaziati: $\theta \in \{0, 0.2, 0.4, 0.6, 0.8, 1\}$ (in seguito aumenteremo $n$):


```r
grid_data <- tibble(
  theta_grid = seq(from = 0, to = 1, length = 6)
)
```

\noindent
In corrispondenza di ciascun valore della griglia, valutiamo la distribuzione a priori $\mbox{Beta}(2, 2)$ e la verosimiglianza $\Bin(10, \theta)$ con $y = 9$.


```r
grid_data <- grid_data %>%
  mutate(
    prior = dbeta(theta_grid, 2, 2),
    likelihood = dbinom(9, 10, theta_grid)
  )
```

\noindent
In ciascuna cella della griglia calcoliamo poi il prodotto della verosimiglianza e della distribuzione a priori. Troviamo così un'approssimazione discreta e non normalizzata della distribuzione a posteriori (`unnormalized`). Normalizziamo infine questa approssimazione dividendo ciascun valore del vettore `unnormalized` per la  somma di tutti i valori del vettore:


```r
grid_data <- grid_data %>%
  mutate(
    unnormalized = likelihood * prior,
    posterior = unnormalized / sum(unnormalized)
  )
```

\noindent
La somma dei valori così trovati sarà uguale a 1:


```r
grid_data %>%
  summarize(
    sum(unnormalized),
    sum(posterior)
  )
#> # A tibble: 1 × 2
#>   `sum(unnormalized)` `sum(posterior)`
#>                 <dbl>            <dbl>
#> 1               0.318                1
```

\noindent
Abbiamo dunque ottenuto la seguente distribuzione a posteriori discretizzata $p(\theta \mid y)$:


```r
round(grid_data, 2)
#> # A tibble: 6 × 5
#>   theta_grid prior likelihood unnormalized posterior
#>        <dbl> <dbl>      <dbl>        <dbl>     <dbl>
#> 1        0    0          0            0         0   
#> 2        0.2  0.96       0            0         0   
#> 3        0.4  1.44       0            0         0.01
#> 4        0.6  1.44       0.04         0.06      0.18
#> 5        0.8  0.96       0.27         0.26      0.81
#> 6        1    0          0            0         0
```

\noindent
La figura \@ref(fig:grid-method-6points-posterior-plot) mostra un grafico della distribuzione a posteriori discretizzata che è stata ottenuta:


```r
grid_data %>% 
  ggplot(
    aes(x = theta_grid, y = posterior)
  ) +
  geom_point() +
  geom_segment(
    aes(
      x = theta_grid, 
      xend = theta_grid, 
      y = 0, 
      yend = posterior)
  )
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/grid-method-6points-posterior-plot-1} 

}

\caption{Distribuzione a posteriori discretizzata ottenuta con il metodo grid-based per $y$ = 9 successi in 10 prove Bernoulliane, con distribuzione a priori $\mbox{Beta}(2, 2)$. È stata utilizzata una griglia di solo $n$ = 6 punti.}(\#fig:grid-method-6points-posterior-plot)
\end{figure}

\noindent
L'ultimo passo della simulazione è il campionamento dalla distribuzione a posteriori discretizzata:


```r
set.seed(84735)
post_sample <- sample_n(
  grid_data,
  size = 1e5,
  weight = posterior,
  replace = TRUE
)
```

\noindent
È facile intuire che i valori estratti con rimessa dalla distribuzione a posteriori discretizzata saranno quasi sempre uguali a 0.6 o 0.8. Questa intuizione è confermata dal grafico \@ref(fig:grid-method-6points-posterior-plot-sampling) a cui è stata sovrapposta la vera distribuzione a posteriori $\mbox{Beta}(11, 3)$:


```r
ggplot(post_sample, aes(x = theta_grid)) +
  geom_histogram(aes(y = ..density..), color = "white") +
  stat_function(fun = dbeta, args = list(11, 3)) +
  lims(x = c(0, 1))
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/grid-method-6points-posterior-plot-sampling-1} 

}

\caption{Campionamento dalla  distribuzione a posteriori discretizzata ottenuta con il metodo grid-based per $y$ = 9 successi in 10 prove Bernoulliane, con distribuzione a priori $\mbox{Beta}(2, 2)$. È stata utilizzata una griglia di solo $n$ = 6 punti.}(\#fig:grid-method-6points-posterior-plot-sampling)
\end{figure}

\noindent
La figura \@ref(fig:grid-method-6points-posterior-plot-sampling) mostra che, con una griglia così sparsa abbiamo ottenuto una versione estremamente approssimata della vera distribuzione a posteriori. Possiamo però ottenere un risultato migliore con una griglia più fine, come indicato dalla figura \@ref(fig:grid-method-100points-posterior-plot-sampling):


```r
grid_data  <- tibble(
  theta_grid = seq(from = 0, to = 1, length.out = 100)
)
grid_data <- grid_data %>%
  mutate(
    prior = dbeta(theta_grid, 2, 2),
    likelihood = dbinom(9, 10, theta_grid)
  )
grid_data <- grid_data %>%
  mutate(
    unnormalized = likelihood * prior,
    posterior = unnormalized / sum(unnormalized)
  )
grid_data %>% 
ggplot(
  aes(x = theta_grid, y = posterior)
) +
  geom_point() +
  geom_segment(
    aes(
      x = theta_grid, 
      xend = theta_grid, 
      y = 0, 
      yend = posterior)
  )
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/grid-method-100points-posterior-plot-sampling-1} 

}

\caption{Distribuzione a posteriori discretizzata ottenuta con il metodo grid-based per $y$ = 9 successi in 10 prove Bernoulliane, con distribuzione a priori $\mbox{Beta}(2, 2)$. È stata utilizzata una griglia di $n$ = 100 punti.}(\#fig:grid-method-100points-posterior-plot-sampling)
\end{figure}

\noindent
Campioniamo ora 10000 punti:


```r
# Set the seed
set.seed(84735)
post_sample <- sample_n(
  grid_data,
  size = 1e4,
  weight = posterior,
  replace = TRUE
)
```

\noindent
Con il campionamento dalla distribuzione a posteriori discretizzata costruita mediante una griglia più densa ($n = 100$) otteniamo un risultato soddisfacente (figura \@ref(fig:grid-method-100points-posterior-plot-and-correct-posterior)): ora la distribuzione dei valori prodotti dalla simulazione approssima molto bene la corretta distribuzione a posteriori $p(\theta \mid y) = \mbox{Beta}(11, 3)$.


```r
post_sample %>%
  ggplot(aes(x = theta_grid)) +
  geom_histogram(
    aes(y = ..density..), 
    color = "white", 
    binwidth = 0.05
  ) +
  stat_function(fun = dbeta, args = list(11, 3)) +
  lims(x = c(0, 1))
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/grid-method-100points-posterior-plot-and-correct-posterior-1} 

}

\caption{Campionamento dalla  distribuzione a posteriori discretizzata ottenuta con il metodo grid-based per $y$ = 9 successi in 10 prove Bernoulliane, con distribuzione a priori $\mbox{Beta}(2, 2)$. È stata utilizzata una griglia di $n$ = 100 punti. All'istogramma è stata sovrapposta la corretta distribuzione a posteriori, ovvero la densità $\mbox{Beta}(11, 3)$.}(\#fig:grid-method-100points-posterior-plot-and-correct-posterior)
\end{figure}

In conclusione, il metodo basato su griglia è molto intuitivo e non richiede particolari competenze di programmazione per essere implementato. Inoltre, fornisce un risultato che, per tutti gli scopi pratici, può essere considerato come un campione casuale estratto da $p(\theta \mid y)$. Tuttavia, anche se tale metodo fornisce risultati accuratissimi, esso ha un uso limitato. A causa della _maledizione della dimensionalità_^[Che cos'è la _maledizione della dimensionalità_? È molto facile da capire. Supponiamo di utilizzare una griglia di 100 punti equispaziati. Nel caso di un solo parametro, sarà necessario calcolare 100 valori. Per due parametri devono essere  calcolari $100^2$ valori. Ma già per 10 parametri avremo bisogno di calcolare $10^{10}$ valori -- è facile capire che una tale quantità di calcoli è troppo grande anche per un computer molto potente. Per modelli che richiedono la stima di un numero non piccolo di parametri è dunque necessario procedere in un altro modo.], tale metodo può solo essere solo nel caso di semplici modelli statistici, con non più di due parametri. Nella pratica concreta tale metodo viene dunque sostituito da altre tecniche più efficienti in quanto, anche nei più comuni modelli utilizzati in psicologia, vengono solitamente stimati centinaia se non migliaia di parametri.

## Approssimazione quadratica

L'approssimazione quadratica è un altro metodo che può essere usato per superare il problema della "maledizione della dimensionalità". La motivazione di tale metodo è la seguente. Sappiamo che, in generale, la regione della distribuzione a posteriori che si trova in prossimità del suo massimo può essere ben approssimata dalla forma di una distribuzione Normale.^[Descrivere la distribuzione a posteriori mediante la distribuzione Normale significa utilizzare un'approssimazione che viene, appunto, chiamata "quadratica" (tale approssimazione si dice quadratica perché il logaritmo di una distribuzione gaussiana forma una parabola e la parabola è una funzione quadratica -- dunque, mediante questa approssimazione descriviamo il logaritmo della distribuzione a posteriori mediante una parabola).]

L'approssimazione quadratica si pone due obiettivi.

1.  Trovare la moda della distribuzione a posteriori. Ci sono varie
    procedure di ottimizzazione, implementate in $\R$, in
    grado di trovare il massimo di una distribuzione.
2.  Stimare la curvatura della distribuzione in prossimità della moda.
    Una stima della curvatura è sufficiente per trovare
    un'approssimazione quadratica dell'intera distribuzione. In alcuni
    casi, questi calcoli possono essere fatti seguendo una procedura
    analitica, ma solitamente vengono usate delle tecniche numeriche.

Una descrizione della distribuzione a posteriori ottenuta mediante l'approssimazione quadratica si ottiene mediante la funzione `quap()` contenuta nel pacchetto `rethinking`:^[Il pacchetto `rethinking` è stato creato da @McElreath_rethinking per accompagnare il suo testo *Statistical Rethinking*$^2$. Per l'installazione si veda <https://github.com/rmcelreath/rethinking>.] 


```r
suppressPackageStartupMessages(library("rethinking"))

mod <- quap(
  alist(
  N ~ dbinom(N + P, p), # verosimiglianza binomiale
  p ~ dbeta(2, 10) # distribuzione a priori Beta(2, 10)
  ),
  data = list(N = 23, P = 7)
)
```

Un sommario dell'approssimazione quadratica è fornito da


```r
precis(mod, prob = 0.95)
#>   mean     sd  2.5% 97.5%
#> p  0.6 0.0775 0.448 0.752
```

Qui sotto è fornito un confronto tra la corretta distribuzione a posteriori (linea continua) e l'approssimazione quadratica (linea trateggiata).


```r
N <- 23
P <- 7
a <- N + 2
b <- P + 10
curve(dbeta(x, a, b), from=0, to=1, ylab="Densità")
# approssimazione quadratica
curve(
  dnorm(x, a/(a+b), sqrt((a*b)/((a+b)^2*(a+b+1)))),
  lty = 2,
  add = TRUE
)
```



\begin{center}\includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/unnamed-chunk-10-1} \end{center}

Il grafico precedente mostra che l'approssimazione quadratica fornisce risultati soddisfacenti. Tali risultati sono simili (o identici) a quelli ottenuti con il metodo _grid-based_, con il vantaggio aggiuntivo di disporre di una serie di funzioni $\R$ in grado di svolgere i calcoli per noi. In realtà, però, l'approssimazione quadratica è poco usata perché, per problemi complessi, è più conveniente fare ricorso ai metodi Monte Carlo basati su Catena di Markov (MCMC) che verranno descritti nel Paragrafo successivo.


## Metodo Monte Carlo {#chapter-simulazioneMC}

I metodi più ampiamente adottati nell'analisi bayesiana per la costruzione della distribuzione a posteriori per modelli complessi sono i metodi di campionamento detti metodi Monte Carlo basati su catena di Markov (_Markov Chain Monte Carlo_, MCMC). Tali metodi consentono di decidere quali distribuzioni a priori e quali distribuzioni di verosimiglianza usare sulla base di considerazioni teoriche soltanto, senza dovere preoccuparsi di altri vincoli. Dato che è basata su metodi computazionalmente intensivi, la stima numerica MCMC della funzione a posteriori può essere svolta soltanto mediante software. In anni recenti i metodi Bayesiani di analisi dei dati sono diventati sempre più popolari proprio perché la potenza di calcolo necessaria per svolgere tali calcoli è ora alla portata di tutti. Questo non era vero solo pochi decenni fa. 

Per introdurre i metodi MCMC consideriamo il caso di una verosimiglianza Binomiale e di una distribuzione a priori Beta. Sappiamo che, in tali circostanze, viene prodotta una distribuzione a posteriori Beta (si veda il capitolo \@ref(chapter-distr-coniugate)). Con una simulazione $\R$ è dunque facile  ricavare dei campioni causali dalla distribuzione a posteriori. Maggiore è il numero di campioni, migliore sarà l'approssimazione della distribuzione a posteriori. 

Consideriamo nuovamente i dati di @zetschefuture2019 (23 "successi" in 30 prove Bernoulliane) e applichiamo a quei dati lo stesso modello del Capitolo \@ref(chapter-distr-coniugate):
\begin{align}
y \mid \theta, n &\sim \Bin(y = 23, n = 30 \mid \theta) \notag\\
\theta_{prior} &\sim \mbox{Beta}(2, 10) \notag\\
\theta_{post}  &\sim \mbox{Beta}(y + a = 23 + 2 = 25, n - y + b = 30 - 23 + 10 = 17), \notag
\end{align}

\noindent
Poniamoci il problema di stimare il valore della media a posteriori di $\theta$.
Nel caso presente, il risultato esatto è
$$
\bar{\theta}_{post} = \frac{\alpha}{\alpha + \beta} = \frac{25}{25 + 17} \approx 0.5952.
$$
Dato che la distribuzione a posteriori di $\theta$ è $\mbox{Beta}(25, 17)$, possiamo estrarre un campione casuale di osservazioni da tale distribuzione e calcolare la media: 


```r
set.seed(7543897)
print(mean(rbeta(1e2, shape1 = 25, shape2 = 17)), 6)
#> [1] 0.587548
```

\noindent
È ovvio che l'approssimazione migliora all'aumentare del numero di osservazioni estratte dalla distribuzione a posteriori (legge dei grandi numeri):


```r
print(mean(rbeta(1e3, shape1 = 25, shape2 = 17)), 6)
#> [1] 0.597659
```


```r
print(mean(rbeta(1e4, shape1 = 25, shape2 = 17)), 6)
#> [1] 0.595723
```


```r
print(mean(rbeta(1e5, shape1 = 25, shape2 = 17)), 6)
#> [1] 0.595271
```

\noindent
Quando il numero di osservazioni (possiamo anche chiamarle "campioni") tratte dalla distribuzione a posteriori è molto grande, la distribuzione di tali campioni converge alla densità della popolazione (si veda l'Appendice \@ref(integration-mc)).^[Si noti, naturalmente, che il numero dei campioni di simulazione è controllato dal ricercatore; è totalmente diverso dalla dimensione del campione che è fissa ed è una proprietà dei dati.]

Inoltre, le statistiche descrittive (es. media, moda, varianza, eccetera) dei campioni estratti dalla distribuzione a posteriori convergeranno ai corrispondenti valori della distribuzione a posteriori. La figura \@ref(fig:mcmc-chains-1) mostra come, all'aumentare del numero di repliche, la media, la mediana, la deviazione standard e l'asimmetria convergono ai veri valori della distribuzione a posteriori (linee rosse tratteggiate).

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{/Users/corrado/_repositories/dspp/images/mcmc-chains-1} 

}

\caption{Convergenza delle simulazioni Monte Carlo.}(\#fig:mcmc-chains-1)
\end{figure}


## Metodi MC basati su Catena di Markov

Nel Paragrafo \@ref(chapter-simulazioneMC) la simulazione Monte Carlo funzionava perché 

- sapevamo che la distribuzione a posteriori era una $\mbox{Beta}(25, 17)$,
- era possibile usare le funzioni $\R$ per estrarre campioni casuali da tale distribuzione. 

\noindent
Tuttavia, capita raramente di usare una distribuzione a priori coniugata alla verosimiglianza, quindi in generale le due condizioni descritte sopra non si applicano. Ad esempio, nel caso di una verosimiglianza binomiale e una distribuzione a priori Normale, la distribuzione a posteriori di $\theta$ è
$$
p(\theta \mid y) = \frac{\mathrm{e}^{-(\theta - 1 / 2)^2} \theta^y (1 - \theta)^{n - y}} {\int_0^1 \mathrm{e}^{-(t - 1 / 2)^2} t^y (1 - t)^{n - y} dt}.
$$
\noindent
Una tale distribuzione non è implementata in $\R$ e dunque non possiamo campionare da $p(\theta \mid y)$. 

Per fortuna, gli algoritmi MCMC consentono il campionamento da una distribuzione a posteriori _senza che sia necessario conoscere la rappresentazione analitica di una tale distribuzione_. I metodi Monte Carlo basati su catena di Markov consentono di costruire sequenze di punti (detti catene di Markov) nello spazio dei parametri le cui densità sono proporzionali alla distribuzione a posteriori --- in altre parole, dopo aver simulato un grande numero di passi della catena si possono usare i valori così generati come se fossero un campione casuale della distribuzione a posteriori. Le tecniche MCMC sono attualmente il metodo computazionale maggiormente utilizzato per risolvere i problemi di inferenza bayesiana. Un'introduzione alle catene di Markov è fornita nell'Appendice \@ref(markov-chains).

### Campionamento mediante algoritmi MCMC

Un modo generale per ottenere una catena di Markov la cui distribuzione equivale alla distribuzione a posteriori $p(\theta \mid y)$ è quello di usare l'algoritmo di Metropolis. L'algoritmo di Metropolis è il primo algoritmo MCMC che è stato proposto, ed è applicabile ad una grande varietà di problemi inferenziali di tipo bayesiano. Tale algoritmo è stato in seguito sviluppato allo scopo di renderlo via via più efficiente. Lo presentiamo qui in una forma intuitiva.

### Una passeggiata casuale sui numeri naturali

Per introdurre l'algoritmo di di Metropolis considereremo il campionamento da una distribuzione discreta.^[Seguiamo qui la trattazione di @albert2019probability. Per una presentazione intuitiva dell'algoritmo di Metropolis, si vedano anche @doing_bayesian_data_an; @McElreath_rethinking.] Supponiamo di definire una distribuzione di probabilità discreta sugli interi $1,\dots, K$. Scriviamo in $\R$ la funzione `pd()` che assegna ai valori $1,\dots, 8$ delle probabilità proporzionali a 5, 10, 4, 4, 20, 20, 12 e 5.


```r
pd <- function(x){
  values <- c(5, 10, 4, 4, 20, 20, 12, 5)
  ifelse(
    x %in% 1:length(values),
    values[x] / sum(values),
    0
  )
}

prob_dist <- tibble(
  x = 1:8,
  prob = pd(1:8)
)
```

\noindent
La figura \@ref(fig:formetropolisdistr) illustra la distribuzione di probabilità che è stata generata.


```r
x <- 1:8
prob_dist %>%
  ggplot(aes(x = x, y = prob)) +
  geom_bar(stat = "identity", width = 0.06) +
  scale_x_continuous("x", labels = as.character(x), breaks = x) +
  labs(
    y = "Probabilità",
    x = "X"
  )
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/formetropolisdistr-1} 

}

\caption{Distribuzione di massa di probabilità per una variabile casuale avente valori 1, 2, ..., 8.}(\#fig:formetropolisdistr)
\end{figure}

\noindent
L'algoritmo di Metropolis corrisponde alla seguente passeggiata casuale.

1. L'algoritmo inizia con un valore iniziale qualsiasi da 1 a $K=8$ della variabile casuale.
2. Per simulare il valore successivo della sequenza, lanciamo una moneta equilibrata. Se esce testa, consideriamo come valore candidato il valore immediatamente precedente al valore corrente nella sequenza $1, \dots, 8$; se esce croce, il valore candidato sarà il valore immediatamente successivo al valore corrente nella sequenza.
3. Calcoliamo il rapporto tra la probabilità del valore candidato e la probabilità del valore corrente:
$$
R = \frac{pd(\text{valore candidato})}{pd(\text{valore corrente})}.
$$
4. Estraiamo un numero a caso $\in [0, 1]$. Se tale valore è minore di $R$ accettiamo il valore candidato come valore successivo della catena markoviana; altrimenti il valore successivo della catena rimane il valore corrente.

I passi da 1 a 4 definiscono una catena di Markov irriducibile e aperiodica sui valori di stato $\{1, 2,\dots, 8\}$, dove il passo 1 fornisce il valore iniziale della catena e i passi da 2 a 4 definiscono la matrice di transizione $P$. Un modo di campionare da una distribuzione di massa di probabilità `pd` consiste nell'iniziare da una posizione qualsiasi e eseguire una passeggiata casuale costituita da un grande numero di passi, ripetendo le fasi 2, 3 e 4 dell'algoritmo di Metropolis. Dopo un grande numero di passi, la distribuzione dei valori della catena markoviana approssimerà la distribuzione di probabilità `pd`.

La funzione `random_walk()` implementa l'algoritmo di Metropolis. Tale funzione richiede in input la distribuzione di probabilità `pd`, la posizione di partenza `start` e il numero di passi dell'algoritmo `num_steps`.


```r
random_walk <- function(pd, start, num_steps){
  y <- rep(0, num_steps)
  current <- start
  for (j in 1:num_steps){
    candidate <- current + sample(c(-1, 1), 1)
    prob <- pd(candidate) / pd(current)
    if (runif(1) < prob)
      current <- candidate
    y[j] <- current
  }
  return(y)
}
```

\noindent
Di seguito, implementiamo l'algoritmo di Metropolis utilizzando, quale valore iniziale, $X=4$. Ripetiamo la simulazione 10\,000 volte.


```r
out <- random_walk(pd, 4, 1e4)

S <- tibble(out) %>%
  group_by(out) %>%
  summarize(
    N = n(),
    Prob = N / 10000
  )

prob_dist2 <- rbind(
  prob_dist,
  tibble(
    x = S$out,
    prob = S$Prob
    )
  )
prob_dist2$Type <- rep(
  c("Prob. corrette", "Prob. simulate"), 
  each = 8
  )
```


```r
x <- 1:8
prob_dist2 %>%
  ggplot(aes(x = x, y = prob, fill = Type)) +
  geom_bar(
    stat = "identity", 
    width = 0.1, 
    position = position_dodge(0.3)
  ) +
  scale_x_continuous(
    "x", 
    labels = as.character(x), 
    breaks = x
  ) +
  scale_fill_manual(values = c("black", "gray80")) +
  theme(legend.title = element_blank()) +
  labs(
    y = "Probabilità",
    x = "X"
  )
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/metropolishistogramsim-1} 

}

\caption{L'istogramma confronta i valori prodotti dall'algoritmo di Metropolis con i corretti valori della distribuzione di massa di probabilità.}(\#fig:metropolishistogramsim)
\end{figure}

\noindent
La figura \@ref(fig:metropolishistogramsim) confronta l'istogramma dei valori simulati dalla passeggiata casuale con l'effettiva distribuzione di probabilità `pd`. Si noti la somiglianza tra le due distribuzioni.


### L'algoritmo di Metropolis

Vediamo ora come l'algoritmo di Metropolis possa venire usato per generare una catena di Markov irriducibile e aperiodica per la quale la distribuzione stazionaria è uguale alla distribuzione a posteriori di interesse.^[Una illustrazione visiva di come si svolge il processo di "esplorazione" dell'algoritmo di Metropolis è fornita in questo [post](https://elevanth.org/blog/2017/11/28/build-a-better-markov-chain/).] In termini generali, l'algoritmo di Metropolis include due fasi.

- *Fase 1.* La selezione di un valore candidato $\theta'$ del parametro mediante il campionamento da una distribuzione proposta.
- *Fase 2.* La decisione tra la possibilità di accettare il valore candidato $\theta^{(m+1)} = \theta'$ o di mantenere il valore corrente $\theta^{(m+1)} = \theta$ sulla base del seguente criterio:
    - se $\mathcal{L}(\theta' \mid y)p(\theta') > \mathcal{L}(\theta \mid y)p(\theta)$ il valore candidato viene sempre accettato;
    - altrimenti il valore candidato viene accettato solo in una certa proporzione di casi.

Esaminiamo ora nei dettagli il funzionamento dell'algoritmo di Metropolis.

(a) Si inizia con un punto arbitrario $\theta^{(1)}$, quindi il primo valore della catena di Markov $\theta^{(1)}$ può corrispondere semplicemente ad un valore a caso tra i valori possibili del parametro. 

(b) Per ogni passo successivo della catena, $m + 1$, si campiona un valore candidato $\theta'$ da una distribuzione proposta: $\theta' \sim \Pi(\theta)$. La distribuzione proposta può essere qualunque distribuzione, anche se, idealmente, è meglio che sia simile alla distribuzione a posteriori. In pratica, però, la distribuzione a posteriori è sconosciuta e quindi il valore $\theta'$ viene campionato da una qualche distribuzione simmetrica centrata sul valore corrente $\theta^{(m)}$ del parametro. Nell'esempio qui discusso, useremo la distribuzione gaussiana. Tale distribuzione sarà centrata sul valore corrente della catena e avrà una appropriata deviazione standard: $\theta' \sim \mathcal{N}(\theta^{(m)}, \sigma)$. In pratica, questo significa che, se $\sigma$ è piccola, il valore candidato $\theta'$ sarà simile al valore corrente $\theta^{(m)}$.

(c) Una volta generato il valore candidato $\theta'$ si calcola il rapporto tra la densità della distribuzione a posteriori non normalizzata nel punto $\theta'$ [ovvero, il prodotto tra la verosimiglianza $\mathcal{L}(y \mid \theta')$ nel punto $\theta'$ e la distribuzione a priori nel punto $\theta'$] e la densità della distribuzione a posteriori non normalizzata nel punto $\theta^{(m)}$ [ovvero, il prodotto tra la verosimiglianza $\mathcal{L}(y \mid \theta^{(m)})$ nel punto $\theta^{(m)}$ e la distribuzione a priori nel punto $\theta^{(m)}$]:
\begin{equation}
\alpha = \frac{p(y \mid \theta') p(\theta')}{p(y \mid \theta^{(m)}) p(\theta^{(m)})}.
(\#eq:ratio-metropolis)
\end{equation}
\noindent
Si noti che, essendo un rapporto, la \@ref(eq:ratio-metropolis) cancella la costante di normalizzazione.

(d) Il rapporto $\alpha$ viene utilizzato per decidere se accettare il valore candidato $\theta'$, oppure se campionare un diverso candidato. Possiamo pensare al rapporto $\alpha$ come alla risposta alla seguente domanda: alla luce dei dati, è più plausibile il valore candidato del parametro o il valore corrente? Se $\alpha$ è maggiore di 1 ciò significa che il valore candidato è più plausibile del valore corrente; in tali circostanze il valore candidato viene sempre accettato. Altrimenti, si decide di accettare il valore candidato con una probabilità minore di 1, ovvero non sempre, ma soltanto con una probabilità uguale ad $\alpha$. Se $\alpha$ è uguale a 0.10, ad esempio, questo significa che la plausibilità a posteriori del valore candidato è 10 volte più piccola della plausibilità a posteriori del valore corrente. Dunque, il valore candidato verrà accettato solo nel 10% dei casi. Come conseguenza di questa strategia di scelta, l'algoritmo di Metropolis ottiene un campione casuale dalla distribuzione a posteriori, dato che la probabilità di accettare il valore candidato è proporzionale alla densità del candidato nella distribuzione a posteriori. Dal punto di vista algoritmico, la procedura descritta sopra viene implementata confrontando il rapporto $\alpha$ con un valore casuale estratto da una distribuzione uniforme $\mbox{Unif}(0, 1)$. Se $\alpha > u \sim \mbox{Unif}(0, 1)$ allora il punto candidato $\theta'$ viene accettato e la catena si muove in quella nuova posizione, ovvero $\theta^{(m+1)} = \theta'^{(m+1)}$. Altrimenti $\theta^{(m+1)} = \theta^{(m)}$ e si campiona un nuovo valore candidato $\theta'$.

(e) Il passaggio finale dell'algoritmo calcola l'*accettanza* in una specifica esecuzione dell'algoritmo, ovvero la proporzione dei valori candidati $\theta'$ che sono stati accettati come valori successivi nella sequenza.

L'algoritmo di Metropolis prende come input il numero $M$ di passi da simulare, la deviazione standard $\sigma$ della distribuzione proposta e la densità a priori, e ritorna come output la sequenza $\theta^{(1)}, \theta^{(2)}, \dots, \theta^{(M)}$. La chiave del successo dell'algoritmo di Metropolis è il numero di passi fino a che la catena approssima la stazionarietà. Tipicamente i primi da 1000 a 5000 elementi sono scartati. Dopo un certo periodo $k$ (detto di _burn-in_), la catena di Markov converge  ad una variabile casuale che è distribuita secondo la distribuzione a posteriori. In altre parole, i campioni del vettore $\left(\theta^{(k+1)}, \theta^{(k+2)}, \dots, \theta^{(M)}\right)$ diventano campioni di $p(\theta \mid y)$.

### Una applicazione concreta

Per fare un esempio concreto, consideriamo nuovamente i 30 pazienti esaminati da @zetschefuture2019. Di essi, 23 hanno manifestato aspettative distorte negativamente sul loro stato d'animo futuro. Utilizzando l'algoritmo di Metropolis, ci poniamo il problema di ottenere la stima a posteriori di $\theta$ (probabilità di manifestare un'aspettativa distorta negativamente), dati 23 "successi" in 30 prove, imponendo su $\theta$ la stessa distribuzione a priori usata nel Capitolo \@ref(chapter-distr-coniugate), ovvero $\mbox{Beta}(2, 10)$.

Per calcolare la funzione di verosimiglianza, avendo fissato i dati di @zetschefuture2019, definiamo la funzione `likelihood()`


```r
likelihood <- function(param, x = 23, N = 30) {
  dbinom(x, N, param)
}
```

\noindent
che ritorna l'ordinata della verosimiglianza binomiale per ciascun valore del vettore `param` in input.

La distribuzione a priori $\mbox{Beta}(2, 10)$ è implementata nella funzione `prior()`:


```r
prior <- function(param, alpha = 2, beta = 10) {
  dbeta(param, alpha, beta) 
}
```

Il prodotto della densità a priori e della verosimiglianza è implementato nella funzione `posterior()`:


```r
posterior <- function(param) {
  likelihood(param) * prior(param)
}
```

L'Appendice \@ref(es-pratico-zetsche-funzioni) mostra come un'approssimazione della distribuzione a posteriori $p(\theta \mid y)$ per questi dati possa essere ottenuta mediante il metodo basato su griglia. 

<!-- Il risultato della figura precedente è stato ottenuto con il metodo basato su griglia. Vogliamo ora replicare tale risultato usando l'algoritmo di Metropolis. La figura  indica che la media a posteriori è pari a circa 0.6. Questo è il valore a posteriori più verosimile per il parametro $\theta$ alla luce dei dati osservati se assumiamo una distribuzione a priori $\mbox{Beta}(2, 10)$. Ci poniamo ora il problema di replicare tale risultato usando l'algoritmo di Metropolis. -->


### Implementazione

Per implementare  l'algoritmo di Metropolis utilizzeremo una distribuzione proposta gaussiana. Il valore candidato sarà dunque un valore selezionato a caso da una gaussiana di parametri $\mu$ uguale al valore corrente nella catena e $\sigma = 0.9$. In questo esempio, la deviazione standard $\sigma$ è stata scelta empiricamente in modo tale da ottenere una accettanza adeguata. L'accettanza ottimale è di circa 0.20 e 0.30 --- se l'accettanza è troppo grande, l'algoritmo esplora uno spazio troppo ristretto della distribuzione a posteriori.^[L'accettanza dipende dalla distribuzione proposta: in generale, tanto più la distribuzione proposta è simile alla distribuzione target, tanto più alta diventa l'accettanza.]


```r
proposal_distribution <- function(param) {
  while(1) {
    res = rnorm(1, mean = param, sd = 0.9)
    if (res > 0 & res < 1)
      break
  }
  res
}
```
\noindent 
Nella presente implementazione del campionamento dalla distribuzione proposta è stato inserito un controllo che impone al valore candidato di essere incluso nell'intervallo [0, 1].^[Si possono trovare implementazioni dell'algoritmo di Metropolis più eleganti di quella presentata qui. Lo scopo dell'esercizio è quello di illustrare la logica soggiacente all'algoritmo di Metropolis, non quello di proporre un'implementazione efficente dell'algoritmo.]

L'algoritmo di Metropolis viene implementato nella seguente funzione:


```r
run_metropolis_MCMC <- function(startvalue, iterations) {
  chain <- vector(length = iterations + 1)
  chain[1] <- startvalue
  for (i in 1:iterations) {
    proposal <- proposal_distribution(chain[i])
    r <- posterior(proposal) / posterior(chain[i])
    if (runif(1) < r) {
      chain[i + 1] <- proposal
    } else {
      chain[i + 1] <- chain[i]
    }
  }
  chain
}
```

Avendo definito le funzioni precedenti, generiamo una catena di valori $\theta$:


```r
set.seed(123)
startvalue <- runif(1, 0, 1)
niter <- 1e4
chain <- run_metropolis_MCMC(startvalue, niter)
```

Mediante le istruzioni precedenti otteniamo una catena di Markov costituita da 10,001 valori. Escludiamo i primi 5,000 valori considerati come burn-in. Ci restano dunque con 5,001 valori che verranno considerati come un campione casuale estratto dalla distribuzione a posteriori $p(\theta \mid y)$.

L'accettanza è pari a


```r
burnIn <- niter / 2
acceptance <- 1 - mean(duplicated(chain[-(1:burnIn)]))
acceptance
#> [1] 0.251
```
\noindent
il che conferma la bontà della deviazione standard ($\sigma$ = 0.9) scelta per la distribuzione proposta.

A questo punto è facile ottenere una stima a posteriori del parametro $\theta$. Per esempio, la stima della media a posteriori è:


```r
mean(chain[-(1:burnIn)])
#> [1] 0.592
```

Una figura che mostra l'approssimazione di $p(\theta \mid y)$  ottenuta con l'algoritmo di Metropolis, insieme ad un _trace plot_ dei valori della catena di Markov, viene prodotta usando le seguenti istruzioni:


```r
p1 <- tibble(
  x = chain[-(1:burnIn)]
  ) %>%
  ggplot(aes(x)) +
  geom_histogram() +
  labs(
    x = expression(theta),
    y = "Frequenza",
    title = "Distribuzione a posteriori"
  ) +
  geom_vline(
    xintercept = mean(chain[-(1:burnIn)])
  )
p2 <- tibble(
  x = 1:length(chain[-(1:burnIn)]),
  y = chain[-(1:burnIn)]
  ) %>%
  ggplot(aes(x, y)) +
  geom_line() +
  labs(
    x = "Numero di passi",
    y = expression(theta),
    title = "Valori della catena"
  ) +
  geom_hline(
    yintercept = mean(chain[-(1:burnIn)]),
    colour = "gray"
  )
p1 + p2
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/sim-markov-chain-zetsche-1} 

}

\caption{Sinistra. Stima della distribuzione a posteriori della probabilità di una aspettativa futura distorta negativamente per i dati di Zetsche et al. (2019). Destra. Trace plot dei valori della catena di Markov escludendo il periodo di burn-in.}(\#fig:sim-markov-chain-zetsche)
\end{figure}


### Input

Negli esempi discussi in questo Capitolo abbiamo illustrato l'esecuzione di una singola catena in cui si parte un unico valore iniziale e si raccolgono i valori simulati da molte iterazioni. È possibile che i valori di una catena siano influenzati dalla scelta del valore iniziale. Quindi una raccomandazione generale è di eseguire l'algoritmo di Metropolis più volte utilizzando diversi valori di partenza. In questo caso, si avranno più catene di Markov. Confrontando le proprietà delle diverse catene si esplora la sensibilità dell'inferenza alla scelta del valore di partenza. I software MCMC consentono sempre all'utente di specificare diversi valori di partenza e di generare molteplici catene di Markov.


## Stazionarietà

Un punto importante da verificare è se il campionatore ha raggiunto la sua distribuzione stazionaria. La convergenza di una catena di Markov alla distribuzione stazionaria viene detta "mixing".


### Autocorrelazione {#approx-post-autocor}

Informazioni sul "mixing" della catena di Markov sono fornite dall'autocorrelazione. L'autocorrelazione misura la correlazione tra i valori successivi di una catena di Markov. Il valore $m$-esimo della serie ordinata viene confrontato con un altro valore ritardato di una quantità $k$ (dove $k$ è l'entità del ritardo) per verificare quanto si correli al variare di $k$. L'autocorrelazione di ordine 1 (_lag 1_) misura la correlazione tra valori successivi della catena di Markow (cioè, la correlazione tra $\theta^{(m)}$ e $\theta^{(m-1)}$); l'autocorrelazione di ordine 2 (_lag 2_) misura la correlazione tra valori della catena di Markow separati da due "passi" (cioè, la correlazione tra $\theta^{(m)}$ e $\theta^{(m-2)}$); e così via.

L'autocorrelazione di ordine $k$ è data da $\rho_k$ e può essere stimata come:
\begin{align}
\rho_k &= \frac{\Cov(\theta_m, \theta_{m+k})}{\Var(\theta_m)}\notag\\
&= \frac{\sum_{m=1}^{n-k}(\theta_m - \bar{\theta})(\theta_{m-k} - \bar{\theta})}{\sum_{m=1}^{n-k}(\theta_m - \bar{\theta})^2} \qquad\text{con }\quad \bar{\theta} = \frac{1}{n}\sum_{m=1}^{n}\theta_m.
(\#eq:autocor)
\end{align}
Per fare un esempio pratico, simuliamo dei dati autocorrelati con la funzione R `colorednoise::colored_noise()`:


```r
suppressPackageStartupMessages(library("colorednoise"))
set.seed(34783859)
rednoise <- colored_noise(
  timesteps = 30, mean = 0.5, sd = 0.05, phi = 0.3
)
```

L'autocorrelazione di ordine 1 è semplicemente la correlazione tra ciascun elemento e quello successivo nella sequenza. Nell'esempio, il vettore `rednoise` è una sequenza temporale di 30 elementi. Il vettore `rednoise[-length(rednoise)]` include gli elementi con gli indici da 1 a 29 nella sequenza originaria, mentre il vettore `rednoise[-1]` include gli elementi 2:30. Gli elementi delle coppie ordinate dei due vettori avranno dunque gli indici $(1, 2), (2, 3), \dots (29, 30)$ degli elementi della sequenza originaria. La correlazione di Pearson tra i vettori `rednoise[-length(rednoise)]` e `rednoise[-1]` corrisponde dunque all'autocorrelazione di ordine 1 della serie temporale.


```r
cor(rednoise[-length(rednoise)], rednoise[-1])
#> [1] 0.397
```

Il Correlogramma è uno strumento grafico usato per la valutazione della tendenza di una catena di Markov nel tempo. Il correlogramma si costruisce a partire dall'autocorrelazione $\rho_k$ di una catena di Markov in funzione del ritardo (_lag_) $k$ con cui l'autocorrelazione è calcolata: nel grafico ogni barretta verticale riporta il valore dell'autocorrelazione (sull'asse delle ordinate) in funzione del ritardo (sull'asse delle ascisse). In $\R$, il correlogramma può essere prodotto con una chiamata a `acf()`:


```r
acf(rednoise)
```



\begin{center}\includegraphics[width=0.8\linewidth]{036_posterior_sim_files/figure-latex/unnamed-chunk-28-1} \end{center}

Il correlogramma precedente mostra come l'autocorrelazione di ordine 1 sia circa pari a 0.4 e diminuisce per lag maggiori; per lag di 4, l'autocorrelazione diventa negativa e aumenta progressivamente fino ad un lag di 8; eccetera.

In situazioni ottimali l'autocorrelazione diminuisce rapidamente ed è effettivamente pari a 0 per piccoli lag. Ciò indica che i valori della catena di Markov che si trovano a più di soli pochi passi di distanza gli uni dagli altri non risultano associati tra loro, il che fornisce conferma del "mixing" della catena di Markov, ossia di convergenza alla distribuzione stazionaria.
Nelle analisi bayesiane, una delle strategie che consentono di ridurre l'autocorrelazione è quella di assottigliare l'output immagazzinando solo ogni $m$-esimo punto dopo il periodo di burn-in. Una tale strategia va sotto il nome di _thinning_.


### Test di convergenza

Un test di convergenza può essere svolto in maniera grafica mediante le tracce delle serie temporali (_trace plot_), cioè il grafico dei valori simulati rispetto al numero di iterazioni. Se la catena è in uno stato stazionario le tracce mostrano assenza di periodicità nel tempo e ampiezza costante, senza tendenze visibili o andamenti degni di nota. Un esempio di _trace plot_ è fornito nella figura \@ref(fig:sim-markov-chain-zetsche) (destra).

Ci sono inoltre alcuni test che permettono di verificare la stazionarietà del campionatore dopo un dato punto. Uno è il test di Geweke che suddivide il campione, dopo aver rimosso un periodo di burn in, in due parti. Se la catena è in uno stato stazionario, le medie dei due campioni dovrebbero essere uguali. Un test modificato, chiamato Geweke z-score, utilizza un test $z$ per confrontare i due subcampioni ed il risultante test statistico, se ad esempio è più alto di 2, indica che la media della serie sta ancora muovendosi da un punto ad un altro e quindi è necessario un periodo di burn-in più lungo.


## Considerazioni conclusive {-}

In generale, la distribuzione a posteriori dei parametri di un modello statistico non può essere determinata per via analitica. Tale problema, invece, viene affrontato facendo ricorso ad una classe di algoritmi per il campionamento da distribuzioni di probabilità che sono estremamente onerosi dal punto di vista computazionale e che possono essere utilizzati nelle applicazioni pratiche solo grazie alla potenza di calcolo dei moderni computer. Lo sviluppo di software che rendono sempre più semplice l'uso dei metodi MCMC, insieme all'incremento della potenza di calcolo dei computer, ha contribuito a rendere sempre più popolare il metodo dell'inferenza bayesiana che, in questo modo, può essere estesa a problemi di qualunque grado di complessità.

Nel 1989 un gruppo di statistici nel Regno Unito si pose il problema di simulare le catene di Markov su un personal computer. Nel 1997 ci riuscirono con il primo rilascio pubblico di un'implementazione Windows dell'inferenza bayesiana basata su Gibbs sampling, detta BUGS. Il materiale presentato in questo capitolo descrive gli sviluppi contemporanei del percorso che è iniziato in quel periodo.







