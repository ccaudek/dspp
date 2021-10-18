# Numeri binari, interi, razionali, irrazionali e reali  


## Numeri binari 

I numeri più semplici sono quelli binari, cioè zero o uno. Useremo spesso
numeri binari per indicare se qualcosa è vero o falso, presente o
assente.

I numeri binari sono molto utili per ottenere facilmente delle statistiche riassuntive in R.Supponiamo di chiedere a 10 studenti "Ti piacciono i mirtilli?" Poniamo che le risposte siano le seguenti:


```r
opinion <- c('Yes','No','Yes','No','Yes','No','Yes','Yes','Yes','Yes')
opinion
```

```
##  [1] "Yes" "No"  "Yes" "No"  "Yes" "No"  "Yes" "Yes" "Yes" "Yes"
```

Tali risposte possono essere ricodificate nei termini di valori di
verità, ovvero, vero e falso, generalmente denotati rispettivamente come
1 e 0. In R tale ricodifica può essere effettuata mediante l'operatore
`==` che è un test per l'uguaglianza e restituisce il valore logico VERO
se i due oggetti valutati sono uguali e FALSO se non lo sono:


```r
opinion <- opinion == "Yes"
opinion
```

```
##  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
```

R considera i valori di verità e i numeri binari in modo equivalente, con
TRUE uguale a 1 e FALSE uguale a zero. Di conseguenza, possiamo
effettuare operazioni algebriche sui valori logici VERO e FALSO.
Nell'esempio, possiamo sommare i valori di verità e dividere per 10


```r
sum(opinion) / length(opinion)
```

```
## [1] 0.7
```

in modo tale da calcolare una propozione, il che ci consente di concludere che 7 risposte su 10 sono positive.


## Numeri interi 

Un numero intero è un numero senza decimali. Si dicono __naturali__ i
numeri che servono a contare, come 1, 2, ... L'insieme dei numeri
naturali si indica con il simbolo $\mathbb{N}$. È anche necessario
introdurre i numeri con il segno per poter trattare grandezze negative.
Si ottengono così l'insieme numerico dei numeri interi relativi:
$\mathbb{Z} = \{0, \pm 1, \pm 2, \dots \}$


## Numeri razionali 

I numeri razionali sono i numeri frazionari $m/n$, dove $m, n \in N$,
con $n \neq 0$. Si ottengono così i numeri razionali:
$\mathbb{Q} = \{\frac{m}{n} \,\vert\, m, n \in \mathbb{Z}, n \neq 0\}$.
È evidente che $\mathbb{N} \subseteq \mathbb{Z} \subseteq \mathbb{Q}$.
Anche in questo caso è necessario poter trattare grandezze negative. I
numeri razionali non negativi sono indicati con
$\mathbb{Q^+} = \{q \in \mathbb{Q} \,\vert\, q \geq 0\}$.


## Numeri irrazionali 

Tuttavia, non tutti i punti di una retta $r$ possono essere
rappresentati mediante i numeri interi e razionali. È dunque necessario
introdurre un'altra classe di numeri. Si dicono __irrazionali__, e sono
denotati con $\mathbb{R}$, i numeri che possono essere scritti come una
frazione $a / b$, con $a$ e $b$ interi e $b$ diverso da 0. I numeri
irrazionali sono i numeri illimitati e non periodici che quindi non
possono essere espressi sotto forma di frazione. Per esempio,
$\sqrt{2}$, $\sqrt{3}$ e ${\displaystyle \pi =3,141592\ldots}$ sono
numeri irrazionali.


## Numeri reali 

I punti della retta $r$ sono quindi "di più" dei numeri razionali. Per
poter rappresentare tutti i punti della retta abbiamo dunque bisogno dei
numeri __reali__. I numeri reali possono essere positivi, negativi o nulli
e comprendono, come casi particolari, i numeri interi, i numeri
razionali e i numeri irrazionali. Spesso in statisticac il numero dei
decimali indica il grado di precisione della misurazione.


## Intervalli 

Un intervallo si dice chiuso se gli estremi sono compresi
nell'intervallo, aperto se gli estremi non sono compresi. Le
caratteristiche degli intervalli sono riportate nella tabella seguente.

               Intervallo                          
  ------------------------------------- ----------- -------------------
                 chiuso                  $[a, b]$   $a \leq x \leq b$
                 aperto                  $(a, b)$     $a < x < b$
   chiuso a sinistra e aperto a destra   $[a, b)$    $a \leq x < b$
   aperto a sinistra e chiuso a destra   $(a, b]$    $a < x \leq b$



