# Distribuzioni di v.c. discrete



In questo Capitolo verranno esaminate le principali distribuzioni di probabilità delle variabili casuali discrete. Un esperimento casuale che può dare luogo a solo due possibili esiti (successo, insuccesso) è modellabile con una variabile casuale di Bernoulli. Una sequenza di prove di Bernoulli costituisce un processo Bernoulliano. Il numero di successi dopo $n$ prove di Bernoulli corrisponde ad una variabile casuale che segue la legge binomiale. La distribuzione binomiale risulta da un insieme di prove di Bernoulli solo se il numero totale $n$ è fisso per disegno. Se il numero di prove è esso stesso una variabile casuale, allora il numero di successi nella corrispondente sequenza di prove bernoulliane segue al distribuzione di Poisson.


## Una prova Bernoulliana

Se un esperimento casuale ha solo due esiti possibili, allora le
repliche indipendenti di questo esperimento sono chiamate "prove
Bernoulliane" (il lancio di una moneta è il tipico esempio). 

::: {.definition}
Viene detta variabile di Bernoulli una variabile casuale discreta $Y = \{0, 1\}$ con la seguente distribuzione di probabilità: 
$$
P(Y \mid \theta) =
  \begin{cases}
    \theta     & \text{se $Y = 1$}, \\
    1 - \theta & \text{se $Y = 0$},
  \end{cases}
$$ 
\noindent
con $0 \leq \theta \leq 1$. Convenzionalmente l'evento $\{Y = 1\}$ con probabilità $\theta$ viene chiamato "successo" mentre l'evento $\{Y = 0\}$ con probabilità $1-\theta$ viene chiamato "insuccesso".
::: 

Applicando l'operatore di valore atteso e di varianza, otteniamo

