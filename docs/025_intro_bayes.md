# (PART\*) Inferenza statistica bayesiana {.unnumbered}

# I modelli bayesiani {#chapter-intro-bayes-inference}



I modelli bayesiani, computazionali o meno, hanno due caratteristiche distintive:

- Le quantità incognite sono descritte utilizzando le distribuzioni di probabilità. Queste quantità incognite sono chiatame parametri.
- Il teorema di Bayes viene utilizzato per aggiornare i valori dei parametri condizionati ai
dati. Possiamo anche concepire questo processo come una riallocazione delle probabilità.

::: {.remark}
Un modello è uno strumento concettuale che viene utilizzato per risolvere uno specifico problema. In quanto tale, è generalmente più conveniente parlare dell'adeguatezza del modello a un dato problema che di determinare la sua intrinseca correttezza. I modelli esistono esclusivamente come l'ausilio per il raggiungimento di un qualche ulteriore obiettivo. Il problema che i modelli bayesiani cercano di risolvere è quello dell'inferenza^[In termini colloquiali, l'inferenza può essere descritta come la capacità di giungere a conclusioni basate su evidenze e ragionamenti. L'inferenza bayesiana è una particolare forma di inferenza statistica basata sulla combinazione di distribuzioni di probabilità che ha il fine di ottenere altre distribuzioni di probabilità. Nello specifico, la regola di Bayes ci fornisce un metodo per giungere alla quantificazione della plausibilità di una teoria alla luce dei dati osservati.]. 
:::

Seguendo [@martin2022bayesian], possiamo descrivere il processo di costruzione della modellazione bayesiana distinguendo 3 passaggi.

1. Dati alcuni dati e alcune ipotesi su come questi dati potrebbero essere stati generati, progettiamo un modello combinando e trasformando variabili casuali.
2. Usiamo il teorema di Bayes per condizionare i nostri modelli ai dati disponibili. Chiamiamo questo processo "inferenza" e come risultato otteniamo una distribuzione a posteriori. Ci auguriamo che i dati riducano l'incertezza per i possibili valori dei parametri, sebbene questo non sia garantito per nessun modello bayesiano.
3. Critichiamo il modello verificando se il modello abbia senso utilizzando criteri diversi, inclusi i dati e la nostra conoscenza del dominio. Poiché generalmente siamo incerti sui modelli stessi, a volte confrontiamo diversi modelli.

Questi 3 passaggi vengono eseguiti in modo iterativo e danno luogo a quello che si chiama un "flusso di lavoro bayesiano" (_bayesian workflow_).

## Il problema inverso 

In questo capitolo ci focalizzeremo sul passaggio 2 descritto sopra. Nello specifico, descrivemo in dettaglio il significato dei tre i termini a destra del segno di uguale nella formula di Bayes: la distribuzione a priori e la funzione di verosimiglianza al numeratore, e la verosimiglianza marginale al denominatore.

::: {.remark}
La moderna statistica bayesiana viene per lo più eseguita utilizzando un linguaggio di programmazione probabilistico implementato su computer. Ciò ha cambiato radicalmente il modo in cui venivano eseguite le statistiche bayesiane anche fin pochi decenni fa. La complessità dei modelli che possiamo costruire è aumentata e la barriera delle competenze matematiche e computazionali che sono richieste è diminuita. Inoltre, il processo di modellazione iterativa è diventato, sotto molti aspetti, molto più facile da eseguire. Anche se formulare modelli statistici complessi è diventato più facile che mai, la statistica è un campo pieno di sottigliezze che non scompaiono magicamente utilizzando potenti metodi computazionali. Pertanto, avere una buona preparazione sugli aspetti teorici, specialmente quelli rilevanti nella pratica, è estremamente utile per applicare efficacemente i metodi statistici.
:::

## Inferenza bayesiana come un problema inverso

<!-- L'inferenza bayesiana può essere descritta come la soluziome di un problema inverso mediante la regola di Bayes, ovvero la quantificazione  -->

### Notazione

Per fissare la notazione, nel seguito $y$ rappresenterà i dati e $\theta$ rappresenterà i parametri incogniti di un modello statistico. Sia $y$ che $\theta$ saranno concepiti come delle variabili casuali.^[Nell'approccio bayesiano si fa riferimento ad un modello probabilistico $f(y \mid \theta)$ rappresentativo del fenomeno d'interesse noto a meno del valore assunto dal parametro (o dei parametri) che lo caratterizza. Si fa inoltre riferimento ad una distribuzione congiunta (di massa o di densità di probabilità) $f(y, \theta)$. Entrambi gli argomenti della funzione $y$ e $\theta$ hanno natura di variabili casuali, laddove la nostra incertezza relativa a $y$ è dovuta alla naturale variabilità del fenomeno indagato (_variabilità aleatoria_), mentre la nostra incertezza relativa a $\theta$ è dovuta alla mancata conoscenza del suo valore numerico (_variabilità epistemica_).] Con $x$ verranno invece denotate le quantità note, come ad esempio i predittori del modello lineare. Per rappresentare in un modo conciso i modelli probabilistici viene usata una notazione particolare. Ad esempio, invece di scrivere $p(\theta) = \mbox{Beta}(1, 1)$
scriviamo $\theta \sim \mbox{Beta}(1, 1)$. Il simbolo "$\sim$" viene spesso letto "è distribuito come". Possiamo anche pensare che significhi che $\theta$ costituisce un campione casuale estratto dalla distribuzione Beta(1, 1). Allo stesso modo, ad esempio, la verosimiglianza del modello binomiale può essere scritta come $y \sim \text{Bin}(n, \theta)$.

