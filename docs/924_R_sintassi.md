## Sintassi di base {#chapter-sintassi}



`R` è un linguaggio di programmazione orientato all'analisi dei dati, il
calcolo e la visualizzazione grafica. È disponibile su Internet una
vasta gamma di materiali utile per avvicinarsi all'ambiente `R` e aiutare
l'utente nell'apprendimento di questo software statistico. Cercheremo
qui di fornire alcune indicazioni e una breve descrizione delle risorse
di base di `R`.

Aggiungo qui sotto alcune considerazioni che ho preso, pari pari, da un testo che tratta di un altro linguaggio di programmazione, ma che si applicano perfettamente anche al caso nostro. 

> Come in ogni linguaggio, per parlare in R è necessario seguire un insieme di regole. Come in tutti i linguaggi di programmazione, queste regole sono del tutto inflessibili e inderogabili. In R, un enunciato o è sintatticamente corretto o è incomprensibile all'interprete, che lo segnalerà all'utente. Questo aspetto non è esattamente amichevole per chi non è abituato ai linguaggi di programmazione, e si trova così costretto ad una precisione di scrittura decisamente poco "analogica". Tuttavia, ci sono due aspetti positivi nello scrivere codice, interrelati tra loro. Il primo è lo sforzo analitico necessario, che allena ad un'analisi precisa del problema che si vuole risolvere in modo da poterlo formalizzare linguisticamente. Il secondo concerne una forma di autoconsapevolezza specifica: salvo "bachi" nel linguaggio (rarissimi sebbene possibili), il mantra del programmatore è "Se qualcosa non ti funziona, è colpa tua" (testo adattato da Andrea Valle).

