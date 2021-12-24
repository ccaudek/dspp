# Cenni di calcolo combinatorio {#derivazione-coef-binom}

La derivazione del coefficiente binomiale richiede l'uso di alcune nozioni di calcolo combinatorio. Iniziamo con il definire il concetto di permutazione. 


## Permutazioni semplici

Una *permutazione semplice* di un insieme di oggetti è un allineamento di $n$ oggetti su $n$ posti nel quale ogni oggetto viene presentato una ed una sola volta. Le permutazioni semplici si indicano con il simbolo $P_{n}$. 

Il numero delle permutazioni semplici di $n$ elementi distinti è uguale a
\begin{equation}
P_n = n!
(\#eq:permsem)
\end{equation}

Per esempio, nel caso dell'insieme $A = \{a, b, c\}$, le permutazioni possibili sono:
\begin{center}
$\{a, b, c\}$, $\{a, c, b\}$, $\{b, c, a\}$, $\{b, a, c\}$, $\{c, a, b\}$, $\{c, b, a\}$,
\end{center}
Il numero di permutazioni di $A$ è
\[
P_n = P_3 = 3! = 3 \cdot 2 \cdot 1 = 6.
\]


## Disposizioni semplici

Supponiamo ora di voler selezionare una sequenza di $k$ oggetti da un insieme di $n$ e che l'ordine degli oggetti abbia importanza. Si chiamano *disposizioni semplici* di $n$ elementi distinti presi a $k$ a $k$  (o disposizioni della classe $k$) tutti i raggruppamenti che si possono formare con gli oggetti dati in modo che qualsiasi raggruppamento ne contenga $k$ tutti distinti tra loro (ovvero, senza ripetizione) e che due raggruppamenti differiscano tra loro per qualche oggetto oppure per l'ordine secondo il quale gli oggetti si susseguono. Le disposizioni semplici della classe $k$ si indicano con  $D_{n,k}$.  

Il numero delle disposizioni semplici di $n$ elementi distinti della classe
$k$ è uguale a
\begin{equation}
D_{n,k} = \frac{n!}{(n-k)!}.
(\#eq:dispsemp)
\end{equation}

Per esempio, nel caso dell'insieme: $A = \{a, b, c\}$, le disposizioni semplici di classe 2 sono:
\begin{center}
$\{a, b\}$, $\{b, a\}$, $\{a, c\}$, $\{c, a\}$, $\{b, c\}$, $\{c, b\}$
\end{center}
Il numero di disposizioni semplici di classe 2 è 
\[
D_{n,k} = \frac{n!}{(n-k)!} = 3 \cdot 2 = 6.
\]


## Combinazioni semplici

Avendo trovato il modo per contare il numero delle disposizioni semplici di $n$ elementi distinti della classe $k$, dobbiamo ora trasformare la \@ref(eq:dispsemp) in modo da ignorare l'ordine degli elementi di ciascun sottoinsieme. Le *combinazioni semplici* di $n$ elementi a $k$ a $k$ ($k \leq n$) sono tutti i sottoinsiemi di $k$ elementi di un dato insieme di $n$ elementi, tutti distinti tra loro. Le combinazioni semplici differiscono dalle disposizioni semplici per il fatto che le disposizioni semplici tengono conto dell'ordine di estrazione mentre nelle combinazioni semplici si considerano distinti solo i raggruppamenti che differiscono almeno per un elemento. 

Gli elementi di ciascuna combinazione di $k$ oggetti possono essere ordinati tra loro in $k!$ modi diversi, per cui il numero delle combinazioni semplici è dato dal numero di disposizioni semplici $D_{n,k}$ diviso per il numero di permutazioni semplici $P_k$ dei $k$ elementi.  Il numero delle combinazioni semplici di $n$ elementi distinti della classe $k$ è dunque uguale a
\begin{equation}
C_{n,k} = \frac{D_{n,k}}{P_k} = \frac{n!}{k!(n-k)!}.
\label{eq:combsemp}
\end{equation}

Il numero delle combinazioni semplici $C_{n,k}$ è spesso detto coefficiente binomiale e indicato con il simbolo $\binom{n}{k}$ che si legge "$n$ su $k$". 

Per l'insieme $A = \{a, b, c\}$,  le combinazioni semplici di classe 2 sono 

\begin{center}
$\{a, b\}$, $\{a, c\}$, $\{b, c\}$,
\end{center}

Il numero di combinazioni semplici di classe 2 è dunque uguale a tre:
\[
C_{n,k} = \binom{n}{k} = \binom{3}{2} = 3.
\]