### Funzioni di probabilità

Una caratteristica attraente della statistica bayesiana è che la nostra credenza "a posteriori" viene sempre descritta mediante una distribuzione. Questo fatto ci consente di fare affermazioni probabilistiche sui parametri, come ad esempio: "la probabilità che un parametro sia positivo è 0.35"; oppure, "il valore più probabile di $\theta$ è 12 e abbiamo probabilità del 50% che $\theta$ sia compreso tra 10 e 15". Inoltre, possiamo pensare alla distribuzione a posteriori come alla logica conseguenza della combinazione di un modello con i dati; quindi, abbiamo la garanzia che le affermazioni probabilistiche associate alla distribuzione a posteriori siano matematicamente coerenti. Dobbiamo solo ricordare che tutte queste belle proprietà matematiche sono valide solo nel mondo platonico delle idee dove esistono oggetti matematici come sfere, distribuzioni gaussiane e catene di Markov. Quando passiamo dalla purezza della matematica al disordine della matematica applicata al mondo reale, dobbiamo sempre tenere a mente che i nostri risultati sono condizionati, non solo dai dati, ma anche dai modelli. Di conseguenza, dati errati e/o modelli errati conducono facilmente a conclusioni prive di senso, anche se matematicamente coerenti. È dunque necessario conservare sempre una sana quota di scetticismo relativamente ai nostri dati, modelli e risultati [@martin2022bayesian].

Avendo detto questo, nell'aggiornamento bayesiano (dai dati ai parametri) vengono utilizzate le seguenti distribuzioni di probabilità (o di massa di probabilità): 

- la *distribuzione a priori* $p(\theta)$ --- la credenza iniziale (prima di avere osservato i dati $Y = y$) riguardo a $\theta$;
- la *funzione di verosimiglianza* $p(y \mid \theta)$ --- quanto sono compatibili i dati osservati $Y = y$ con i diversi valori possibili di $\theta$? 
- la *verosimiglianza marginale* $p(y)$ --- costante di normalizzazione: qual è la probabilità complessiva di osservare i dati $Y = y$? In termini formali:
$$
p(y) = \int_\theta p(y, \theta) \,\operatorname {d}\!\theta = \int_\theta p(y \mid \theta) p(\theta) \,\operatorname {d}\!\theta.
$$
- la *distribuzione a posteriori* $p(\theta \mid y)$ --- la nuova credenza relativa alla credibilità di ciascun valore $\theta$ dopo avere osservato i dati $Y = y$.


## La regola di Bayes

Assumendo un modello statistico, la formula di Bayes consente di giungere alla distribuzione a posteriori $p(\theta \mid y)$ per il parametro di interesse $\theta$, come indicato dalla seguente catena di equazioni^[In realtà, avremmo dovuto scrivere $p(\theta \mid y, \mathcal{M})$, in quanto non condizioniamo la stima di $\theta$ solo rispetto ai dati $y$ ma anche ad un modello probabilistico $\mathcal{M}$ che viene assunto quale meccanismo generatore dei dati. Per semplicità di notazione, omettiamo il riferimento a $\mathcal{M}$.]:
\begin{align}
p(\theta \mid y)  &= \displaystyle \frac{p(\theta,y)}{p(y)}
 \ \ \ \ \ \mbox{ [definizione di probabilità condizionata]}
\\
&= \displaystyle \frac{p(y \mid \theta) \, p(\theta)}{p(y)}
 \ \ \ \ \ \mbox{ [legge della probabilità composta]}
\\
&=  \displaystyle \frac{p(y \mid\theta) \, p(\theta)}
                        {\int_{\Theta} p(y,\theta) \, \,\operatorname {d}\!\theta}
 \ \ \ \ \ \mbox{ [legge della probabilità totale]}
\\
&= \displaystyle \frac{p(y \mid\theta) \, p(\theta)}
                        {\int_{\Theta} p(y \mid\theta) \, p(\theta) \, \,\operatorname {d}\!\theta}
 \ \ \ \ \ \mbox{ [legge della probabilità composta]}
