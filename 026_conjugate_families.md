# Distribuzioni a priori coniugate {#chapter-distr-coniugate}



Obiettivo di questo Capitolo è fornire un esempio di derivazione della distribuzione a posteriori scegliendo quale distribuzione a priori una distribuzione coniugata. Esamineremo qui il modello Beta-Binomiale.

## Il denominatore bayesiano

In un problema bayesiano i dati $y$ provengono da una distribuzione $p(y \mid \theta)$ e al parametro $\theta$ viene assegnata una distribuzione a priori $p(\theta)$. La scelta della distribuzione a priori ha importanti conseguenze di tipo computazionale. Infatti, a meno di non utilizzare particolari forme analitiche, risulta impossibile ottenere espressioni esplicite per la distribuzione a posteriori. Ciò dipende dall'espressione a denominatore della formula di Bayes
\begin{equation}
p(\theta \mid y) = \frac{p(\theta) p(y \mid \theta)}{\int p(\theta) p(y \mid \theta) \,\operatorname {d}\! \theta} \notag
\end{equation}
il cui calcolo non è eseguibile in modo analitico in forma chiusa. Per non incorrere in problemi nel calcolo della distribuzione a posteriori vengono usate le distribuzioni provenienti da famiglie coniugate. 

::: {.definition}
Una distribuzione di probabilità a priori $p(\theta)$ si dice *coniugata* al modello usato se la distribuzione a priori e la distribuzione a posteriori hanno la stessa forma funzionale. Dunque, le due distribuzioni differiscono solo per il valore dei parametri.
:::

È possibile ottenere la distribuzione posteriore per via analitica solo per alcune specifiche combinazioni di distribuzione a priori e verosimiglianza, ma questo limita considerevolmente la flessibilità della modellizzazione.^[Per questa ragione, la strada principale che viene seguita nella modellistica bayesiana è quella che porta a determinare la distribuzione a posteriori non per via analitica, ma bensì mediante metodi numerici. La simulazione fornisce dunque la strategia generale del calcolo bayesiano. A questo fine vengono usati i metodi di campionamento detti Monte-Carlo Markov-Chain (MCMC). Tali metodi costituiscono una potente e praticabile alternativa per la costruzione della distribuzione a posteriori per modelli complessi e consentono di decidere quali distribuzioni a priori e quali distribuzioni di verosimiglianza usare sulla base di considerazioni teoriche soltanto, senza dovere preoccuparsi di altri vincoli. Dato che è basata su metodi computazionalmente intensivi, la stima numerica della funzione a posteriori può essere svolta soltanto mediante software. In anni recenti i metodi bayesiani di analisi dei dati sono diventati sempre più popolari proprio perché la potenza di calcolo necessaria per svolgere tali calcoli è ora alla portata di tutti. Questo non era vero solo pochi decenni fa.]

## Il modello Beta-Binomiale  {#chapter-distr-priori-coniugate}

Per fare un esempio concreto, consideriamo nuovamente i dati di @zetschefuture2019: nel campione di 30 partecipanti clinici le aspettative future di 23 partecipanti risultano distorte negativamente e quelle di 7 partecipanti risultano distorte positivamente. Nel seguito, indicheremo con $\theta$ la probabilità che le aspettative di un paziente clinico siano distorte negativamente. Ci poniamo il problema di ottenere una stima a posteriori di $\theta$ avendo osservato 23 "successi" in 30 prove.
 
I dati osservati ($y = 23$) possono essere considerati la manifestazione di una variabile casuale Bernoulliana. In tali circostanze, esiste una famiglia di distribuzioni che, qualora venga scelta per la distribuzione a priori, fa sì che la distribuzione a posteriori abbia la stessa forma funzionale della distribuzione a priori. Questo consente una soluzione analitica dell'integrale che compare a denominatore nella formula di Bayes. Nel caso presente, la famiglia di distribuzioni che ha questa proprietà è la distribuzione Beta.

### Parametri della distribuzione Beta

