# Probabilità congiunta {#chapter-prob-congiunta}



<!-- Finora abbiamo considerato unicamente le leggi di singole variabile -->
<!-- aleatorie.  -->
<!-- In psicologia e nella vita quotidiana siamo spesso interessati a studiare problemi di probabilità legati al valore congiunto di due o più variabili casuali. Ad esempio, potremmo misurare il QI dei bambini e il loro peso alla nascita, o l'altezza e il peso delle giraffe, o il livello di inquinamento atmosferico e il tasso di malattie respiratorie nelle città, o il numero di amici di Facebook e l'età. Ci potremmo chiedere che relazione esiste tra le coppie di variabili elencate in precedenza. -->

::: {.chapterintro data-latex=""}
Per descrivere la relazione tra due variabili casuali è necessario calcolare la *covarianza* e la *correlazione*. Il calcolo di questi due indici richiede la conoscenza della funzione di probabilità congiunta. Obiettivo di questo Capitolo è descrivere la funzione di probabilità congiunta di due variabili casuali; esamineremo in dettaglio il caso discreto.
:::

## Funzione di probabilità congiunta

Dopo aver trattato della distribuzione di probabilità di una variabile casuale, la quale associa ad ogni evento elementare dello spazio campionario uno ed un solo numero reale, è naturale estendere questo concetto al caso di due o più variabili casuali. Iniziamo a descrivere il caso discreto con un esempio. Consideriamo l'esperimento casuale corrispondente al lancio di tre monete equilibrate. Lo spazio campionario è

$$
\Omega = \{TTT, TTC, TCT, CTT, CCT, CTC, TCC, CCC\}.
$$ 
\noindent
Dato che i tre lanci sono tra loro indipendenti, non c'è ragione di aspettarsi che uno degli otto risultati possibili dell'esperimento sia più probabile degli altri, dunque possiamo associare a ciascuno degli otto eventi elementari dello spazio campionario la stessa probabilità, ovvero 1/8.

Siano $X \in \{0, 1, 2, 3\}$ = "numero di realizzazioni con il risultato testa nei tre lanci" e $Y \in \{0, 1\}$ = "numero di realizzazioni con il risultato testa nel primo lancio" due variabili casuali definite sullo spazio campionario $\Omega$. Indicando con T = 'testa' e C = 'croce', si ottiene la situazione riportata nella tabella \@ref(tab:tre-monete-distr-cong-1).