\\
& \propto \displaystyle p(y \mid\theta) \, p(\theta)
(\#eq:bayesmodel)
\end{align}

La regola di Bayes "inverte" la probabilità della distribuzione a posteriori $p(\theta \mid y)$, esprimendola nei termini della funzione di verosimiglianza $p(y \mid \theta)$ e della distribuzione a priori $p(\theta)$. L'ultimo passo è importante per la stima della distribuzione a posteriori mediante i metodi Monte Carlo a catena di Markov, in quanto per questi metodi richiedono soltanto che le funzioni di probabilità siano definite a meno di una costante di proporzionalità. In altri termini, per la maggior parte degli scopi dell'inferenza inversa, è sufficiente calcolare la densità a posteriori non normalizzata, ovvero è possibile ignorare il denominatore bayesiano $p(y)$. La distribuzione a posteriori non normalizzata, dunque, si riduce al prodotto della varosimiglianza e della distribuzione a priori.

Possiamo dire che la regola di Bayes viene usata per aggiornare le credenze a priori su $\theta$ (ovvero, la distribuzione a priori) in modo tale da produrre le nuove credenze a posteriori $p(\theta \mid y)$ che combinano le informazioni fornite dai dati $y$ con le credenze precedenti. La distribuzione a posteriori riflette dunque l'aggiornamento delle credenze del ricercatore alla luce dei dati. La distribuzione a posteriori $p(\theta \mid y)$ contiene tutta l'informazione riguardante il parametro $\theta$ e viene utilizzata per produrre indicatori sintetici, per la determinazione di stime puntuali o intervallari, e per la verifica d'ipotesi.

La \@ref(eq:bayesmodel) rende evidente che, in ottica bayesiana, la quantità di interesse $\theta$ non è fissata (come nell'impostazione frequentista), ma è una variabile casuale la cui distribuzione di probabilità è influenzata sia dalle informazioni a priori sia dai dati a disposizione. In altre parole, nell'approccio bayesiano non esiste un valore vero di $\theta$, ma invece lo scopo è quello di  fornire invece un giudizio di probabilità (o di formulare una "previsione", nel linguaggio di de Finetti). Prima delle osservazioni, sulla base delle nostre conoscenze assegnamo a $\theta$ una distribuzione a priori di probabilità. Dopo le osservazioni, correggiamo il nostro giudizio e assegniamo a $\theta$ una distribuzione a posteriori di probabilità. 

### Un esempio di aggiornamento bayesiano 

Per descrivere l'aggiornamento bayesiano, in questo Capitolo (così come nei successivi) considereremo i dati di @zetschefuture2019. Questi ricercatori si sono chiesti se gli individui depressi manifestino delle aspettative accurate circa il loro umore futuro, oppure se tali aspettative siano distorte negativamente. Esamineremo qui i 30 partecipanti dello studio di @zetschefuture2019 che hanno riportato la presenza di un episodio di depressione maggiore in atto. All'inizio della settimana di test, a questi pazienti è stato chiesto di valutare l'umore che si aspettavano di esperire nei giorni seguenti della settimana. Mediante una app, i partecipanti dovevano poi valutare il proprio umore in cinque momenti diversi di ciascuno dei cinque giorni successivi. Lo studio considera diverse emozioni, ma qui ci concentriamo solo sulla tristezza.

Sulla base dei dati forniti dagli autori, abbiamo calcolato la media dei giudizi relativi al livello di tristezza raccolti da ciascun partecipante tramite la app. Tale media è stata poi sottratta dall'aspettativa del livello di tristezza fornita all'inizio della settimana. La discrepanza tra aspettative e realtà è stata considerata come un evento dicotomico: valori positivi di tale differenza indicano che le aspettative circa il livello di tristezza erano maggiori del livello di tristezza effettivamente esperito --- ciò significa che le aspettative future risultano negativamente distorte (evento codificato con "1"). Viceversa, si ha che le aspettative risultano positivamente distorte se la differenza descritta in precedenza assume un valore negativo (evento codificato con "0"). 

Nel campione dei 30 partecipanti clinici di @zetschefuture2019, le aspettative future di 23 partecipanti risultano distorte negativamente e quelle di 7 partecipanti risultano distorte positivamente. Chiameremo $\theta$ la probabilità dell'evento "le aspettative del partecipante sono distorte negativamente". Ci poniamo il problema di ottenere una stima a posteriori di $\theta$ avendo osservato 23 "successi" in 30 prove.^[Si noti un punto importante: dire semplicemente che la stima di $\theta$ è uguale a 23/30 = 0.77 ci porta ad ignorare il livello di incertezza associato a tale stima. Infatti, lo stesso valore (0.77) si può ottenere come 23/30, o  230/300, o 2300/3000, o 23000/30000, ma l'incertezza di una stima pari a 0.77 è molto diversa nei quattro casi. Quando si traggono conclusioni dai dati è invece necessario quantificare il livello della nostra incertezza relativamente alla stima del parametro di interesse (nel caso presente, $\theta$). Lo strumento ci consente di quantificare tale incertezza è la distribizione a posteriori $p(\theta \mid y)$. Ovviamente, $p(\theta \mid y)$ assume forme molto diverse nei quattro casi descritti sopra.]

<!-- Per introdurre la procedura dell'aggiornamento bayesiano discuteremo un esempio riguardante la sfida tra Gary Kasparov e il supercomputer Deep Blue [@Johnson2022bayesrules]. Nel 1996 Kasparov giocò sei partite contro Deep Blue vincendone tre, perdendone una, con due patte, e vincendo così il match. Nel 1997 si svolse la rivincita, sempre al meglio di sei partite. Nella rivincita, Kasparov vinse una partita, perse due partite, con tre patte, perdendo dunque il match. Quello che vogliamo fare è descrivere la nostra credenza relativa all'abilità di Kasparov di battere Deep Blue, alla luce delle credenze iniziali che possiamo avere avuto e considerati i dati relativi alla sfida del 1997.  -->

## Modello probabilistico

Nel caso dello studio di @zetschefuture2019, i dati qui considerati possono essere considerati la manifestazione di una variabile casuale Bernoulliana -- 23 "successi" in 30 prove. Se i dati rappresentano una proporzione, allora possiamo adottare un modello probabilistico binomiale quale meccanismo generatore dei dati: 
\begin{equation}
y  \sim \mbox{Bin}(n, \theta),
(\#eq:binomialmodel)
\end{equation}
laddove $\theta$ è la probabiltà che una prova Bernoulliana assuma il valore 1 e $n$ corrisponde al numero di prove Bernoulliane. Questo modello assume che le prove Bernoulliane $y_i$ che costituiscono il campione $y$ siano tra loro indipendenti e che ciascuna abbia la stessa probabilità $\theta \in [0, 1]$ di essere un "successo" (valore 1). In altre parole, il modello generatore dei dati avrà una funzione di massa di probabilità 
$$
p(y \mid \theta)
\ = \
\mbox{Bin}(y \mid n, \theta).
$$

Nei capitoli precedenti è stato mostrato come, sulla base del modello binomiale, sia possibile assegnare una probabilità a ciascun possibile valore $y \in \{0, 1, \dots, n\}$ _assumendo noto il valore del parametro_ $\theta$. Ma ora abbiamo il problema inverso, ovvero quello di fare inferenza su $\theta$ alla luce dei dati campionari $y$. In altre parole, riteniamo di conoscere il modello probabilistico che ha generato i dati, ma di tale modello non conosciamo i parametri: vogliamo dunque ottenere informazioni su $\theta$ avendo osservato i dati $y$.

Nel modello probabilistico che stiamo esaminando, il termine $n$ viene trattato come una costante nota e $\theta$ come una *variabile casuale*. 
<!-- Il parametro $\theta$ del modello rappresenta la probabilità che ciascuna prova Bernoulliana sia un "successo".  -->
Dato che $\theta$ è incognito, ma abbiamo a disposione i dati $y$, svolgeremo l'inferenza su $\theta$ mediante la regola di Bayes per determinare la distribuzione a posteriori $p(\theta \mid y)$. 
<!-- Una volta ottenuta la distribuzione a posteriori possiamo riassumerla, ad esempio, riportando l'intervallo centrale al 95% della distribuzione di densità, ovvero $\mbox{Pr}(0.025 \leq \theta \leq 0.975 \mid Y = y)$. Se vogliamo sapere, per esempio, se la probabilità di $y_i=1$ sia maggiore di 0.5, possiamo calcolare la probabilità dell'evento $\mbox{Pr}(\theta > 0.5 \mid Y = y)$. -->

::: {.remark}
Si noti che il modello probabilistico \@ref(eq:binomialmodel) non spiega perché, in ciascuna realizzazione, $Y$ assuma un particolare valore. Questo modello deve piuttosto essere inteso come un costrutto matematico che ha lo scopo di riflettere alcune proprietà del processo corrispondente ad una sequenza di prove Bernoulliane. Una parte del lavoro della ricerca in tutte le scienze consiste nel verificare le assunzioni dei modelli e, se necessario, nel migliorare i modelli dei fenomeni considerati. Un modello viene giudicato in relazione al suo obiettivo. Se l'obiettivo del modello molto semplice che stiamo discutendo è quello di prevedere la proporzione di casi nei quali $y_i = 1$, $i = 1, \dots, n$, allora un modello con un solo parametro come quello che abbiamo introdotto sopra può essere sufficiente. Ma l'evento $y_i=1$ (supponiamo: superare l'esame di Psicometria, oppure risultare positivi al COVID-19) dipende da molti fattori e se vogliamo rendere conto di una tale complessità, un modello come quello che stiamo discutendo qui certamente non sarà sufficiente. In altre parole, modelli sempre migliori vengono proposti, laddove ogni successivo modello è migliore di quello precedente in quanto ne migliora le capacità di previsione, è più generale, o è più elegante. Per concludere, un modello è un costrutto matematico il cui scopo è quello di rappresentare un qualche aspetto della realtà. Il valore di un tale strumento dipende dalla sua capacità di ottenere lo scopo per cui è stato costruito.
:::

## Distribuzioni a priori

Quando adottiamo un approccio bayesiano, i parametri della distribuzione di riferimento non venono considerati come delle costanti incognite ma bensì vengono trattati come variabili casuali e, di conseguenza, i parametri assumono una particolare distribuzione che nelle statistica bayesiana viene definita come "a priori". I parametri (o il parametro), che possiamo indicare con $\theta$, possono assumere delle distribuzioni a priori differenti; a seconda delle informazioni disponibili bisogna cercare di assegnare una distribuzione di $\theta$ in modo tale che venga assegnata una probabilità maggiore a quei valori che si ritengono più plausibili per $\theta$.

La distribuzione a priori sui valori dei parametri $p(\theta)$ è parte integrante del modello statistico. Ciò implica che due modelli bayesiani possono condividere la stessa funzione di verosimiglianza, ma tuttavia devono essere considerati come modelli diversi se specificano diverse distribuzioni a priori. Ciò significa che, quando diciamo "Modello binomiale", intendiamo in realtà un'intera classe di modelli, ovvero tutti i possibili modelli che hanno la stessa verosimiglianza ma diverse distribuzioni a priori su $\theta$.

Nell'analisi dei dati bayesiana, la distribuzione a priori $p(\theta)$ codifica le credenze del ricercatore a proposito dei valori dei parametri, prima di avere osservato i dati. Idealmente, le credenze a priori che supportano la specificazione di una distribuzione a priori dovrebbero essere supportate da una qualche motivazione, come ad esempio i risultati di ricerche precedenti, o altre motivazioni giustificabili. 

Quando una nuova osservazione (p. es., vedo un cigno bianco) corrisponde alle mie credenze precedenti (p. es., la maggior parte dei cigni sono bianchi) la nuova osservazione rafforza le mie credenze precedenti: più nuove osservazioni raccolgo (p. es., più cigni bianchi vedo), più forti diventano le mie credenze precedenti. Tuttavia, quando una nuova osservazione (p. es., vedo un cigno nero) non corrisponde alle mie credenze precedenti, ciò contribuisce a diminuire la certezza che attribuisco alle mie credenze: tanto maggiori diventano le osservazioni non corrispondenti alle mie credenze (p. es., più cigni neri vedo ), tanto più si indeboliscono le mie credenze. Fondamentalmente, tanto più forti sono le mie credenze precedenti, di tante più osservazioni incompatibili (ad esempio, cigni neri) ho bisogno per cambiare idea.

Pertanto, da una prospettiva bayesiana, l'incertezza intorno ai parametri di un modello *dopo* aver visto i dati (ovvero le distribuzioni a posteriori) deve includere anche le credenze precedenti. Se questo modo di ragionare vi sembra molto intuitivo, non è una coincidenza: vi sono infatti diverse teorie psicologiche che prendono l'aggiornamento bayesiano come modello di funzionamento di diversi processi cognitivi.

### Tipologie di distribuzioni a priori

Possiamo distinguere tra diverse distribuzioni a priori in base a quanto fortemente impegnano il ricercatore a ritenere come plausibile un particolare intervallo di valori dei parametri. Il caso più estremo è quello che rivela una totale assenza di conoscenze a priori, il che conduce alle *distribuzioni a priori non informative*, ovvero quelle che assegnano lo stesso livello di credibilità a tutti i valori dei parametri. Le distribuzioni a priori informative, d'altra parte, possono essere *debolmente informative* o *fortemente informative*, a seconda della forza della credenza che esprimono. Il caso più estremo di credenza a priori è quello che riassume il punto di vista del ricercatore nei termini di un  *unico valore* del parametro, il che assegna tutta la probabilità (massa o densità) su di un singolo valore di un parametro. Poiché questa non è più una distribuzione di probabilità, sebbene ne soddisfi la definizione, in questo caso si parla di una *distribuzione a priori degenerata*.

La figura seguente mostra esempi di distribuzioni a priori non informative, debolmente o fortemente informative, così come una distribuzione a priori espressa nei termini di un valore puntuale per il modello Binomiale. Le distribuzione a priori illustrate di seguito  sono le seguenti:

- *non informativa* : $\theta_c \sim \mbox{Beta}(1,1)$;
- *debolmente informativa* : $\theta_c \sim \mbox{Beta}(5,2)$;
- *fortemente informativa* : $\theta_c \sim \mbox{Beta}(50,20)$;
- *valore puntuale* : $\theta_c \sim \mbox{Beta}(\alpha, \beta)$ con $\alpha, \beta \rightarrow \infty$ e $\frac{\alpha}{\beta} = \frac{5}{2}$.

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{025_intro_bayes_files/figure-latex/ch-03-02-models-types-of-priors-1} 

}

\caption{Esempi di distribuzioni a priori per il parametro $\theta_c$ nel Modello Binomiale.}(\#fig:ch-03-02-models-types-of-priors)
\end{figure}

### Selezione della distribuzione a priori

La selezione delle distribuzioni a priori è stata spesso vista come una delle scelte più importanti che un ricercatore fa quando implementa un modello bayesiano in quanto può avere un impatto sostanziale sui risultati finali.  La soggettività delle distribuzioni a priori è evidenziata dai critici come un potenziale svantaggio dei metodi bayesiani. A questa critica, @vandeSchoot2021modelling rispondono dicendo che, al di là della scelta delle distribuzioni a priori, ci sono molti elementi del processo di inferenza statistica che sono soggettivi, ovvero la scelta del modello statistico e le ipotesi sulla distribuzione degli errori. In secondo luogo, @vandeSchoot2021modelling notano come le distribuzioni a priori svolgono due importanti ruoli statistici: quello della "regolarizzazione della stima", ovvero, il processo che porta ad indebolire l'influenza indebita di osservazioni estreme, e quello del miglioramento dell'efficienza della stima, ovvero, la facilitazione dei processi di calcolo numerico di stima della distribuzione a posteriori. L'effetto della distribuzione a priori sulla distribuzione a posteriori verrà discusso nel Capitolo \@ref(chapter-balance).

### La distribuzione a priori per i dati di @zetschefuture2019

In un problema concreto di analisi dei dati, la scelta della distribuzione a priori dipende dalle credenze a priori che vogliamo includere nell'analisi dei dati. Se non abbiamo alcuna informazione a priori, potremmo pensare di usare una distribuzione a priori uniforme, ovvero una Beta di parametri $\alpha=1$ e $\beta=1$. Questa, tuttavia, è una cattiva idea perché il risultato ottenuto non è invariante a seconda della trasformazione della scala dei dati (ad esempio, se esprimiamo l'altezza in cm piuttosto che in m). Il problema della _riparametrizzazione_ verrà discusso nel Capitolo ?? **TODO**. È invece raccomandato usare una distribuzione a priori poco informativa, come ad esempio $\mbox{Beta}(2, 2)$.

Nella presente discussione, per fare un esempio, quale distribuzione a priori useremo una $\mbox{Beta}(2, 10)$, ovvero:
$$
p(\theta) = \frac{\Gamma(12)}{\Gamma(2)\Gamma(10)}\theta^{2-1} (1-\theta)^{10-1}.
$$


```r
bayesrules::plot_beta(alpha = 2, beta = 10, mean = TRUE, mode = TRUE)
```



\begin{center}\includegraphics[width=0.8\linewidth]{025_intro_bayes_files/figure-latex/unnamed-chunk-1-1} \end{center}

\noindent
La $\mbox{Beta}(2, 10)$ esprime la credenza che $\theta$ assume valori $< 0.5$, con il valore più plausibile pari a circa 0.1. Questo è assolutamente implausibile, nel caso dell'esempio in discussione. Adotteremo una tale distribuzione a priori solo per scopi didattici, per esplorare le conseguenze di tale scelta (molto più sensato sarebbe stato usare $\mbox{Beta}(2, 2)$).

<!-- Per scopi didattici, @Johnson2022bayesrules ipotizzano che le credenze a priori relative a $\pi$ (la probabilità Kasparov che batta Deep Blue) siano le seguenti:  -->

<!-- | $\theta$  |  0.2 |  0.5 |  0.8 | Totale | -->
<!-- |:---------:|:----:|:----:|:----:|:------:| -->
<!-- |$P(\theta)$| 0.10 | 0.65 | 0.15 |  1.0   | -->

<!-- Anche se $\theta \in [0, 1]$ è una variabile continua, per semplificare la discussione, @Johnson2022bayesrules considerano solo tre possibili valori di $\theta \in \{0.2, 0.5, 0.8\}$ e assegnano a tali valori possibili le probabilità indicate sopra. Questa tabella descrive le credenze iniziali relative alla capacità di Kasparov di battere Deep Blue; indica che le credenze iniziali pongono la massa maggiore della nostra credenza sull'evento $\theta = 0.5$ --- in altre parole, più che ogni altra possibilità, a priori crediamo che Kasparov abbia solo il 50% di possibilità di battere Deep Blue. -->

## Verosimiglianza

Oltre alla distribuzione a priori di $\theta$, nel numeratore della regola di Bayes troviamo la funzione di verosimigliana. Iniziamo dunque con una definizione.

::: {.definition}
La *funzione di verosimiglianza* $\mathcal{L}(\theta \mid y) = f(y \mid \theta), \theta \in \Theta,$ è la funzione di massa o di densità di probabilità dei dati $y$ vista come una funzione del parametro sconosciuto (o dei parametri sconosciuti) $\theta$.
:::

Detto in altre parole, le funzioni di verosimiglianza e di (massa o densità di) probabilità sono formalmente identiche, ma è completamente diversa la loro interpretazione. Nel caso della funzione di massa o di densità di probabilità la distribuzione del vettore casuale delle osservazioni campionarie $y$ dipende dai valori assunti dal parametro (o dai parametri) $\theta$; nel caso della la funzione di verosimiglianza la credibilità assegnata a ciascun possibile valore $\theta$ viene determinata avendo acquisita l'informazione campionaria $y$ che rappresenta l'elemento condizionante. In altri termini, la funzione di verosimiglianza è lo strumento che consente di rispondere alla seguente domanda: avendo osservato i dati $y$, quanto risultano (relativamente) credibili i diversi valori del parametro $\theta$? 

Spesso per indicare la verosimiglianza si scrive $\mathcal{L}(\theta)$ se è chiaro a quali valori $y$ ci si riferisce. La verosimiglianza $\mathcal{L}$ è una curva (in generale, una superficie) nello spazio $\Theta$ del parametro (in generale, dei parametri $\boldsymbol\theta$) che riflette la credibilità relativa dei valori $\theta$ alla luce dei dati osservati. Notiamo un punto importante: la funzione $\mathcal{L}(\theta \mid y)$ non è una funzione di densità. Infatti, essa non racchiude un'area unitaria.

In conclusione, la funzione di verosimiglianza descrive in termini relativi il sostegno empirico che $\theta \in \Theta$ riceve da $y$. Infatti, la funzione di verosimiglianza assume forme diverse al variare di $y$ (lasciamo come esercizio da svolgere la verifica di questa affermazione).


### La log-verosimiglianza

Dal punto di vista pratico risulta più conveniente utilizzare, al posto della funzione di verosimiglianza, il suo logaritmo naturale, ovvero la funzione di log-verosimiglianza:
\begin{equation}
\ell(\theta) = \log \mathcal{L}(\theta).
\end{equation}
Poiché il logaritmo è una funzione strettamente crescente (usualmente si considera il logaritmo naturale), allora $\mathcal{L}(\theta)$ e $\ell(\theta)$ assumono il massimo (o i punti di massimo) in corrispondenza degli stessi valori di $\theta$:
$$
\hat{\theta} = \text{argmax}_{\theta \in \Theta} \ell(\theta).
$$ 
Per le proprietà del logaritmo, si ha
\begin{equation}
\ell(\theta) = \log \left( \prod_{i = 1}^n f(y \mid \theta) \right) = \sum_{i = 1}^n \log f(y \mid \theta).
\end{equation}

::: {.remark}
Si noti che non è necessario lavorare con i logaritmi, anche se è fortemente consigliato, e questo perché i valori della verosimiglianza, in cui si moltiplicano valori di probabilità molto piccoli, possono diventare estremamente piccoli (qualcosa come $10^{-34}$). In tali circostanze, non è sorprendente che i programmi dei computer mostrino problemi di arrotondamento numerico. Le trasformazioni logaritmiche risolvono questo problema.
:::

::: {.exercise}
Si trovi e si interpreti la funzione di verosimiglianza per i dati di @zetschefuture2019: 23 "successi" in 30 prove.
:::

Per i dati di @zetschefuture2019 la funzione di verosimiglianza corrisponde alla funzione binomiale di parametro $\theta \in [0, 1]$ sconosciuto. Abbiamo osservato un "successo" 23 volte in 30 "prove", dunque, $y = 23$ e $n = 30$. La funzione di verosimiglianza diventa
\begin{equation}
\mathcal{L}(\theta \mid y) = \frac{(23 + 7)!}{23!7!} \theta^{23} + (1-\theta)^7.
(\#eq:likebino23)
\end{equation}
Per costruire la funzione di verosimiglianza dobbiamo applicare la \@ref(eq:likebino23) tante volte, cambiando ogni volta il valore $\theta$ ma *tenendo sempre costante il valore dei dati*. Per esempio, se poniamo $\theta = 0.1$ 
$$
\mathcal{L}(\theta \mid y) = \frac{(23 + 7)!}{23!7!} 0.1^{23} + (1-0.1)^7
$$ 
\noindent
otteniamo

```r
dbinom(23, 30, 0.1)
#> [1] 9.74e-18
```
\noindent
Se poniamo $\theta = 0.2$
$$
\mathcal{L}(\theta \mid y) = \frac{(23 + 7)!}{23!7!} 0.2^{23} + (1-0.2)^7
$$ 
\noindent
otteniamo

```r
dbinom(23, 30, 0.2)
#> [1] 3.58e-11
```
\noindent
e così via. La figura \@ref(fig:likefutexpect) --- costruita utilizzando 100 valori equispaziati $\theta \in [0, 1]$ --- fornisce una rappresentazione grafica della funzione di verosimiglianza.


```r
n <- 30
y <- 23
theta <- seq(0, 1, length.out = 100)
like <- choose(n, y) * theta^y * (1 - theta)^(n - y)
tibble(theta, like) %>% 
  ggplot(aes(x = theta, y = like)) +
  geom_line() +
  labs(
    y = expression(L(theta)),
    x = expression('Valori possibili di' ~ theta)
  )
```

\begin{figure}[h]

{\centering \includegraphics[width=0.8\linewidth]{025_intro_bayes_files/figure-latex/likefutexpect-1} 

}

\caption{Funzione di verosimiglianza nel caso di 23 successi in 30 prove.}(\#fig:likefutexpect)
\end{figure}

Come possiamo interpretare la curva che abbiamo ottenuto? Per alcuni valori $\theta$ la funzione di verosimiglianza assume valori piccoli; per altri valori $\theta$ la funzione di verosimiglianza assume valori più grandi. Questi ultimi sono i valori di $\theta$ "più credibili" e il valore 23/30 è il valore più credibile di tutti. La funzione di verosimiglianza di $\theta$ valuta la compatibilità dei dati osservati $Y = y$ con i diversi possibili valori $\theta$. In termini più formali possiamo dire che la funzione di verosimiglianza ha la seguente interpretazione: sulla base dei dati, $\theta_1 \in \Theta$ è più credibile di $\theta_2 \in \Theta$ come indice del modello probabilistico generatore delle osservazioni se $\mathcal{L}(\theta_1) > \mathcal{L}(\theta_1)$.


### La stima di massima verosimiglinza

La funzione di verosimiglianza rappresenta la "credibilità relativa" dei  valori del parametro di interesse. Ma qual è il valore più credibile? Se utilizziamo soltanto la funzione di verosimiglianza, allora la risposta è data dalla stima di massima verosimiglinza.

::: {.definition}
Un valore di $\theta$ che massimizza $\mathcal{L}(\theta \mid y)$ sullo spazio parametrico $\Theta$ è detto _stima di massima verosimiglinza_ (s.m.v.) di $\theta$ ed è indicato con $\hat{\theta}$: 
\begin{equation}
\hat{\theta} = \text{argmax}_{\theta \in \Theta} \mathcal{L}(\theta).
\end{equation}
:::

Il paradigma frequentista utilizza la funzione di verosimiglianza quale unico strumento per giungere alla stima del valore più credibile del parametro sconosciuto $\theta$. Tale stima corrisponde al punto di massimo della funzione di verosimiglianza. 
<!-- Il massimo della funzione di verosimiglianza, ovvero  $\hat{\theta}$, si può ottenere con metodi numerici o grafici. -->
<!-- Nell'esempio presente, $\hat{\theta} = 0.6667$.  -->
In base all'approccio bayesiano, invece, il valore più credibile del parametro sconosciuto $\theta$, anziché alla s.m.v., corrisponde invece alla moda (o media, o mediana) della distribuzione a posteriori $p(\theta \mid y)$ che si ottiene combinando la verosimiglianza $p(y \mid \theta)$ con la distribuzione a priori  $p(\theta)$.
Per un approfondimento della stima di massima verosimiglianza si veda l'Appendice \@ref(appendix:max-like).

## La verosimiglianza marginale {#sec:const-normaliz-bino23}

Per il calcolo di $p(\theta \mid y)$ è necessario dividere il prodotto tra la distribuzione a priori e la verosimiglianza per una costante di normalizzazione. Tale costante di normalizzazione, detta _verosimiglianza marginale_, ha lo scopo di fare in modo che $p(\theta \mid y)$ abbia area unitaria. 

Si noti che il denominatore della regola di Bayes (ovvero la verosimiglianza marginale) è sempre espresso nei termini di un integrale. Tranne in pochi casi particolari, tale integrale non ha una soluzione analitica. Per questa ragione, l'inferenza bayesiana procede calcolando una approssimazione della distribuzione a posteriori mediante metodi numerici. 

::: {.exercise}
Si trovi la verosimiglianza maginale per i dati di @zetschefuture2019.

Supponiamo che nel numeratore bayesiano la verosimiglianza sia moltiplicata per una distribuzione uniforme, $\mbox{Beta}(1, 1)$. In questo caso, il prodotto si riduce alla funzione di verosimiglianza. In riferimento ai dati di @zetschefuture2019, la costante di normalizzazione per si ottiene semplicemente marginalizzando la funzione di verosimiglianza $p(y = 23, n = 30 \mid \theta)$ sopra $\theta$, ovvero risolvendo l'integrale:
\begin{equation}
p(y = 23, n = 30) = \int_0^1 \binom{30}{23} \theta^{23} (1-\theta)^{7} \,\operatorname {d}\!\theta.
(\#eq:intlikebino23)
\end{equation}
\noindent
Una soluzione numerica si trova facilmente usando $\R$:


```r
like_bin <- function(theta) {
  choose(30, 23) * theta^23 * (1 - theta)^7
}
integrate(like_bin, lower = 0, upper = 1)$value
#> [1] 0.0323
```

\noindent
La derivazione analitica della costante di normalizzazione qui discussa è fornita nell'Appendice \@ref(appendix:const-norm-bino23).
:::


## Distribuzione a posteriori

La distribuzione a postreriori si trova applicando il teorema di Bayes:
$$
\text{probabilità a posteriori} = \frac{\text{probabilità a priori} \cdot \text{verosimiglianza}}{\text{costante di normalizzazione}}
$$
Ci sono due metodi principali per calcolare la distribuzione a posteriori $p(\theta \mid y)$:

- una precisa derivazione matematica formulata nei termini della distribuzione a priori coniugata alla distribuzione a posteriori (si veda il Capitolo \@ref(chapter-distr-coniugate)); tale procedura però ha un'applicabilità molto limitata;

- un metodo approssimato, molto facile da utilizzare in pratica, che dipende da metodi Monte Carlo basati su Catena di Markov (MCMC); questo problema verrà discusso nel Capitolo ?? 

## Considerazioni conclusive {-}

Questo Capitolo ha brevemente passato in rassegna alcuni concetti di base dell'inferenza statistica bayesiana. In base all'approccio bayesiano, invece di dire che il parametro di interesse di un modello statistico ha un valore vero ma sconosciuto, diciamo che, prima di eseguire l'esperimento, è possibile assegnare una distribuzione di probabilità, che chiamano stato di credenza, a quello che è il vero valore del parametro. Questa distribuzione a priori può essere nota (per esempio, sappiamo che la distribuzione dei punteggi del QI è normale con media 100 e deviazione standard 15) o può essere  del tutto arbitraria. L'inferenza bayesiana procede poi nel modo seguente: si raccolgono alcuni dati e si calcola la probabilità dei possibili valori del parametro alla luce dei dati osservati e delle credenze a priori. Questa nuova distribuzione di probabilità è chiamata "distribuzione a posteriori" e riassume l'incertezza dell'inferenza. I concetti importanti che abbiamo appreso in questo Capitolo sono quelli di distribuzione a priori, verosimiglianza, verosimiglianza marginale e distribuzione a posteriori. Questi sono i concetti fondamentali della statistica bayesiana.