\begin{align}
\E(Y) &= 0 \cdot Pr(Y=0) + 1 \cdot Pr(Y=1) = \theta, \\
\Var(Y) &= (0 - \theta)^2 \cdot Pr(Y=0) + (1 - \theta)^2 \cdot rP(Y=1) = \theta(1-\theta).
(\#eq:ev-var-bern)
\end{align}

Scriviamo $Y \sim \mathcal{B}(\theta)$ per indicare che la variabile
casuale $Y$ ha una distribuzione Bernoulliana di parametro $\theta$.

:::{.example #bernoulli}
Nel caso del lancio di una moneta equilibrata la variabile casuale di Bernoulli assume i valori $0$ e $1$. La distribuzione di massa di probabilità è pari a $\frac{1}{2}$ in corrispondenza di entrambi iv valori. La funzione di distribuzione vale $\frac{1}{2}$ per $Y = 0$ e $1$ per $Y = 1$.
:::


## Una sequenza di prove Bernoulliane

La distribuzione binomiale è rappresentata dall'elenco di tutti i
possibili numeri di successi $Y = \{0, 1, 2, \dots n\}$ che possono
essere osservati in $n$ prove Bernoulliane indipendenti di probabilità
$\theta$, a ciascuno dei quali è associata la relativa probabilità. Esempi di una distribuzione binomiale sono i risultati di una serie di lanci di
una stessa moneta o di una serie di estrazioni da un'urna (con
reintroduzione). La distribuzione binomiale di parametri $n$ e $\theta$ è in realtà una famiglia di distribuzioni: al variare dei parametri $\theta$ e $n$ variano le probabilità.

::: {.definition #binomialdistr}
La probabilità di ottenere $y$ successi e $n-y$ insuccessi in $n$ prove
Bernoulliane è data dalla distribuzione binomiale: 

\begin{align}
P(Y=y) &= \binom{n}{y} \theta^{y} (1-\theta)^{n-y} \notag \\
&= \frac{n!}{y!(n-y)!} \theta^{y} (1-\theta)^{n-y}, 
(\#eq:binomialdistribution)
\end{align}
dove $n$ = numero di prove Bernoulliane, $\theta$ = probabilità di successo in ciascuna prova e $y$ = numero di successi.
:::

La \@ref(eq:binomialdistribution) può essere derivata nel modo seguente. Indichiamo con $S$ il successo e con $I$ l'insuccesso di ciascuna prova. Una sequenza di $n$ prove Bernoulliane darà come esito una sequenza di $n$ elementi $S$ e $I$. Ad esempio, una sequenza che contiene $y$ successi è la seguente:

$$
\overbrace{SS\dots S}^\text{$y$ volte} \overbrace{II\dots I}^\text{$n-y$ volte}
$$

Essendo $\theta$ la probabilità di $S$ e $1-\theta$ la probabilità di $I$, la probabilità di ottenere la specifica sequenza riportata sopra è

\begin{equation}
\overbrace{\theta \theta\dots \theta}^\text{$y$ volte} \overbrace{(1-\theta)(1-\theta)\dots (1-\theta)}^\text{$n-y$ volte} = \theta^y \cdot (1-\theta)^{n-y}.
(\#eq:demo-bino-kernel)
\end{equation}

Non siamo però interessati alla probabilità di una _specifica_ sequenza di $S$ e $I$ ma, bensì, alla probabilità di osservare una _qualsiasi_ sequenza di $y$ successi in $n$ prove. In altre parole, vogliamo la probabilità dell'unione di tutti gli eventi corrispondenti a $y$ successi in $n$ prove. 

È immediato notare che una qualsiasi altra sequenza contenente esattamente $y$ successi avrà sempre come probabilità $\theta^y \cdot (1-\theta)^{n-y}$: il prodotto infatti resta costante anche se cambia l'ordine dei fattori.^[Viene detta _scambiabilità_ la proprietà per cui l'ordine con cui compiamo le osservazioni è irrilevante per l'assegnazione delle probabilità.] Per trovare il risultato cercato dobbiamo moltiplicare la \@ref(eq:demo-bino-kernel) per il numero di sequenze possibili di $y$ successi in $n$ prove.

Il numero di sequenze che contengono esattamente $y$ successi in $n$ prove. La risposta è fornita dal coefficiente binomiale^[La derivazione della formula del coefficiente binomiale è fornita nell'Appendice \@ref(derivazione-coef-binom).]:

\begin{equation}
\binom{n}{y} = \frac{n!}{y!(n-y)!},
(\#eq:binomial-coefficient)
\end{equation}
dove il simbolo $n!$ si legge $n$ fattoriale ed è uguale al prodotto di $n$ numeri interi decrescenti a partire da $n$. Per definizione $0! = 1$.

Essendo la probabilità dell'unione di $K$ elementi incompatibili uguale alla somma delle loro rispettive probabilità, e dato che le sequenze di $y$ successi in $n$ prove hanno tutte la stessa probabilità, per trovare la formula della distributione binomiale \@ref(eq:binomialdistribution) è sufficiente moltiplicare la \@ref(eq:demo-bino-kernel) per la \@ref(eq:binomial-coefficient).

:::{.example}
Usando la \@ref(eq:binomialdistribution), troviamo la probabilità di $y = 2$ successi in $n = 4$ prove Bernoulliane indipendenti con $\theta = 0.2$: 

$$
\begin{aligned}
P(Y=2) &= \frac{4!}{2!(4-2)!} 0.2^{2} (1-0.2)^{4-2} \notag  \\
 &= \frac{4 \cdot 3 \cdot 2 \cdot 1}{(2 \cdot 1)(2 \cdot 1)}
0.2^{2} 0.8^{2} = 0.1536. \notag
\end{aligned}
$$ 

Ripetendo i calcoli per i valori $y = 0, \dots, 4$ troviamo la distribuzione binomiale di parametri $n = 4$ e $\theta = 0.2$:

|y   | P(Y = y)|
|:--:|:-------:|
|0   | 0.4096  |
|1   | 0.4096  |
|2   | 0.1536  |
|3   | 0.0256  |
|4   | 0.0016  |
|sum | 1.0     |

Lo stesso risultato si ottiene usando la sequente istruzione \R:  


```r
dbinom(0:4, 4, 0.2)
#> [1] 0.4096 0.4096 0.1536 0.0256 0.0016
```
:::

:::{.example}
Lanciando $5$ volte una moneta onesta, qual è la probabilità che esca testa almeno tre volte?

In \R, la soluzione si trova con


```r
dbinom(3, 5, 0.5) + dbinom(4, 5, 0.5) + dbinom(5, 5, 0.5)
#> [1] 0.5
```

Alternativamente, possiamo trovare la probabilità dell'evento complementare a quello definito dalla funzione di ripartizione calcolata mediante `pbinom()`, ovvero


```r
1 - pbinom(2, 5, 0.5)
#> [1] 0.5
```
:::


:::{.example}
La distribuzione di probabilità di alcune distribuzioni binomiali, per due valori di $n$ e $\theta$, è fornita nella figura \@ref(fig:example-binomial-distr).

\begin{figure}

{\centering \includegraphics{022_distr_rv_discr_files/figure-latex/example-binomial-distr-1} 

}

\caption{Alcune distribuzioni binomiali. Nella figura, il parametro $\theta$ è indicato con $p$.}(\#fig:example-binomial-distr)
\end{figure}
:::


### Valore atteso e deviazione standard 

La media (numero atteso di successi in $n$ prove) e la deviazione
standard di una distribuzione binomiale sono molto semplici:

\begin{align}
\mu    &= n\theta,  \notag \\
\sigma &= \sqrt{n\theta(1-\theta)}.
 \end{align}

::: {.proof}
Essendo $Y$ la somma di $n$ prove Bernoulliane indipendenti $Y_i$, è facile vedere che 

\begin{align}
\E(Y) &= \E \left( \sum_{i=1}^n Y_i \right) = \sum_{i=1}^n \E(Y_i) = n\theta, \\
\Var(Y) &= \Var \left( \sum_{i=1}^n Y_i \right) = \sum_{i=1}^n \Var(Y_i) = n \theta (1-\theta).
\end{align}

:::

:::{.example}
Si trovino il valore atteso e la varianza del lancio di quattro monete con probabilità di successo pari a $\theta = 0.2$.

Il valore atteso è $\mu = n\theta = 4 \cdot 0.2 = 0.8.$ Ciò significa che, se l'esperimento casuale venisse ripetuto infinite volte, l'esito testa verrebbe osservato un numero medio di volte pari a 0.8. La varianza è $n \theta (1-\theta) = 4 \cdot(1 - 0.2) = 0.8$.^[L'eguaglianza di $\mu$ e $\sigma$ è solo una peculiarità di questo esempio.]
:::


## Distribuzione di Poisson

La distribuzione di Poisson è una distribuzione di probabilità discreta che esprime le probabilità per il numero di eventi che si verificano successivamente ed indipendentemente in un dato intervallo di tempo, sapendo che mediamente se ne verifica un numero $\lambda$. La distribuzione di Poisson serve dunque per contare il numero di volte in cui un evento ha luogo in un determinato intervallo di tempo. La stessa distribuzione può essere estesa anche per contare gli eventi che hanno luogo in una determinata porzione di spazio. 

::: {.definition #poisson}
La distribuzione di Poisson può essere intesa come limite della distribuzione binomiale, dove la probabilità di successo $\theta$ è pari a $\frac{\lambda}{n}$ con $n$ che tende a $\infty$:

\begin{equation}
\lim_{y \rightarrow \infty} \binom{n}{y} \theta^y (1-\theta)^{n-y} = \frac{\lambda^y}{y!}e^{-\lambda}.
\end{equation}
:::


::: {.example}
Supponiamo che un evento accada 300 volte all'ora e si vuole determinare la probabilità che in un minuto accadano esattamente 3 eventi. 

Il numero medio di eventi in un minuto è pari a 


```r
lambda <- 300 / 60
lambda
#> [1] 5
```

\noindent
Quindi la probabilità che in un minuto si abbiano 3 eventi è pari a


```r
y <- 3
(lambda^y / factorial(y)) * exp(-lambda)
#> [1] 0.1403739
```
:::


::: {.example}
Per i dati dell'esempio precedente, si trovi la probabilità che un evento accada almeno 8 volte in un minuto.

La probabilità cercata è 
$$
p(y \geq 8) = 1 - p (y \leq 7) = 1- \sum_{i = 0}^7 \frac{\lambda^7}{7!}e^{-\lambda},
$$
\noindent
con $\lambda = 5$. 

Svolgendo i calcoli in \R otteniamo:

```r
1 - ppois(q = 7, lambda = 5)
#> [1] 0.1333717
ppois(q = 7, lambda = 5, lower.tail = FALSE)
#> [1] 0.1333717
```
:::

::: {.example}
Sapendo che un evento avviene in media 6 volte al minuto, si calcoli (a) la probabilità di osservare un numero di eventi uguale o inferiore a 3 in un minuto, e (b) la probabilità di osservare esattamente 2 eventi in 30 secondi.

(a) In questo caso $\lambda = 6$ e la probabilità richiesta è


```r
ppois(q = 3, lambda = 6, lower.tail = TRUE)
#> [1] 0.1512039
```
(b) In questo caso $\lambda = 6 / 2$ e la probabilità richiesta è


```r
dpois(x = 2, lambda = 3)
#> [1] 0.2240418
```
:::


::: {.example}
Alcune distribuzioni di Poisson sono riportate nella figura \@ref(fig:examples-poisson-distrib).

\begin{figure}

{\centering \includegraphics{022_distr_rv_discr_files/figure-latex/examples-poisson-distrib-1} 

}

\caption{Alcune distribuzioni di Poisson.}(\#fig:examples-poisson-distrib)
\end{figure}

:::


## Alcune proprietà della variabile di Poisson

- Il valore atteso, la moda e la varianza della variabile di Poisson sono uguali a $\lambda$.

- La somma $Y_1 + \dots + Y_n$ di $n$ variabili casuali indipendenti con distribuzioni di Poisson di parametri $\lambda_{1},\dots,\lambda_{n}$ segue una distribuzione di Poisson di parametro $\lambda = \lambda_{1}+\dots+\lambda_{n}$. 
- La differenze di due variabili di Poisson non è una variabile di Poisson. Basti infatti pensare che può assumere valori negativi.


## Considerazioni conclusive {-}

La distribuzione binomiale è una distribuzione di probabilità discreta che descrive il numero di successi in un processo di Bernoulli, ovvero la variabile aleatoria  $Y = Y_1 + \dots + Y_n$ che somma $n$ variabili casuali indipendenti di uguale distribuzione di Bernoulli $\mathcal{B}(\theta)$, ognuna delle quali può fornire due soli risultati: il successo con probabilità $\theta$ e il fallimento con probabilità $1 - \theta$.

La distribuzione binomiale è molto importante per le sue molte applicazioni. Nelle presenti dispense, dedicate all'analisi bayesiana, è soprattutto importante perché costituisce il fondamento del caso più semplice del cosiddetto "aggiornamento bayesiano", ovvero il caso Beta-Binomiale. Il modello Beta-Binomiale ci fornirà infatti un esempio paradigmatico dell'approccio bayesiano all'inferenza e sarà trattato in maniera analitica.  È dunque importante che le proprietà della distribuzione binomiale risultino ben chiare.  

<!-- Una variabile casuale bernoulliana è la più semplice delle variabili casuali. Di conseguenza, la distribuzione binomiale è la distribuzione di massa di probabilità più semplice. Per questa ragione la distribuzione binomiale viene discussa prima di presentare i casi più complessi. L'aspetto matematico, tuttavia, è secondario per i nostri scopi. In tutti i casi, è più semplice usare un software per svolgere i calcoli, piuttosto che fare una lunga serie di somme utilizzando le Tavole delle funzioni di ripartizione di varie distribuzioni di probabilità. Ciò che è cruciale è capire il significato dei concetti e come si può utilizzare un software per eseguire i calcoli. Nel caso presente, i calcoli sono molto semplici e si possono anche eseguire a mano. In seguito vedremo che l'uso di un software sarà sempre richiesto. -->