È possibile esprimere diverse credenze iniziali rispetto a $\theta$ mediante la distribuzione Beta. Ad esempio, la scelta di una $\mbox{Beta}(\alpha = 4, \beta = 4)$ quale  distribuzione a priori per il parametro $\theta$ corrisponde alla credenza a priori che associa all'evento "presenza di una aspettativa futura distorta negativamente" una grande incertezza: il valore 0.5 è il valore di $\theta$ più plausibile, ma anche gli altri valori del parametro (tranne gli estremi) sono ritenuti piuttosto plausibili. Questa distribuzione a priori esprime la credenza che sia egualmente probabile per un'aspettativa futura essere distorta negativamente o positivamente.


```r
library("bayesrules")
plot_beta(alpha = 4, beta = 4, mean = TRUE, mode = TRUE)
```



\begin{center}\includegraphics[width=0.8\linewidth]{026_conjugate_families_files/figure-latex/unnamed-chunk-1-1} \end{center}

Possiamo quantificare la nostra incertezza calcolando, con un grado di fiducia del 95%, la regione nella quale, in base a tale credenza a priori, si trova il valore del parametro. Per ottenere tale intervallo di credibilità a priori, usiamo la funzione `qbeta()` di $\R$. In `qbeta()` i parametri $\alpha$ e $\beta$ sono chiamati `shape1` e `shape2`:

```r
qbeta(c(0.025, 0.975), shape1 = 4, shape2 = 4)
#> [1] 0.184 0.816
```

Se poniamo $\alpha=10$ e $\beta=10$, questo corrisponde ad una credenza a priori che sia egualmente probabile per un'aspettativa futura essere distorta negativamente o positivamente,

```r
plot_beta(alpha = 10, beta = 10, mean = TRUE, mode = TRUE)
```



\begin{center}\includegraphics[width=0.8\linewidth]{026_conjugate_families_files/figure-latex/unnamed-chunk-3-1} \end{center}
\noindent
ma ora la nostra certezza a priori sul valore del parametro è maggiore, come indicato dall'intervallo al 95%:


```r
qbeta(c(0.025, 0.975), shape1 = 10, shape2 = 10)
#> [1] 0.289 0.711
```

Quale distribuzione a priori dobbiamo scegliere? In un problema concreto di analisi dei dati, la scelta della distribuzione a priori dipende dalle credenze a priori che vogliamo includere nell'analisi dei dati. Se non abbiamo alcuna informazione a priori, potremmo usare $\alpha=1$ e $\beta=1$, che produce una distribuzione a priori uniforme. Ma l'uso di distribuzioni a priori uniformi è sconsigliato per vari motivi, inclusa l'instabilità numerica della stima dei parametri. È meglio invece usare una distribuzione a priori poco informativa, come $\mbox{Beta}(2, 2)$.

Nella discussione successiva, solo per fare un esempio, useremo quale distribuzione a priori una $\mbox{Beta}(2, 10)$, ovvero:
$$
p(\theta) = \frac{\Gamma(12)}{\Gamma(2)\Gamma(10)}\theta^{2-1} (1-\theta)^{10-1}.
$$


```r
plot_beta(alpha = 2, beta = 10, mean = TRUE, mode = TRUE)
```



\begin{center}\includegraphics[width=0.8\linewidth]{026_conjugate_families_files/figure-latex/unnamed-chunk-5-1} \end{center}

\noindent
La $\mbox{Beta}(2, 10)$ esprime la credenza che $\theta < 0.5$, con il valore più plausibile pari a cicrca 0.1. 

### La specificazione della distribuzione a posteriori