Table: (\#tab:tre-monete-distr-cong-1) Spazio campionario dell'esperimento consistente nel lancio di tre monete equilibrate su cui sono state definite le variabili aleatorie $X$ e $Y$.

       $\omega$       $X$   $Y$   $P(\omega)$
  ------------------ ----- ----- -------------
   $\omega_1$ = TTT    3     1        1/8
   $\omega_2$ = TTC    2     1        1/8
   $\omega_3$ = TCT    2     1        1/8
   $\omega_4$ = CTT    2     0        1/8
   $\omega_5$ = CCT    1     0        1/8
   $\omega_6$ = CTC    1     0        1/8
   $\omega_7$ = TCC    1     1        1/8
   $\omega_8$ = CCC    0     0        1/8

Ci poniamo il problema di associare un livello di probabilità ad ogni coppia $(x, y)$ definita su $\Omega$. La coppia $(X = 0, Y = 0)$ si realizza in corrispondenza di un solo evento elementare, ovvero CCC; avrà dunque una probabilità pari a $P(X=0, Y=0) = P(CCC) = 1/8$. Nel caso della coppia $(X = 1, Y = 0)$ ci sono due eventi elementari che danno luogo al risultato considerato, ovvero, CCT e CTC; la probabilità $P(X=1, Y=0)$ sarà dunque data dalla probabilità dell'unione dei due eventi elementari, cioé $P(X=1, Y=0) = P(CCT \:\cup\: CTC) = 1/8 + 1/8 = 1/4$. Sono riportati qui sotto i calcoli per tutti i possibili valori di $X$ e $Y$.
\begin{align}
P(X = 0, Y = 0) &= P(\omega_8 = CCC) = 1/8; \notag\\
P(X = 1, Y = 0) &= P(\omega_5 = CCT) + P(\omega_6 = CTC) = 2/8; \notag\\
P(X = 1, Y = 1) &= P(\omega_7 = TCC) = 1/8; \notag\\
P(X = 2, Y = 0) &= P(\omega_4 = CTT) = 1/8; \notag\\
P(X = 2, Y = 1) &= P(\omega_3 = TCT) + P(\omega_2 = TTC) = 2/8; \notag\\
P(X = 3, Y = 1) &= P(\omega_1 = TTT) = 1/8; \notag
\end{align}
Le probabilità così trovate sono riportate nella tabella \@ref(tab:ditr-cong-biv-1) la quale descrive la distribuzione di probabilità congiunta delle variabili casuali $X$ = "numero di realizzazioni con il risultato testa nei tre lanci" e $Y$ = "numero di realizzazioni con il risultato testa nel primo lancio" per l'esperimento casuale consistente nel lancio di tre monete equilibrate.

Table: (\#tab:ditr-cong-biv-1) Distribuzione di probabilità congiunta per i risultati dell'esperimento consistente nel lancio di tre monete equilibrate.

   $x / y$      0     1   
  ---------- ----- ----- 
      0       1/8    0   
      1       2/8   1/8  
      2       1/8   2/8  
      3        0    1/8  

In generale, possiamo dire che, dato uno spazio campionario discreto $\Omega$, è possibile associare ad ogni evento elementare $\omega_i$ dello spazio campionario una coppia di numeri reali $(x, y)$, essendo $x = X(\omega)$ e $y = Y(\omega)$, il che ci conduce alla seguente definizione.

::: {.definition}
Siano $X$ e $Y$ due variabili casuali. La funzione che associa ad ogni coppia $(x, y)$ un livello di probabilità prende il nome di funzione di probabilità congiunta:
$$
P(x, y) = P(X = x, Y = y).
$$
::: 

\noindent
Il termine "congiunta" deriva dal fatto che questa probabilità è legata al verificarsi di una coppia di valori, il primo associato alla variabile casuale $X$ ed il secondo alla variabile casuale $Y$. Nel caso di due sole variabili casuali si parla di distribuzione bivariata, mentre nel caso di più variabili casuali si parla di distribuzione multivariata.


### Proprietà

Una distribuzione di massa di probabilità congiunta bivariata deve soddisfare due proprietà:

1.  $0 \leq P(x_i, y_j) \leq 1$;

2.  la probabilità totale deve essere uguale a $1.0$. Tale proprietà può essere espressa nel modo seguente
$$
\sum_{i} \sum_{j} P(x_i, y_j) = 1.0.
$$

### Eventi

Si noti che dalla probabilità congiunta possiamo calcolare la probabilità di qualsiasi evento definito in base alle variabili aleatorie $X$ e $Y$. Per capire come questo possa essere fatto, consideriamo nuovamente l'esperimento casuale discusso in precedenza.

::: {.example}
Per la distribuzione di massa di probabilità congiunta riportata nella tabella precedente si trovi la probabilità dell'evento $X+Y \leq 1$.

Per trovare la probabilità richiesta dobbiamo semplicemente sommare le probabilità associate a tutte le coppie $(x,y)$ che soddisfano la condizione $X+Y \leq 1$, ovvero

\begin{equation}
P_{XY}(X+Y \leq 1) = P_{XY}(0, 0) + P_{XY}(1, 0)= 3/8.\notag
\end{equation}
::: 


### Regola della catena

Regola della catena permette il calcolo di qualsiasi membro della distribuzione congiunta di un insieme di variabili casuali utilizzando solo le probabilità condizionate.

::: {.definition}
Dati due eventi $A$ e $B$, la regola della catena afferma che

$$
P(A \cap B) = P(A)P(B \mid A).
$$
::: 

Nel caso di 4 eventi, per esempio, la regola della catena diventa
$$
P(A_1, A_2, A_3, A_4) = P(A_1) P(A_2 \mid A_1) P(A_3 \mid A_1, A_2) P(A_4 \mid A_1, A_2, A_3).
$$


### Funzioni di probabilità marginali

La distribuzione marginale di un sottoinsieme di variabili casuali è la distribuzione di probabilità delle variabili contenute nel sottoinsieme. Come spiegato da [Wikipedia](https://it.wikipedia.org/wiki/Distribuzione_marginale):

> il termine variabile marginale è usato per riferirsi a quelle variabili nel sottoinsieme delle variabili che vengono trattenute ovvero utilizzate. Questo termine, marginale, è attribuito ai valori ottenuti ad esempio sommando in una tabella di valori lungo le righe oppure lungo le colonne, trascrivendo il risultato appunto a margine rispettivamente della riga o colonna sommata.[1] La distribuzione delle variabili marginali (la distribuzione marginale) è ottenuta mediante marginalizzazione sopra le variabili da "scartare", e le variabili scartate sono dette fuori marginalizzate.

Nel caso di due variabili casuali discrete $X$ e $Y$ di cui conosciamo la cui distribuzione congiunta, la distribuzione marginale di $X$ è calcolata sommando o integrando la distribuzione di probabilità congiunta sopra $Y$. La funzione di massa di probabilità marginale $P(X=x)$ è
\begin{equation}
P(X = x) = \sum_y P(X, Y = y) = \sum_y P(X \mid Y = y) P(Y = y),
\end{equation}
\noindent
dove $P(X = x,Y = y)$ è la distribuzione congiunta di $X, Y$, mentre $P(X = x \mid Y = y)$ è la distribuzione condizionata di $X$ dato $Y$. In questo caso, la variabile $Y$ è stata marginalizzata. Le probabilità bivariate marginali e congiunte per variabili casuali discrete sono spesso mostrate come tabelle di contingenza.

Si noti che $P(X = x)$ e $P(Y = y)$ sono normalizzate:
$$
\sum_x P(X=x) = 1.0, \quad \sum_y P(Y=y) = 1.0.
$$

::: {.example #flip3coins}
Per l'esperimento casuale consistente nel lancio di tre monete equilibrate, si calcolino le probabilità marginali di $X$ e $Y$.

Nell'ultima colonna a destra e nell'ultima riga in basso della tabella \@ref(tab:ditr-cong-biv) sono riportate le distribuzioni di probabilità marginali di $X$ e $Y$. $P_X$ si ottiene sommando su ciascuna riga fissata la colonna $j$, $P_X(X = j) = \sum_y p_{xy}(x = j, y)$. $P_Y$ si trova sommando su ciascuna colonna fissata la riga $i,$ $P_Y (Y = i) = \sum_x p_{xy}(x, y = i)$.

Table: (\#tab:ditr-cong-biv) Distribuzione di probabilità congiunta $p(x,y)$ per i risultati dell'esperimento consistente nel lancio di tre monete equilibrate e  probabilità marginali $P(x)$ e $P(y)$.

         $x / y$          0     1    $P(x)$
  --------------------- ----- ----- --------
            0            1/8    0     1/8
            1            2/8   1/8    3/8
            2            1/8   2/8    3/8
            3             0    1/8    1/8
         $P(y)$          4/8   4/8    1.0

:::


<!-- ## Marginalizzazione nel caso continuo -->

<!-- Analogamente per variabili casuali continue, la funzione di densità di probabilità marginale $p(X=x)$ è -->
<!-- \begin{equation} -->
<!-- p(x)=\int_{y}p(x,y)\,\operatorname {d}\!y = \int_{y} p(x \mid y) \, p(y) \, \operatorname {d}\!y, -->
<!-- \end{equation} -->
<!-- \noindent -->
<!-- dove $p(x,y)$ è la distribuzione congiunta di $X$ e $Y$, mentre $p(x \mid y)$ fornisce la distribuzione condizionata per $X$ dato $Y$. Di nuovo, la variabile $Y$ è stata marginalizzata. -->

<!-- Per fare un esempio, consideriamo l'influenza delle condizioni meteorologiche sul tono dell'umore (ovvero, probabilità di essere felici) in Italia. Questo si può scrivere come $Pr(\text{felicità} \mid \text{meteo})$, la probabilità di felicità dato il tipo di condizioni meteo. Le condizioni meteo sono diverse, in media, nel nord, centro e sud Italia. Quindi, quello che dobbiamo scrivere in realtà è $Pr(\text{felicità} \cap \text{area geografica} \mid \text{meteo})$, per semplicità, $Pr(\text{felicità}, \text{area geografica} \mid \text{meteo})$. Ovvero, dobbiamo tenere contemporaneamente in considerazione l'evento congiunto presenza/assenza di felicità e l'area geografica. Ciò corrisponde, per esempio, alla domanda: "qual è la probabilità che una persona sia felice nel centro Italia dato che c'è bel tempo?". -->
<!-- La marginalizzazione ci dice che possiamo calcolare la quantità di interesse se sommiamo su tutte le probabilità delle tre aree geografiche: -->
<!-- \begin{align} -->
<!-- Pr(\text{felicità} \mid \text{meteo}) &= Pr(\text{felicità}, \text{area geografica} = nord \mid \text{meteo})\notag\\ -->
<!-- &\quad+ Pr(\text{felicità}, \text{area geografica} = centro \mid \text{meteo})\notag\\ -->
<!-- &\quad+ Pr(\text{felicità}, \text{area geografica} = sud \mid \text{meteo}) -->
<!-- \end{align} -->
<!-- Una volta calcolata la quantità di interesse (che può essere un singolo valore o una distribuzione) possiamo procedere con l'inferenza. -->

<!-- Come indicato nel Paragrafo precedente, la marginalizzazione è un metodo che richiede di sommare tutti i possibili valori di una variabile casuale per determinare il contributo marginale di un'altra. Per una v.c. discreta abbiamo -->

<!-- \begin{equation} -->
<!-- Pr(X) = \sum_y Pr(X, Y = y),\notag -->
<!-- \end{equation} -->

<!-- \noindent -->
<!-- ovvero -->

<!-- \begin{equation} -->
<!-- P(X) = \sum_y P(X, Y = y) = \sum_y P(X \mid Y = y) P(Y = y). -->
<!-- \end{equation} -->

<!-- Nel caso continuo abbiamo -->

<!-- \begin{equation} -->
<!-- p(X) = \int_y p(X, Y = y) dy = \int_y p(X \mid Y = y) p(Y = y). -->
<!-- \end{equation} -->


<!-- ### Verosimiglianza marginalizzata -->

<!-- Nella statistica bayesiana, la marginalizzazione serve per calcolare la cosiddetta _verosimiglianza marginalizzata_. Sia $y = \{y_1, \dots, y_n\}$ un campione casuale e si assuma un modello statistico parametrizzato da $\theta$. Il teorema di Bayes è -->
<!-- $$ -->
<!-- p(\theta \mid y) = \frac{p(y \mid \theta) \, p(\theta)}{p(y)}, -->
<!-- $$ -->
<!-- \noindent -->
<!-- laddove la verosimiglianza marginalizzata $p(y)$  -->
<!-- $$ -->
<!-- p(y) = \int_\theta p(y \mid \theta)\, p(\theta) \,\operatorname {d}\!\theta, -->
<!-- $$ -->
<!-- \noindent -->
<!-- si ottiene integrando il numeratore bayesiano (ovvero, la distribuzione a posteriori non normalizzata) su $\theta$. -->


## Indipendenza stocastica

Ora abbiamo tutti gli strumenti per dare una precisa definizione
statistica al concetto di indipendenza. La definizione proposta
sarà necessariamente coerente con la definizione di indipendenza che abbiamo usato fino ad ora. Ma, espressa in questi nuovi termini, potrà essere utilizzata in indagini probabilistiche e statistiche più complesse. Ricordiamo che gli eventi $A$ e $B$ si dicono indipendenti se $P (A \cap B)\, = P(A) P(B)$. Diciamo quindi che $X$ e $Y$ sono indipendenti se qualsiasi evento definito da $X$ è indipendente da qualsiasi evento definito da $Y$. La definizione formale che garantisce che ciò accada è la seguente.

::: {.definition}
Le variabili aleatorie $X$ e $Y$ sono indipendenti se la loro distribuzione congiunta è il prodotto delle rispettive distribuzioni marginali:

\begin{equation}
P(X, Y)\, = P_X(x)P_Y(y).
\end{equation}
::: 

Nel caso discreto, dunque, l'indipendenza implica che la probabilità
riportata in ciascuna cella della tabella di probabilità congiunta deve
essere uguale al prodotto delle probabilità marginali di riga e di
colonna: 
$$
P(x_i, y_i)\, = P_X(x_i) P_Y(y_i).
$$

::: {.example}
Per la situazione rappresentata nella tabella \@ref(exm:flip3coins) le variabili casuali $X$ e $Y$ sono indipendenti?

Nella tabella le variabili casuali $X$ e $Y$ non sono indipendenti: le probabilità congiunte non sono ricavabili dal prodotto delle marginali. Per esempio, nessuna delle probabilità marginali è uguale a $0$ per cui nessuno dei valori dentro la tabella (probabilità congiunte) che risulta essere uguale a $0$ può essere il prodotto delle probabilità marginali.
:::


## Considerazioni conclusive {-}

La funzione di probabilità congiunta tiene simultaneamente conto del
comportamento di due variabili casuali $X$ e $Y$ e di come esse si
influenzano reciprocamente. In particolare, si osserva che se le due
variabili non si influenzano, cioè se sono statisticamente indipendenti,
allora la distribuzione di massa di probabilità congiunta si ottiene
come prodotto delle funzioni di probabilità marginali di $X$ e $Y$:
$P_{X, Y}(x, y) = P_X(x) P_Y(y)$.