A chi preferisce un approccio più "giocoso" posso suggerire il seguente [link](https://tinystats.github.io/teacups-giraffes-and-statistics/01_introToR.html).


### Utilizzare la console `R` come calcolatrice

La console di RStudio contiene un cursore rappresentato dal simbolo "\>"
(linea di comando) dove si possono inserire i comandi e le funzioni --
in realtà è sempre meglio utilizzare un `R` Notebook anziché la console,
ma per ora esaminiamo il funzionamento di quest'ultima.

La console di RStudio può essere utilizzata come semplice calcolatrice.
I comandi elementari consistono di espressioni o di assegnazioni. Le
operazioni aritmetiche vengono eseguite mediante simboli "standard:" +,
\*, -, /, `sqrt()`, `log()`, `exp()`, ...

I comandi sono separati da un carattere di nuova linea (si immette un
carattere di nuova linea digitando il tasto `Invio`). Se un comando non
è completo alla fine della linea, `R` darà un prompt differente che per
default è il carattere `+` sulla linea seguente e continuerà a leggere
l'input finché il comando non è sintatticamente completo. Ad esempio,


```r
4 -
  +
    +1
#> [1] 3
```

`R` è un ambiente interattivo, ossia i comandi producono una risposta immediata. Se scriviamo `2 + 2` e premiamo il tasto di invio, comparirà nella riga successiva il risultato:


```r
2 + 2
#> [1] 4
```

Il risultato è preceduto da `[1]`, il che significa che il risultato dell'operazione che abbiamo appena eseguito è il primo valore di questa linea. Alcune funzioni ritornano più di un singolo numero e, in quel caso, l'informazione fornita da `R` è più utile. Per esempio, l'istruzione `100:130` ritorna $31$ valori, ovvero i numeri da $100$ a $130$:


```r
100:130
#>  [1] 100 101 102 103 104 105 106 107 108 109 110 111 112 113
#> [15] 114 115 116 117 118 119 120 121 122 123 124 125 126 127
#> [29] 128 129 130
```

In questo caso, sul mio computer, `[24]` indica che il valore $123$ è il ventiquattresimo numero che è stato stampato sulla console -- su un altro computer le cose possono essere diverse in quanto il risultato, credo, dipende dalla grandezza dello schermo.

### Espressioni

In questo corso, cercheremo di evitare i numeri nei nomi R, così come le lettere maiuscole e .. Useremo quindi nomi come: my_data, anova_results, square_root, ecc.

Un'espressione in `R` è un enunciato finito e autonomo del linguaggio: una frase conclusa, si potrebbe dire. Si noti che le espressioni in `R` non sono delimitate dal `;` come succede in alcuni linguaggi di programmazione. L'ordine delle espressioni è l'ordine di esecuzione delle stesse. 

L'a capo non è  rilevante per `R`. Questo permette di utilizzare l'a capo per migliorare la leggibilità  del codice.

### Oggetti

`R` è un linguaggio di programmazione a oggetti, quindi si basa sulla creazione di oggetti e sulla possibilità di salvarli nella memoria del programma. `R` distingue tra maiuscole e minuscole come la maggior parte dei linguaggi basati su UNIX, quindi `A` e `a` sono nomi diversi e fanno riferimento a oggetti diversi.

I comandi elementari di `R` consistono in espressioni o assegnazioni.

Se un'espressione viene fornita come comando, viene valutata, stampata sullo schermo e il valore viene perso, come succedeva alle operazioni aritmetiche che abbiamo presentato sopra discutendo l'uso della console `R` come calcolatrice.

Un'assegnazione crea un oggetto oppure valuta un'espressione e passa il valore a un oggetto, ma il risultato non viene stampato automaticamente sullo schermo. Per l'operazione di assegnazione si usa il simbolo `<-`. Ad esempio, per creare un oggetto che contiene il risultato dell'operazione `2 + 2` procediamo nel modo seguente:


```r
res_sum <- 2 + 2
res_sum
#> [1] 4
```

L'operazione di assegnazione (`<-`) copia il contenuto dell'operando destro (detto `r-value`) nell'operando sinistro detto (`l-value`). Il valore dell'espressione assegnazione è `r-value`. Nell'esempio precedente, `res_sum` (`l-value`) assume il valore di $4$.

### Variabili

L'oggetto `res_sum` è una _variabile_. Una spiegazione di ciò che questo significa è riportata qui sotto.

> Una variabile è  un segnaposto. Tutte le volte che si memorizza un dato lo si assegna ad una variabile. Infatti, se il dato è  nella memoria, per potervi accedere, è  necessario conoscere il suo indirizzo, la sua “etichetta” (come in un grande magazzino in cui si va a cercare un oggetto in base alla sua collocazione). Se il dato è  memorizzato ma inaccessibile (come nel caso di un oggetto sperso in un magazzino), allora non si può usare ed è  soltanto uno spreco di spazio. La teoria delle variabili è un ambito molto complesso nella scienza della computazione. Ad esempio, una aspetto importante può concernere la tipizzazione delle variabili. Nei linguaggi “tipizzati” (ad esempio C), l’utente dichiara che userà quella etichetta (la variabile) per contenere solo ed esclusivamente un certo tipo di oggetto (ad esempio, un numero intero), e la variabile non potrà essere utilizzata per oggetti diversi (ad esempio, una stringa). In questo caso, prima di usare una variabile se ne dichiara l’esistenza e se ne specifica il tipo. I linguaggi non tipizzati non richiedono all’utente di specificare il tipo, che viene inferito in vario modo (ad esempio, in funzione dell’assegnazione del valore alla variabile). Alcuni linguaggi (ad esempio Python) non richiedono neppure la dichiarazione della variabile, che viene semplicemente usata. È l’interprete che inferisce che quella stringa è una variabile. La tipizzazione impone vincoli d’uso sulle variabili e maggiore scrittura del codice, ma assicura una chiara organizzazione dei dati. In assenza di tipizzazione, si lavora in maniera più rapida e snella, ma potenzialmente si può andare incontro a situazioni complicate, come quando si cambia il tipo di una variabile “in corsa” senza accorgersene (Andrea Valle).

`R` è un linguaggio non tipicizzato, come Python. In `R` non è necessario dichiarare le variabili che si intendono utilizzare, né il loro tipo. 

### R console

La console di RStudio fornisce la possibilità di richiamare e rieseguire
i comandi. I tasti freccia verticale, $\uparrow$ e $\downarrow$, sulla
tastiera possono essere utilizzati per scorrere avanti e indietro i
comandi già immessi. Appena trovato il comando che interessa, lo si può
modificare, ad esempio, con i tasti freccia orizzontali, immettendo
nuovi caratteri o cancellandone altri.

Se viene digitato un comando che `R` non riconosce, sulla console viene visualizzato un messaggio di errore; ad esempio,


```r
3 % 9
Errore: unexpected input in "3 % 9"
```

### Parentesi

Le parentesi in `R` (come in generale in ogni linguaggio di programmazione) assegnano un significato diverso alle porzioni di codice che delimitano.

-   Le parentesi tonde funzionano come nell'algebra. Per esempio


```r
2 + 3 * 4
#> [1] 14
```

non è equivalente a


```r
(2 + 3) * 4
#> [1] 20
```

Le due istruzioni precedenti producono risultati diversi perché, se
    la sequenza delle operazioni algebriche non viene specificata dalle
    parentesi, `R` assegna alle operazioni algebriche il seguente ordine
    di priorità decrescente: esponenziazione, moltiplicazione /
    divisione, addizione / sottrazione, confronti logici
    (`<, >, <=, >=, ==, !=`). È sempre una buona idea rendere esplicito
    l'ordine delle operazioni algebriche che si vuole eseguire mediante
    l'uso delle parentesi tonde.\
    Le parentesi tonde vengono anche utilizzate per le funzioni, come
    vedremo nei prossimi paragrafi. Tra le parentesi tonde avremo dunque
    l'oggetto a cui vogliamo applicare la funzione e gli argomenti
    passati alla funzione.

-   Le parentesi graffe sono destinate alla programmazione. Un blocco
    tra le parentesi graffe viene letto come un oggetto unico che può
    contenere una o più istruzioni.

-   Le parentesi quadre vengono utilizzate per selezionare degli
    elementi, per esempio all'interno di un vettore, o di una matrice, o
    di un data.frame. L'argomento entro le parentesi quadre può essere
    generato da espressioni logiche.

### I nomi degli oggetti

Le entità create e manipolate da `R` si chiamano 'oggetti'. Tali oggetti
possono essere variabili (come nell'esempio che abbiamo visto sopra), array di numeri, caratteri, stringhe, funzioni, o più in generale strutture costruite a partire da tali
componenti. Durante una sessione di R gli oggetti sono creati e
memorizzati attraverso opportuni nomi.

I nomi possono contenere un qualunque carattere alfanumerico e come
carattere speciale il trattino basso (`_`) o il punto. R fornisce i
seguenti vincoli per i nomi degli oggetti: i nomi degli oggetti non
possono mai iniziare con un carattere numerico e non possono contenere i
seguenti simboli: `$`, `@`, `!`, `^`, `+`, `-`, `/`, `*`. È buona
pratica usare nomi come `ratio_of_sums`. È fortemente sconsigliato
utilizzare nei nomi degli oggetti caratteri accentati o, ancora peggio,
apostrofi. Per questa ragione è sensato creare i nomi degli oggetti
utilizzando la lingua inglese. È anche bene che i nomi degli oggetti non
coincidano con nomi di funzioni. Ricordo nuovamente che `R` è *case sensitive*, cioè
`A` e `a` sono due simboli diversi e identificano due oggetti
differenti.

In questo corso cercheremo di evitare i numeri nei nomi degli oggetti `R`, così come le lettere maiuscole e il punto. Useremo quindi nomi come: `my_data`, `regression_results`, `square_root`, ecc.

### Permanenza dei dati e rimozione di oggetti

Gli oggetti vengono salvati nello "spazio di lavoro" (*workspace*). Il
comando `ls()` può essere utilizzato per visualizzare i nomi degli
oggetti che sono in quel momento memorizzati in `R`.

Per eliminare oggetti dallo spazio di lavoro è disponibile la funzione
`rm()`; ad esempio


```r
rm(x, y, z, ink, junk, temp, foo, bar)
```

cancella tutti gli oggetti indicati entro parentesi. Per eliminare tutti
gli oggetti presenti nello spazio di lavoro si può utilizzare la
seguente istruzione:


```r
rm(list = ls())
```

### Chiudere R

Quando si chiude RStudio il programma ci chiederà se si desidera salvare
l'area di lavoro sul computer. Tale operazione è da evitare in quanto
gli oggetti così salvati andranno ad interferire con gli oggetti creati
in un lavoro futuro. Si consiglia dunque di rispondere negativamente a
questa domanda.

-   In RStudio, selezionare `Preferences` dal menu a tendina e, in
    `R General` `Workspace`, deselezionare l'opzione
    `Restore .RData into workspace at start-` `up` e scegliere l'opzione
    `Never` nella finestra di dialogo `Save workspace to`
    `.RData on exit`.

-   In R, selezionare `Preferences` dal menu a tendina e, in `Startup`,
    selezionare l'opzione `No` in corrispondenza dell'item
    `Save workspace on exit from R`.

### Creare ed eseguire uno script R con un editore 

È molto più facile interagire con R manipolando uno script con un
editore piuttosto che inserendo direttamente le istruzioni nella
console. `R` fornisce il Text Editor dove è possibile inserire il codice
(File $\to$ New Script). Per salvare il file basta utilizzare l'apposito
menù a tendina (estensione `.R`). Tale file potrà poi essere riaperto ed
utilizzato in un momento successivo.

L'editore comunica con `R` nel modo seguente: dopo avere selezionato la
porzione di codice che si vuole eseguire, si digita un'apposita sequenza
di tasti (`Command + Enter` su Mac OS X e `ctrl + r` in Windows).
`ctrl + r` significa premere il tasto `ctrl` e, tenendolo premuto, premere il tasto `r` della tastiera.
Così facendo, `R` eseguirà le istruzioni selezionate e l'output verrà
stampato sulla console. Il Text Editor fornito da `R` è piuttosto
primitivo: è fortemente consigliato utilizzare RStudio.

### Commentare il codice

Un "commento" è una parte di codice che l'interprete non tiene in considerazione. Quando l'interprete arriva ad un segnalatore di commento salta fino al segnalatore di fine commento e di lì riprende il normale processo esecutivo.

I commenti sono parole in linguaggio naturale (nel nostro caso l'italiano), che permettono agli utilizzatori di capire il flusso logico del codice e a chi lo ha scritto di ricordare il perché di determinate istruzioni. 

In `R`, le parole dopo il simbolo `#` sono considerate commenti e sono ignorate; ad esempio:


```r
# Questo e' un commento
```

### Cambiare la cartella di lavoro 

Quando si inizia una sessione di lavoro, `R` sceglie una cartella quale
"working directory". Sarà in tale cartella che andrà a cercare gli
script definiti dall'utilizzatore e i file dei dati. È possibile
determinare quale sia la corrente "working directory" digitando sulla
console di RStudio l'istruzione:


```r
getwd()
```

Per cambiare la cartella di lavoro (in maniera tale che corrisponda alla
cartella nella quale sono stati salvati i dati e gli script da eseguire)
si sceglie la voce `Set Working Directory` sul menù a tendina di RStudio
e si selezione la voce `Choose Directory…` Nella finestra che compare,
si cambia la cartella con quella che si vuole.

### L'oggetto base di R: il vettore

`R` opera su strutture di dati; la più semplice di tali strutture è il
vettore numerico, che consiste in un insieme ordinato di numeri; ad
esempio:


```r
x <- c(7.0, 10.2, -2.9, 21.4)
```

Nell'istruzione precedente, `c()` è una funzione. In R gli argomenti
sono passati alle funzioni inserendoli all'interno delle parentesi
tonde. Si noti che gli argomenti (in questo caso, i numeri
$7.0, 10.2, -2.9, 21.4$) sono separati a virgole. La funzione `c()` può
prendere un numero arbitrario di argomenti e genera un vettore
concatenando i suoi argomenti. L'operatore `<-` assegna un nome al
vettore che è stato creato. Nel caso presente, digitando `x` possiamo
visualizzare il vettore che abbiamo creato:


```r
x
#> [1]  7.0 10.2 -2.9 21.4
```

Se invece eseguiamo l'istruzione


```r
c(7.0, 10.2, -2.9, 21.4)
#> [1]  7.0 10.2 -2.9 21.4
```

senza assegnazione, il valore dell'espressione sarà visualizzato nella
console, ma il vettore non potrà essere utilizzato in nessun altro modo.

### Operazioni vettorializzate

Molte operazioni in `R` sono vettorializzate, il che significa che esse
sono eseguite in parallelo in determinati oggetti. Ciò consente di
scrivere codice che sia efficiente, conciso e più facile da leggere
rispetto al codice che contiene istruzioni non vettorializzate.

### Vettori aritmetici

L'esempio più semplice che illustra come si svolgono le operazioni
vettorializzate riguarda le operazioni algebriche applicate ai vettori.
I vettori, infatti, possono essere utilizzati in espressioni numeriche
nelle quali le operazioni algebriche vengono eseguite "elemento per
elemento".

Per illustrare questo concetto, definiamo il vettore `die` che contiene
i possibili risultati del lancio di un dado:


```r
die <- c(1, 2, 3, 4, 5, 6)
die
#> [1] 1 2 3 4 5 6
```

Supponiamo di volere sommare $10$ a ciascun elemento del vettore `die`.
Dato che le operazioni sui vettori sono eseguite elemento per elemento,
per ottenere questo risultato è sufficiente eseguire l'istruzione:


```r
die + 10
#> [1] 11 12 13 14 15 16
```

Si noti come la costante $10$ sia stata sommata a ciascun elemento del
vettore. In maniera corrispondente, l'istruzione


```r
die - 1
#> [1] 0 1 2 3 4 5
```

sottrarrà un'unità da ciascuno degli elementi del vettore `die`.

Se l'operazione aritmetica coinvolge due o più vettori, R allinea i vettori ed esegue una sequenza di operazioni elemento per elemento. Per esempio, l'istruzione


```r
die * die
#> [1]  1  4  9 16 25 36
```

fa sì che i due vettori vengano disposti l'uno di fianco all'altro per poi moltiplicare gli elementi corrispondenti: il primo elemento del primo vettore per il primo elemento del secondo vettore e così via. Il vettore risultante avrà la stessa dimensione dei due vettori che sono stati moltiplicati, come indicato qui sotto: 

$$
\begin{array}{ccccc}
1 & \times & 1 & \to & 1 \\
2 & \times & 2 & \to & 4 \\
3 & \times & 3 & \to & 9 \\
4 & \times & 4 & \to & 16 \\
5 & \times & 5 & \to & 25 \\
6 & \times & 6 & \to & 36 \\
\hline
\verb+die+ & * & \verb+die+ & = & 
\end{array}
$$
Oltre agli operatori aritmetici elementari `+`, `-`, `*`, `/`, e `^` per
l'elevamento a potenza, sono disponibili le più comuni funzioni
matematiche: `log()`, `exp()`, `sin()`, `cos()`, `tan()`, `sqrt()`,
`max()`, `min()` e così via. Altre funzioni di uso comune sono:
`range()` che restituisce un vettore `c(min(x), max(x))`; `sort()` che
restituisce un vettore ordinato; `length(x)` che restituisce il numero
di elementi di `x`; `sum(x)` che dà la somma degli elementi di `x`,
mentre `prod(x)` dà il loro prodotto. Due funzioni statistiche di uso
comune sono `mean(x)`, la media aritmetica, e `var(x)`, la varianza.

### Generazione di sequenze regolari

`R` possiede un ampio numero di funzioni per generare sequenze di numeri.
Ad esempio, `c(1:10)` è il vettore `c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)`.
L'espressione `c(30:1)` può essere utilizzata per generare una sequenza
all'indietro.

La funzione `seq()` genera un vettore che contiene una sequenza regolare
di numeri, generata in base a determinate regole. Può avere 5 argomenti:
i primi due rappresentano l'inizio (`from`) e la fine (`to`) della
sequenza, il terzo specifica l'ampiezza del passo (`by`), il quarto la
lunghezza della sequenza (`length.out`) e infine il quinto
(`along.with`), che se utilizzato deve essere l'unico parametro
presente, è il nome di un vettore, ad esempio `x`, creando in tal modo
la sequenza 1, 2, ..., `length(x)`. Esempi di utilizzo della funzione
`seq()` sono i seguenti:


```r
seq(from = 1, to = 10)
#>  [1]  1  2  3  4  5  6  7  8  9 10
seq(-5, 5, by = 2.5)
#> [1] -5.0 -2.5  0.0  2.5  5.0
seq(from = 1, to = 7, length.out = 4)
#> [1] 1 3 5 7
seq(along.with = die)
#> [1] 1 2 3 4 5 6
```

Altra funzione utilizzata per generare sequenze è `rep()` che può essere
utilizzata per replicare un oggetto in vari modi. Ad esempio:


```r
die3 <- rep(die, times = 3)
die3
#>  [1] 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6
```

metterà tre copie di `die` nell'oggetto `die3`.

### Generazione di numeri casuali 

La funzione `sample()` è una delle tante funzioni che possono essere
usate per generare numeri casuali. Per esempio, la seguente istruzione
simula dieci lanci di un dado a sei facce:


```r
roll <- sample(1:6, 10, replace = TRUE)
roll
#>  [1] 1 5 1 1 2 4 2 2 1 4
```

Il primo argomento di `sample()` è il vettore da cui la funzione
estrarrà degli elementi a caso; il secondo argomento specifica che
dovranno essere effettuate 10 estrazioni casuali; il terzo argomento
specifica che le estrazioni sono con rimessa (cioè, lo stesso elemento
può essere estratto più di una volta).

Scegliere un elemento a caso dal vettore $\{1, 2, 3, 4, 5, 6\}$ è
equivalente a lanciare un dado e osservare la faccia che si presenta.
L'istruzione precedente corrisponde dunque alla simulazione di dieci
lanci di un dado a sei facce.

### Vettori logici

Quando si manipolano i vettori, talvolta si vogliono trovare gli
elementi che soddisfano determinate condizioni logiche. Per esempio, in
dieci lanci di un dado, quante volte è uscito $5$? Per rispondere a
questa domanda si possono usare gli operatori logici `<`, `>` e `==` per
le operazioni di "minore di," "maggiore di" e "uguale a". Se scriviamo


```r
roll == 5
#>  [1] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [10] FALSE
```

creiamo un vettore costituito da elementi `TRUE/FALSE` i quali
identificano gli elementi del vettore che soddisfano la condizione
logica specificata.

Possiamo trattare tale vettore come se fosse costituito da elementi di
valore $0$ e $1$. Sommando gli elementi di tale vettore, infatti,
possiamo contare il numero di "5":


```r
sum(roll == 5)
#> [1] 1
```

### Dati mancanti

Quando si è in presenza di un dato mancante, R assegna il valore
speciale `NA`, che sta per *Not Available*. In generale, un'operazione
su un `NA` dà come risultato un `NA`. Nell'uso delle funzioni che
operano sui dati sarà dunque necessario specificare che, qualunque
operazione venga effettuata, gli `NA` devono essere esclusi.

### Vettori di caratteri e fattori

I vettori di caratteri si creano formando una sequenza di caratteri
delimitati da doppie virgolette e possono essere concatenati in un
vettore attraverso la funzione `c()`. Successivamente, si può applicare
la funzione `factor()`, che definisce automaticamente le modalità della
variabile categoriale. Ad esempio,


```r
soc_status <- factor(
  c("low", "high", "medium", "high", "low", "medium", "high")
)
levels(soc_status)
#> [1] "high"   "low"    "medium"
```

Talvolta l'ordine dei livelli del fattore non importa, mentre altre
volte l'ordine è importante, per esempio, quando una variable
categoriale viene rappresentata in un grafico. Per specificare l'ordine
dei livelli del fattore si usa la seguente sintassi:


```r
soc_status <-
  factor(soc_status, levels = c("low", "medium", "high"))
levels(soc_status)
#> [1] "low"    "medium" "high"
```

### Funzioni 

`R` offre la possibilità di utilizzare un'enorme libreria di funzioni che
permettono di svolgere operazioni complicate, quali ad esempio, il
campionamento casuale. Esaminiamo ora con più attenzione le proprietà
delle funzioni di `R` utilizzando ancora l'esempio del lancio di un dado.
Abbiamo visto in precedenza come il lancio di un dado possa essere
simulato da R con la funzione `sample()`. La funzione `sample()` prende
tre argomenti: il nome di un vettore, un numero chiamato `size` e un
argomento chiamato `replace`. La funzione `sample()` ritorna un numero
di elementi del vettore pari a `size`. Ad esempio


```r
sample(die, 2, replace = TRUE)
#> [1] 1 5
```

Assegnando `TRUE` all'argomento `replace` specifichiamo che vogliamo un
campionamento con rimessa.

Se volgiamo eseguire una serie di lanci indipendenti di un dado,
eseguiamo ripetutamente la funzione `sample()` ponendo `size` uguale a
1:


```r
sample(die, 1, replace = TRUE)
#> [1] 6
sample(die, 1, replace = TRUE)
#> [1] 4
sample(die, 1, replace = TRUE)
#> [1] 2
```

Come si fa a sapere quanti e quali argomenti sono richiesti da una
funzione? Tale informazione viene fornita dalla funzione `args()`. Nel
nostro caso


```r
args(sample)
#> function (x, size, replace = FALSE, prob = NULL) 
#> NULL
```

ci informa che il primo argomento è un vettore chiamato `x`, il secondo
argomento è chiamato `size` ed ha il significato descritto sopra, il
terzo argomento, `replace`, specifica se il campionamento è eseguito con
o senza reimmissione, e il quarto argomento, `prob`, assegna delle
probabilità agli elementi del vettore. Il significato degli argomenti
viene spiegato nel file di help della funzione. Si noti che agli ultimi
due argomenti sono stati assegnati dei valori, detti di default. Ciò
significa che, se l'utilizzatore non li cambia, verranno usati da . La
specificazione `replace = FALSE` significa che il campionamento viene
eseguito senza reimmissione. Se desideriamo un campionamento con
reimmissione, basta specificare `replace = TRUE` (nel caso di una
singola estrazione è ovviamente irrilevante). Ad esempio, l'istruzione
seguente simula i risultati di 10 lanci indipendenti di un dado:


```r
sample(die, 10, replace = TRUE)
#>  [1] 2 3 1 1 3 4 5 5 5 4
```

Infine, `prob = NULL` specifica che non viene alterata la probabilità di
estrazione degli elementi del vettore. In generale, gli argomenti di una
funzione possono essere oggetti come vettori, matrici, altre funzioni,
parametri o operatori logici.

`R` ha un sistema di help interno in formato HTML che si richiama con
`help.start()`. Per avere informazioni su qualche funzione specifica,
per esempio la funzione `sample()`, il comando da utilizzare è
`help(sample)` oppure `?sample`.

### Scrivere proprie funzioni

Abbiamo visto in precedenza come sia possibile simulare i risultati
prodotti da dieci lanci di un dado o, in maniera equivalente, dal
singolo lancio di dieci dadi. Possiamo replicare questo processo
digitando ripetutamente le stesse istruzioni nella console. Otterremo
ogni volta risultati diversi perché, ad ogni ripetizione, il generatore
di numeri pseudo-casuali di R dipende dal valore ottenuto dal clock
interno della macchina. La funzione `set.seed()` ci permette di
replicare esattamente i risultati della generazione di numeri casuali.
Per ottenere questo risultato, basta assegnare al seed un numero
arbitrario, es. `set.seed(12345)`. Tuttavia, questa procedura è
praticamente difficile da perseguire se il numero di ripetizioni è alto.
In tal caso è vantaggioso scrivere una funzione contenente il codice che
specifica il numero di ripetizioni. In questo modo, per trovare il
risultato cercato basterà chiamare la funzione una sola volta.

Le funzioni utilizzate da `R` sono costituite da tre elementi: il nome, il blocco del
codice e una serie di argomenti. Per creare una funzione è necessario
immagazzinare in R questi tre elementi e `function()` consente di
ottenere tale risultato usando la sintassi seguente:


```r
nome_funzione <- function(arg1, arg2, ...) {
  espressione1
  espressione2
  return(risultato)
}
```

Una chiamata di funzione è poi eseguita nel seguente modo:


```r
nome_funzione(arg1, arg2, ...)
```

Per potere essere utilizzata, una funzione deve essere presente nella
memoria di lavoro di `R`. Le funzioni salvate in un file possono essere
richiamate utilizzando la funzione `source()`, ad esempio,
`source("file_funzioni.R")`.

Consideriamo ora la funzione `two_rolls()` che ritorna la somma dei
punti prodotti dal lancio di due dadi non truccati:


```r
two_rolls <- function() {
  die <- 1:6
  res <- sample(die, size = 2, replace = TRUE)
  sum_res <- sum(res)
  return(sum_res)
}
```

La funzione `two_rolls()` inizia con il creare il vettore `die` che
contiene sei elementi: i numeri da $1$ a $6$. Viene poi utilizzata la
funzione `sample()` con gli gli argomenti, `die`, `size = 2` e
`replace = TRUE`. Tale funzione restituisce il risultato del lancio di
due dadi. Il risultato fornito da `sample(die, size = 2, replace = TRUE)` viene assegnato all'oggetto `res`. L'oggetto `res` corrisponde dunque ad un vettore di due elementi.
L'istruzione `sum(res)` somma gli elementi del vettore `res` e
attribuisce il risultato di questa operazione a `sum_res`. Infine, la
funzione `return()` ritorna il contenuto dell'oggetto `sum_res`.
Invocando la funzione `two_rolls()` si ottiene dunque la somma del
lancio di due dadi. In generale, la funzione `two_rolls()` produrrà un
risultato diverso ogni volta che viene usata:


```r
two_rolls()
#> [1] 6
two_rolls()
#> [1] 5
two_rolls()
#> [1] 3
```

La formattazione del codice mediante l'uso di spazi e rientri non è
necessaria ma è altamente raccomandata per minimizzare la probabilità di
compiere errori.

### Pacchetti

Le funzioni di `R` sono organizzate in pacchetti, i più importanti dei
quali sono già disponibili quando si accede al programma.

### Istallazione e upgrade dei pacchetti

Alcuni pacchetti non sono presenti nella release di base di `R`. Per
installare un pacchetto non presente è sufficiente scrivere nella
console:


```r
install.packages("nome_pacchetto")
```

Ad esempio,


```r
install.packages("ggplot2")
```

La prima volta che si usa questa funzione durante una sessione di lavoro
si dovrà anche selezionare da una lista il sito *mirror* da cui
scaricare il pacchetto.

Gli autori dei pacchetti periodicamente rilasciano nuove versioni dei
loro pacchetti che contengono miglioramenti di varia natura. Per
eseguire l'upgrade dei pacchetti `ggplot2` e `dplyr`, ad esempio, si usa
la seguente istruzione:


```r
update.packages(c("ggplot2", "dplyr"))
```

Per eseguire l'upgrade di tutti i pacchetti l'istruzione è


```r
update.packages()
```

### Caricare un pacchetto in R

L'istallazione dei pacchetti non rende immediatamente disponibili le
funzioni in essi contenute. L'istallazione di un pacchetto semplicemente
copia il codice sul disco rigido della macchina in uso. Per potere usare
le funzioni contenute in un pacchetto installato è necessario caricare
il pacchetto in . Ciò si ottiene con il comando:


```r
library("ggplot2")
```

se si vuole caricare il pacchetto `ggplot2`. A questo punto diventa
possibile usare le funzioni contenute in `ggplot2`. Queste operazioni si
possono anche eseguire usando dal menu a tendina di RStudio.

Per sapere quali sono i pacchetti già presenti nella release di `R` con
cui si sta lavorando, basta scrivere:


```r
library()
```