Una volta scelta una distribuzione a priori di tipo Beta, i cui  parametri rispecchiano le nostre credenze iniziali su $\theta$, la distribuzione a posteriori viene specificata dalla formula di Bayes: 
$$
\text{distribuzione a posteriori} = \frac{\text{verosimiglianza}\cdot\text{distribuzione a priori}}{\text{verosimiglianza marginale}}.
$$
Nel caso presente abbiamo
$$
p(\theta \mid n=30, y=23) = \frac{\Big[\binom{30}{23}\theta^{23}(1-\theta)^{30-23}\Big]\Big[\frac{\Gamma(12)}{\Gamma(2)\Gamma(10)}\theta^{2-1} (1-\theta)^{10-1}\Big]}{p(y = 23)},
$$
laddove $p(y = 23)$, ovvero la verosimiglianza marginale, è una costante di normalizzazione che fa sì che l'area sottesa alla densità a posteriori sia unitaria. 

Riscriviamo ora l'equazione precedente in termini generali
$$
p(\theta \mid n, y) = \frac{\Big[\binom{n}{y}\theta^{y}(1-\theta)^{n-y}\Big]\Big[\frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}\theta^{a-1} (1-\theta)^{b-1}\Big]}{p(y)}
$$
\noindent
e raccogliendo tutte le costanti otteniamo:
$$
p(\theta \mid n, y) =\left[\frac{\binom{n}{y}\frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}}{p(y)}\right] \theta^{y}(1-\theta)^{n-y}\theta^{a-1} (1-\theta)^{b-1}.
$$
\noindent
Se ignoriamo il termine costante all'interno della parentesi quadra 
\begin{align}
p(\theta \mid n, y) &\propto \theta^{y}(1-\theta)^{n-y}\theta^{a-1} (1-\theta)^{b-1},\notag\\
&\propto \theta^{a+y-1}(1-\theta)^{b+n-y-1},\notag
\end{align}
\noindent
il termine di destra dell'equazione precedente identifica il _kernel_ della distribuzione a posteriori e corrisponde ad una Beta _non normalizzata_ di parametri $a + y$ e $b + n - y$. 

Per ottenere una distribuzione di densità, dobbiamo aggiungere una costante di normalizzazione al kernel della distribuzione a posteriori. In base alla definizione della distribuzione Beta, ed essendo $a' = a+y$ e $b' = b+n-y$, tale costante di normalizzazione sarà uguale a
$$
\frac{\Gamma(a'+b')}{\Gamma(a')\Gamma(b')} = \frac{\Gamma(a+b+n)}{\Gamma(a+y)\Gamma(b+n-y)}.
$$
\noindent
In altri termini, la distribuzione a posteriori diventa una $\mbox{Beta}(a+y, b+n-y)$:
$$
\mbox{Beta}(a+y, b+n-y) = \frac{\Gamma(a+b+n)}{\Gamma(a+y)\Gamma(b+n-y)} \theta^{a+y-1}(1-\theta)^{b+n-y-1}.
$$

Possiamo concludere dicendo che siamo partiti da una verosimiglianza $\Bin(n = 30, y = 23 \mid \theta)$. Moltiplicando la verosimiglianza per la distribuzione a priori $\theta \sim \mbox{Beta}(2, 10)$, abbiamo ottenuto la distribuzione a posteriori $p(\theta \mid n, y) \sim \mbox{Beta}(25, 17)$. Questo è un esempio di analisi coniugata: la distribuzione a posteriori del parametro ha la stessa forma funzionale della distribuzione a priori. La presente combinazione di verosimiglianza e distribuzione a priori è chiamata caso coniugato _Beta-Binomiale_ ed è descritto dal seguente teorema.

::: {.theorem}
Sia data la funzione di verosimiglianza $\Bin(n, y \mid \theta)$ e sia $\mbox{Beta}(\alpha, \beta)$ una distribuzione a priori. In tali circostanze, la distribuzione a posteriori del parametro $\theta$ sarà una distribuzione $\mbox{Beta}(\alpha + y, \beta + n - y)$.
:::

