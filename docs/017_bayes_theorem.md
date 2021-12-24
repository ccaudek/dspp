# Il teorema di Bayes {#chapter-teo-bayes}



Questo Capitolo presenterà il teorema di Bayes per calcolare la probabilità degli eventi riferiti a esperimenti casuali, ossia esperimenti di cui non si può prevedere il risultato finale ma di cui si conoscono tutti i possibili risultati. Prima di esaminare il teorema di Bayes verrà introdotta una sua componente, ovvero il teorema della probabilità totale. 


## Il teorema della probabilità totale 

Il teorema della probabilità totale fa uso della legge della probabilità
composta \@ref(eq:probcomposte). Lo discuteremo qui considerando il caso di una partizione dello spazio campionario in tre sottoinsiemi, ma è facile estendere tale discussione al caso di una partizione in un qualunque numero di sottoinsiemi.

::: {.theorem}
Sia $\{F_1, F_2, F_3\}$ una partizione dello spazio campionario
$\Omega$. Se $E$ è un qualunque altro evento, allora:
\begin{equation}
P(E) = P(E \cap F_1) + P(E \cap F_2) + P(E \cap F_3) \notag
(\#eq:prob-total-1a)
\end{equation}
ovvero
\begin{equation}
P(E) = P(E \mid F_1) P(F_1) + P (E \mid F_2) P(F_2) + P(E \mid F_3) P(F_3).
(\#eq:prob-total-1b)
\end{equation}
:::

Il teorema della probabilità totale afferma che, se l'evento $E$ è
costituito da tutti gli eventi elementari in $E \cap F_1$, $E \cap F_2$
e $E \cap F_3$, allora la probabilità $P(E)$ è data dalla somma delle
probabilità di questi tre eventi (figura \@ref(fig:tikz-prob-tot)).

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{017_bayes_theorem_files/figure-latex/tikz-prob-tot-1} 

}

\caption{Partizione dello spazio campionario $\Omega$.}(\#fig:tikz-prob-tot)
\end{figure}

::: {.exercise}
Si considerino tre urne, ciascuna delle quali contiene 100 palline:

-   Urna 1: 75 palline rosse e 25 palline blu,
-   Urna 2: 60 palline rosse e 40 palline blu,
-   Urna 3: 45 palline rosse e 55 palline blu.

\noindent
Una pallina viene estratta a caso da un'urna anch'essa scelta a caso.
Qual è la probabilità che la pallina estratta sia di colore rosso?

Sia $R$ l'evento "la pallina estratta è rossa" e sia $U_i$ l'evento che
corrisponde alla scelta dell'$i$-esima urna. Sappiamo che
$$
P(R \mid U_1) = 0.75, \qquad P(R \mid U_2) = 0.60, \qquad P(R \mid U_3) = 0.45.
$$
Gli eventi $U_1$, $U_2$ e $U_3$ costituiscono una partizione dello
spazio campionario in quanto $U_1$, $U_2$ e $U_3$ sono eventi
mutualmente esclusivi ed esaustivi, $P(U_1 \cup U_2 \cup U_3) = 1.0$. In
base al teorema della probabilità totale, la probabilità di estrarre una
pallina rossa è 

\begin{align}
P(R) &= P(R \mid U_1)P(U_1)+P(R \mid U_2)P(U_2)+P(R \mid U_3)P(U_3)\notag\\
&= 0.75 \cdot \frac{1}{3}+0.60 \cdot \frac{1}{3}+0.45 \cdot \frac{1}{3} =0.60.\notag
\end{align}
:::

::: {.exercise}
Consideriamo un'urna che contiene 5 palline rosse e 2 palline verdi. Due
palline vengono estratte, una dopo l'altra. Vogliamo sapere la
probabilità dell'evento "la seconda pallina estratta è rossa".

Lo spazio campionario è $\Omega = \{RR, RV, VR, VV\}$. Chiamiamo $R_1$
l'evento "la prima pallina estratta è rossa", $V_1$ l'evento "la prima
pallina estratta è verde", $R_2$ l'evento "la seconda pallina estratta è
rossa" e $V_2$ l'evento "la seconda pallina estratta è verde". Dobbiamo
trovare $P(R_2)$ e possiamo risolvere il problema usando il teorema
della probabilità
totale \@ref(eq:prob-total-1b):

\begin{align}
P(R_2) &= P(R_2 \mid R_1) P(R_1) + P(R_2 \mid V_1)P(V_1)\notag\\
&= \frac{4}{6} \cdot \frac{5}{7} + \frac{5}{6} \cdot \frac{2}{7} = \frac{30}{42} = \frac{5}{7}.\notag
\end{align}

Se la prima estrazione è quella di una pallina rossa, nell'urna restano
4 palline rosse e due verdi, dunque, la probabilità che la seconda
estrazione produca una pallina rossa è uguale a 4/6. La probabilità di
una pallina rossa nella prima estrazione è 5/7. Se la prima estrazione è
quella di una pallina verde, nell'urna restano 5 palline rosse e una
pallina verde, dunque, la probabilità che la seconda estrazione produca
una pallina rossa è uguale a 5/6. La probabilità di una pallina verde
nella prima estrazione è 2/7.
:::

## La regola di Bayes

Il teorema di Bayes rappresenta uno dei fondamenti della teoria della
probabilità e della statistica. Lo presentiamo qui considerando un
caso specifico per poi descriverlo nella sua forma più generale.

Sia $\{F_1, F_2\}$ una partizione dello spazio campionario $\Omega$.
Consideriamo un terzo evento $E \subset \Omega$ con probabilità non
nulla di cui si conoscono le probabilità condizionate rispetto ad $F_1$
e a $F_2$, ovvero $P(E \mid F_1)$ e $P(E \mid F_2)$. È chiaro per le
ipotesi fatte che se si verifica $E$ deve anche essersi verificato
almeno uno degli eventi $F_1$ e $F_2$. Supponendo che si sia verificato
l'evento $E$, ci chiediamo: qual è la probabilità che si sia verificato
$F_1$ piuttosto che $F_2$?

\begin{figure}[h]

{\centering \includegraphics[width=0.45\linewidth]{017_bayes_theorem_files/figure-latex/unnamed-chunk-1-1} 

}

\end{figure}

Per rispondere alla domanda precedente scriviamo: 
\begin{align}
P(F_1 \mid E) &= \frac{P(E \cap F_1)}{P(E)}\notag\\ 
              &= \frac{P(E \mid F_1)P(F_1)}{P(E)}.\notag
\end{align}
Sapendo che $E = (E \cap F_1) \cup (E \cap F_2)$ e che $F_1$ e $F_2$ sono eventi disgiunti, ovvero $F_1 \cap F_2 = \emptyset$, ne segue che possiamo calcolare $P(E)$ utilizzando il teorema della probabilità totale:
\begin{align}
P(E) &= P(E \cap F_1) + P(E \cap F_2)\notag\\ 
     &= P(E \mid F_1)P(F_1) + P(E \mid F_2)P(F_2).\notag
\end{align}
\noindent
Sostituendo il risultato precedente nella formula della probabilità condizionata $P(F_1 \mid E)$ otteniamo:
\begin{equation}
P(F_1 \mid E) = \frac{P(E \mid F_1)P(F_1)}{P(E \mid F_1)P(F_1) + P(E \mid F_2)P(F_2)}.
(\#eq:bayes1)
\end{equation}
\noindent
La \@ref(eq:bayes1) si generalizza facilmente al caso di più di due eventi disgiunti, come indicato di seguito.

<!-- Siano $F_1$, $F_2,$ ..., $F_n$ $n$ eventi disgiunti con $P(F_i) > 0$ e -->
<!-- tali che $\bigcup_{i=1}^{n} F_i = \Omega$. Per l'evento -->
<!-- $E \subset \Omega$ con $P(E) > 0$, abbiamo -->

::: {.theorem}
Sia $E$ un evento contenuto in $F_1 \cup \dots \cup F_k$, dove gli eventi $F_j, j=1, \dots, k$ sono a due a due incompatibili e necessari. Allora per ognuno dei suddetti eventi $F_j$ vale la seguente formula:
  
\begin{equation}
P(F_j \mid E) = \frac{P(E \mid F_j)P(F_j)}{\sum_{j=1}^{k}P(F_j)P(E \mid F_j)}.
(\#eq:bayes2)
\end{equation}
:::

\noindent
La \@ref(eq:bayes2) prende il nome di *Teorema di Bayes* e mostra che la conoscenza del verificarsi dell'evento $E$ modifica la probabilità che abbiamo attribuito all'evento $F_j$. Nella \@ref(eq:bayes2) la probabilità condizionata $P(F_j \mid E)$ prende il nome di probabilità _a posteriori_ dell'evento $F_j$: il termine "a posteriori" sta a significare "dopo che è noto che si è verificato l'evento $E$". Nel capitolo \@ref(chapter-intro-bayes-inference) estenderemo questa discussione mostrando come la \@ref(eq:bayes2) possa essere formulata in un modo più generale, ovvero in modo tale che non faccia riferimento unicamente alla probabilità di eventi, ma bensì anche alle funzioni di densità di probabilità. 


<!-- ### Motivazioni per una probabilità bayesiana {#par:probfreq} -->

<!-- La definizione frequentista di probabilità può essere riassunta nel noto limite  -->
<!-- \begin{equation} -->
<!-- p(y) = \lim_{n\rightarrow \infty}\frac{n_y}{n}, -->
<!-- (\#eq:def-prob-freq) -->
<!-- \end{equation} -->

<!-- \noindent -->
<!-- dove $n$ è il numero totale di prove e $n_y$ il numero di volte in cui è stato ottenuto il risultato $y$. Nella trattazione frequentista, la probabilità è considerata come un elemento oggettivo della realtà, indipendente dallo stato di conoscenza soggettivo dell'agente che sta effettivamente compiendone l'assegnazione.  -->

<!-- È chiaro che definizione di $p(y)$ fornita sopra è empirica ma, se ci pensiamo, è anche chiaro che essa risulta nel contempo mal definita, considerata l'impossibilità pratica di osservare una serie infinita di eventi. Nel paradigma frequentista è dunque necessario assumere che la probabilità $p(y)$ sia una proprietà oggettiva della realtà, ma non osservabile se non in maniera asintotica. Questo assunto viene rifiutato dall'approccio bayesiano. -->


### Le probabilità come grado di fiducia

Il teorema di Bayes rende esplicito il motivo per cui la probabilità non può essere pensata come uno stato oggettivo, quanto piuttosto come un'inferenza soggettiva e condizionata. Il denominatore del membro di destra della \@ref(eq:bayes2) è un semplice fattore di normalizzazione. Nel numeratore compaiono invece due quantità: $P(F_j$) e $P(E \mid F_j)$. La probabilità $P(F_j$) è la probabilità _probabilità a priori_ (_prior_) dell'evento $F_j$ e rappresenta l'informazione che l'agente bayesiano possiede a proposito dell'evento $F_j$. Diremo che $P(F_j)$ codifica il grado di fiducia che l'agente ripone in $F_j$, sul quale non possiamo porre vincoli di alcun tipo. La probabilità condizionata $P(E \mid F_j)$ rappresenta invece la verosimiglianza di $F_j$ e ci dice quant'è plausibile che si verifichi l'evento $E$ condizionatemente al fatto che si sia verificato $F_j$.  


<!-- \begin{equation} -->
<!-- p(A \mid B) = \frac{p(B \mid A) p(B)}{p(B)}, -->
<!-- (\#eq:bayesab) -->
<!-- \end{equation} -->
<!-- dove $p(A)$ e $p(B)$ sono le probabilità di osservare gli eventi $A$ e $B$, e $p(A \mid B)$ e $p(B \mid A)$ sono rispettivamente le probabilità di osservare $A$ avendo osservato $B$ e viceversa,  -->

<!-- Si noti che l'agente è un concetto privo di valore nel modello frequentista ma che diviene invece centrale in quello bayesiano.  -->
Nell'interpretazione bayesiana $P(F_j)$ rappresenta un giudizio personale dell'agente e non esistono criteri esterni che possano determinare se tale giudizio sia coretto o meno. Il teorema di Bayes descrive la regola che l'agente deve seguire per aggiornare il suo grado di fiducia in $F_j$ alla luce di un ulteriore evento $E$. Per questo motivo abbiamo chiamato $P(F_j \mid E)$ probabilità a posteriori: essa rappresenta infatti la nuova probabilità che l'agente assegna ad $F_j$ affinché rimanga consistente con le nuove informazioni fornitegli da $E$. 

La probabilità a posteriori dipende sia da $E$, sia dalla conoscenza a priori dell'agente $P(F_j)$. In questo senso è chiaro come non abbia senso parlare di una probabilità oggettiva: per il teorema di Bayes la probabilità è definita condizionatamente alla probabilità a priori, la quale a sua volta, per definizione, è un'assegnazione soggettiva. Ne segue pertanto che ogni probabilità debba essere una rappresentazione del grado di fiducia (soggettiva) dell'agente.

Se ogni assegnazione probabilistica rappresenta uno stato di conoscenza, è altresì vero che un particolare stato di conoscenza è arbitrario e dunque non deve esserci necessariamente accordo a priori tra diversi agenti. Tuttavia, alla luce di nuove informazioni, la teoria delle probabilità ci fornisce uno strumento che consente l'aggiornamento dello stato di conoscenza in un modo razionale. 


### Aggiornamento bayesiano

Il teorema di Bayes consente di modificare una credenza a priori in maniera dinamica, via via che nuove evidenze vengono raccolte, in modo tale da formulare una credenza a posteriori la quale non è mai definitiva, ma può sempre essere aggiornata in base alle nuove evidenze disponibili. Questo processo si chiama *aggiornamento bayesiano*.

::: {.exercise}
Supponiamo che, per qualche strano errore di produzione, una fabbrica
produca due tipi di monete. Il primo tipo di monete ha la caratteristica
che, quando una moneta viene lanciata, la probabilità di osservare
l'esito "testa" è 0.6. Per semplicità, sia $\theta$ la probabilità di
osservare l'esito "testa". Per una moneta del primo tipo, dunque,
$\theta = 0.6$. Per una moneta del secondo tipo, invece, la probabilità
di produrre l'esito "testa" è 0.4. Ovvero, $\theta = 0.4$. 

Noi possediamo una moneta, ma non sappiamo se è del primo tipo o del secondo tipo. Sappiamo solo che il 75% delle monete sono del primo tipo e il 25% sono del secondo tipo. Sulla base di questa conoscenza *a priori* -- ovvero sulla base di una conoscenza ottenuta senza avere eseguito
l'esperimento che consiste nel lanciare la moneta una serie di volte per
osservare gli esiti prodotti -- possiamo dire che la probabilità di una
prima ipotesi, secondo la quale $\theta = 0.6$, è 3 volte più grande
della probabilità di una seconda ipotesi, secondo la quale
$\theta = 0.4$. Senza avere eseguito alcun esperimento casuale con la
moneta, questo è quello che sappiamo.

Ora immaginiamo di lanciare una moneta due volte e di ottenere il
risultato seguente: $\{T, C\}$. Quello che ci chiediamo è: sulla base di
questa evidenza, come cambiano le probabilità che associamo alle due
ipotesi? In altre parole, ci chiediamo qual è la probabilità di ciascuna
ipotesi alla luce dei dati che sono stati osservati: $P(H \mid y)$,
laddove $y$ sono i dati osservati. Tale probabilità si chiama
probabilità a posteriori. Inoltre, se confrontiamo le due ipotesi, ci
chiediamo quale valore assuma il rapporto $\frac{P(H_1 \mid y)}{P(H_2 \mid y)}$. 
Tale rapporto ci dice quanto è più probabile $H_1$ rispetto ad $H_2$, alla luce dei dati osservati.
Infine, ci chiediamo come cambia il rapporto definito sopra, quando osserviamo via via nuovi risultati prodotti dal lancio della moneta.

Definiamo il problema in maniera più chiara. 
Conosciamo le probabilità a priori, ovvero $P(H_1) = 0.75$ e $P(H_1) = 0.25$. 
Quello che vogliamo conoscere sono le probabilità a posteriori $P(H_1 \mid y)$ e
$P(H_2 \mid y)$. 

Per trovare le probabilità a posteriori applichiamo il teorema di Bayes: 
$$
P(H_1 \mid y) = \frac{P(y \mid H_1) P(H_1)}{P(y)} = 
\frac{P(y \mid H_1) P(H_1)}{P(y \mid H_1) P(H_1) + P(y \mid H_2) P(H_2)}
$$
laddove lo sviluppo del denominatore deriva da un'applicazione del teorema della probabilità totale. 
Inoltre, 
$$
P(H_2 \mid y) = 
\frac{P(y \mid H_2) P(H_2)}{P(y \mid H_1) P(H_1) + P(y \mid H_2) P(H_2)}.
$$
Se consideriamo l'ipotesi $H_1$ = "la probabilità di testa è 0.6", allora
la verosimiglianza dei dati $\{T, C\}$, ovvero la probabilità di osservare questa specifica sequenza di T e C, è uguale a $0.6 \times 0.4 = 0.24.$
Dunque, $P(y \mid H_1) = 0.24$. 

Se invece consideriamo l'ipotesi $H_2$ = "la probabilità di testa è 0.4", allora la verosimiglianza dei dati $\{T, C\}$ è $0.4 \times 0.6 = 0.24$, ovvero, $P(y \mid H_2) = 0.24$. 
In base alle due ipotesi $H_1$ e $H_2$, dunque, i dati osservati hanno la
medesima plausibilità di essere osservati. 
Per semplicità, calcoliamo anche
$$
\begin{aligned}
P(y) &= P(y \mid H_1) P(H_1) + P(y \mid H_2) P(H_2) = 0.24 \cdot 0.75 + 0.24 \cdot 0.25 = 0.24.\notag
\end{aligned}
$$
Le probabilità a posteriori diventano: 
$$
\begin{aligned}
P(H_1 \mid y) &= \frac{P(y \mid H_1) P(H_1)}{P(y)} = \frac{0.24 \cdot 0.75}{0.24} = 0.75,\notag
\end{aligned}
$$
$$
\begin{aligned}
P(H_2 \mid y) &= \frac{P(y \mid H_2) P(H_2)}{P(y)} = \frac{0.24 \cdot 0.25}{0.24} = 0.25.\notag
\end{aligned}
$$
Possiamo dunque concludere dicendo che, sulla base dei dati osservati, l'ipotesi $H_1$ ha una probabilità 3 volte maggiore di essere vera dell'ipotesi $H_2$.

È tuttavia possibile raccogliere più evidenze e, sulla base di esse, le probabilità a posteriori cambieranno.  Supponiamo di lanciare la moneta una terza volta e di osservare croce. I nostri dati dunque sono $\{T, C, C\}$. 

Di conseguenza, $P(y \mid H_1) = 0.6 \cdot 0.4 \cdot 0.4 = 0.096$ e $P(y \mid H_2) = 0.4 \cdot 0.6 \cdot 0.6 = 0.144$. 
Ne segue che le probabilità a posteriori diventano: 
$$
\begin{aligned}
P(H_1 \mid y) &= \frac{P(y \mid H_1) P(H_1)}{P(y)} = \frac{0.096 \cdot 0.75}{0.096 \cdot 0.75 + 0.144 \cdot 0.25} = 0.667,\notag
\end{aligned}
$$
$$\begin{aligned}
P(H_2 \mid y) &= \frac{P(y \mid H_2) P(H_2)}{P(y)} = \frac{0.144 \cdot 0.25}{0.096 \cdot 0.75 + 0.144 \cdot 0.25} = 0.333.\notag\end{aligned}$$
In queste circostanze, le evidenze che favoriscono $H_1$ nei confronti
di $H_2$ sono solo pari ad un fattore di 2.

Se otteniamo ancora croce in un quarto lancio della moneta, i nostri
dati diventano: $\{T, C, C, C\}$. 
Ripetendo il ragionamento fatto sopra,
$P(y \mid H_1) = 0.6 \cdot 0.4 \cdot 0.4 \cdot 0.4 = 0.0384$ e
$P(y \mid H_2) = 0.4 \cdot 0.6 \cdot 0.6 \cdot 0.6 = 0.0864$. 
Dunque
$$
\begin{aligned}
P(H_1 \mid y) &= \frac{0.0384 \cdot 0.75}{0.0384 \cdot 0.75 + 0.0864 \cdot 0.25} = 0.571,\notag
\end{aligned}
$$
$$
\begin{aligned}
P(H_2 \mid y) &= \frac{0.0864 \cdot 0.25}{0.0384 \cdot 0.75 + 0.0864 \cdot 0.25} = 0.429.\notag
\end{aligned}
$$
e le evidenze a favore di $H_1$ si riducono a 1.33. Se si ottenesse un
altro esito croce in un sesto lancio della moneta, l'ipotesi $H2$
diventerebbe più probabile dell'ipotesi $H_1$.

In conclusione, questo esercizio ci fa capire come sia possibile aggiornare le nostre credenze sulla base delle evidenze disponibili, ovvero come sia possibile passare da un grado di conoscenza del mondo a priori a una conoscenza a posteriori. 
Se prima di lanciare la moneta ritenevamo che l'ipotesi $H_1$ fosse tre volte più plausibile dell'ipotesi $H_2$, dopo avere osservato uno specifico campione di dati siamo giunti alla conclusione opposta. 
Il processo di aggiornamento bayesiano, dunque, ci fornisce un metodo per modificare il livello di fiducia in una data ipotesi, alla luce di nuove informazioni.
:::

## Considerazioni conclusive {-}

Il teorema di Bayes costituisce il fondamento dell'approccio più moderno
della statistica, quello appunto detto bayesiano. Chi usa il teorema di
Bayes non è, solo per questo motivo, "bayesiano": ci vuole ben altro. Ci
vuole un modo diverso per intendere il significato della probabilità e
un modo diverso per intendere gli obiettivi dell'inferenza statistica. In anni recenti, una gran parte della comunità scientifica ha riconosciuto all'approccio bayesiano il merito di consentire lo sviluppo di modelli anche molto complessi (intrattabili in base all'approccio frequentista) senza richiedere, d'altra parte, conoscenze matematiche troppo avanzate all'utente. Per questa ragione l'approccio bayesiano sta prendendo sempre più piede, anche in psicologia. 