È facile calcolare il valore atteso a posteriori di $\theta$. Essendo $\E[\mbox{Beta}(\alpha, \beta)] = \frac{\alpha}{\alpha + \beta}$, il risultato cercato diventa
\begin{equation}
\E_{\text{post}} [\mathrm{Beta}(\alpha + y, \beta + n - y)] = \frac{\alpha + y}{\alpha + \beta +n}.
(\#eq:ev-post-beta-bin-1)
\end{equation}

::: {.exercise}
Usando le funzione $\R$ `plot_beta_binomial()` e `plot_beta_binomial()` del pacchetto `bayesrules`, si rappresenti in maniera grafica e si descriva in forma numerica l'aggiornamento bayesiano Beta-Binomiale per i dati di @zetschefuture2019. 

Per i dati in discussione, abbiamo:

```r
bayesrules::plot_beta_binomial(alpha = 2, beta = 10, y = 23, n = 30)
```



\begin{center}\includegraphics[width=0.8\linewidth]{026_conjugate_families_files/figure-latex/unnamed-chunk-6-1} \end{center}

\noindent
Un sommario delle distribuzioni a priori e a posteriori si ottiene usando la funzione `summarize_beta_binomial()`:

```r
bayesrules:::summarize_beta_binomial(alpha = 2, beta = 10, y = 23, n = 30)
#>       model alpha beta  mean mode    var     sd
#> 1     prior     2   10 0.167  0.1 0.0107 0.1034
#> 2 posterior    25   17 0.595  0.6 0.0056 0.0749
```
:::

::: {.exercise}
Per i dati di @zetschefuture2019, si trovino la media, la moda, la deviazione standard della distribuzione a posteriori di $\theta$. Si trovi inoltre l'intervallo di credibilità a posteriori del 95% per il parametro $\theta$.

Usando la \@ref(thm:beta-binom), possiamo ottenere l'intervallo di credibilità a posteriori del 95% per il parametro $\theta$ come segue:

```r
qbeta(c(0.025, 0.975), shape1 = 25, shape2 = 17)
#> [1] 0.445 0.737
```
\noindent
La media della distribuzione a posteriori è

```r
25 / (25 + 17)
#> [1] 0.595
```
\noindent
La moda della distribuzione a posteriori è

```r
(25 - 1) / (25 + 17 - 2)
#> [1] 0.6
```
\noindent
La deviazione standard della distribuzione a priori è

```r
sqrt((25 * 17) / ((25 + 17)^2 * (25 + 17 + 1)))
#> [1] 0.0749
```
:::

::: {.exercise}
Si trovino i parametri e le proprietà della distribuzione a posteriori del parametro $\theta$ per i dati dell'esempio relativo alla ricerca di Stanley Milgram discussa da @Johnson2022bayesrules.

Nel 1963, Stanley Milgram presentò una ricerca sulla propensione delle persone a obbedire agli ordini di figure di autorità, anche quando tali ordini possono danneggiare altre persone [@milgram1963behavioral]. Nell'articolo, Milgram descrive lo studio come

> *consist[ing] of ordering a naive subject to administer electric shock to a victim. A simulated shock generator is used, with 30 clearly marked voltage levels that range from IS to 450 volts. The instrument bears verbal designations that range from Slight Shock to Danger: Severe Shock. The responses of the victim, who is a trained confederate of the experimenter, are standardized. The orders to administer shocks are given to the naive subject in the context of a `learning experiment’ ostensibly set up to study the effects of punishment on memory. As the experiment proceeds the naive subject is commanded to administer increasingly more intense shocks to the victim, even to the point of reaching the level marked Danger: Severe Shock.*

\noindent
All'insaputa del partecipante, gli shock elettrici erano falsi e l'attore stava solo fingendo di provare il dolore dello shock.

@Johnson2022bayesrules fanno inferenza sui risultati dello studio di Milgram mediante il modello Beta-Binomiale. Il parametro di interesse è $\theta$, la probabiltà che una persona obbedisca all'autorità (in questo caso, somministrando lo shock più severo), anche se ciò significa recare danno ad altri. @Johnson2022bayesrules ipotizzano che, prima di raccogliere dati, le credenze di Milgram relative a $\theta$ possano essere rappresentate mediante una $\mbox{Beta}(1, 10)$. Sia $y = 26$ il numero di soggetti che, sui 40 partecipanti allo studio, aveva accettato di infliggere lo shock più severo. Assumendo che ogni partecipante si comporti indipendentemente dagli altri, possiamo modellare la dipendenza di $y$ da $\theta$ usando la distribuzione binomiale. Giungiamo dunque al seguente modello bayesiano Beta-Binomiale:
\begin{align}
y \mid \theta & \sim \Bin(n = 40, \theta) \notag\\
\theta & \sim \text{Beta}(1, 10) \; . \notag
\end{align}
Usando le funzioni di `bayesrules` possiamo facilmente calcolare i parametri e le proprietà della distribuzione a posteriori:

```r
bayesrules:::summarize_beta_binomial(alpha = 1, beta = 10, y = 26, n = 40)
#>       model alpha beta   mean  mode     var     sd
#> 1     prior     1   10 0.0909 0.000 0.00689 0.0830
#> 2 posterior    27   24 0.5294 0.531 0.00479 0.0692
```
\noindent
Il processo di aggiornamento bayesiano è descritto dalla figura seguente:

```r
bayesrules:::plot_beta_binomial(alpha = 1, beta = 10, y = 26, n = 40) 
```



\begin{center}\includegraphics[width=0.8\linewidth]{026_conjugate_families_files/figure-latex/unnamed-chunk-13-1} \end{center}
:::

## Principali distribuzioni coniugate

Esistono molte altre combinazioni simili di verosimiglianza e distribuzione a priori le quali producono una distribuzione a posteriori che ha la stessa densità della distribuzione a priori. Sono elencate qui sotto le più note coniugazioni tra modelli statistici e distribuzioni a priori.

- Per il modello Normale-Normale $\mathcal{N}(\mu, \sigma^2_0)$, la distribizione iniziale è $\mathcal{N}(\mu_0, \tau^2)$ e la distribuzione finale è $\mathcal{N}\left(\frac{\mu_0\sigma^2 + \bar{y}n\tau^2}{\sigma^2 + n\tau^2}, \frac{\sigma^2\tau^2}{\sigma^2 + n\tau^2} \right)$.

- Per il modello Poisson-gamma $\text{Po}(\theta)$, la distribizione iniziale è $\Gamma(\lambda, \delta)$ e la distribuzione finale è $\Gamma(\lambda + n \bar{y}, \delta +n)$.

- Per il modello esponenziale $\text{Exp}(\theta)$, la distribizione iniziale è $\Gamma(\lambda, \delta)$ e la distribuzione finale è $\Gamma(\lambda + n, \delta +n\bar{y})$.

- Per il modello uniforme-Pareto $\text{U}(0, \theta)$, la distribizione iniziale è $\mbox{Pa}(\alpha, \varepsilon)$ e la distribuzione finale è $\mbox{Pa}(\alpha + n, \max(y_{(n)}, \varepsilon))$.

## Considerazioni conclusive {-}

Lo scopo di questa discussione è stato quello di mostrare come sia possibile combinare le nostre conoscenze a priori (espresse nei termini di una densità di probabilità) con le evidenze fornite dai dati (espresse nei termini della funzione di verosimiglianza), così da determinare, mediante il teorema di Bayes, una distribuzione a posteriori, la quale condensa l'incertezza che abbiamo sul parametro $\theta$. Per illustrare tale problema, abbiamo considerato una situazione nella quale $\theta$ corrisponde alla probabilità di successo in una sequenza di prove Bernoulliane. Abbiamo visto come, in queste circostanze, sia ragionevole esprimere le nostre credenze a priori mediante la densità Beta, con opportuni parametri. L'inferenza rispetto ad una proporzione rappresenta un caso particolare, ovvero un caso nel quale la distribuzione a priori è Beta e la verosimiglianza è Binomiale. In tali circostanze, la distribuzione a posteriori diventa una distribuzione Beta -- questo è il cosiddetto modello Beta-Binomiale. Dato che utilizza una distribuzione a priori coniugata, dunque, il modello Beta-Binomiale rende possibile la determinazione analitica dei parametri della distribuzione a posteriori.  
