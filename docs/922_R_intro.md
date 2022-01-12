# Introduzione al linguaggio R  



In questa sezione della dispensa saranno presentate le caratteristiche di base e la filosofia dell'ambiente `R`, passando poi a illustrare le strutture dati e le principali strutture di controllo. Verranno introdotte alcune funzioni utili per la gestione dei dati e verranno forniti i rudimenti per realizzare semplici funzioni. Verranno introdotti i tipi di file editabili in RStudio (script, markdown, ...). Nello specifico, dopo aver accennato alcune caratteristiche del sistema `tidyverse`, verranno illustrate le principali funzionalità dell'IDE RStudio e dei pacchetti `dplyr` e `ggplot2`. Sul web sono disponibili tantissime introduzioni all'uso di `R` come, ad esempio, [Hands-On Programming with R](https://rstudio-education.github.io/hopr/), [R for Data Science](https://r4ds.had.co.nz), [Data Science for Psychologists](https://bookdown.org/hneth/ds4psy/), e [Introduction to Data Science](https://bookdown.org/hneth/i2ds/).

## Prerequisiti 

Al fine di utilizzare `R` è necessario eseguire le seguenti tre operazioni
nell'ordine dato:

1.  Installare `R`;
2.  Installare RStudio;
3.  Installare R-Packages (se necessario).

Di seguito viene descritto come installare `R` e RStudio.

### Installare R e RStudio

$\R$ è disponibile gratuitamente ed è scaricabile dal sito
<http://www.rproject.org/>. Dalla pagina principale del sito
`r-project.org` andiamo sulla sezione `Download` e scegliamo un server a
piacimento per scaricare il software d'installazione. Una volta
scaricato l'installer, lo installiamo come un qualsiasi software,
cliccando due volte sul file d'istallazione. Esistono versioni di $\R$ per
tutti i più diffusi sistemi operativi (Windows, Mac OS X e Linux).

Il R Core Development Team lavora continuamente per migliorare le
prestazioni di $\R$, per correggere errori e per consentire l'uso di con
nuove tecnologie. Di conseguenza, periodicamente vengono rilasciate
nuove versioni di $\R$. Informazioni a questo proposito sono fornite sulla
pagina web <https://www.r-project.org/>. Per installare una nuova
versione di $\R$ si segue la stessa procedura che è stata seguita per la
prima installazione. 

Insieme al software si possono scaricare dal sito principale sia manuali d'uso che numerose dispense per approfondire diversi aspetti di $\R$. In particolare, nel sito  <http://cran.r-project.org/other-docs.html> si possono trovare anche  numerose dispense in italiano (sezione "Other languages").

Dopo avere installato $\R$ è opportuno installare anche RStudio. RStudio si
può scaricare da <https://www.rstudio.com/>. Anche RStudio è disponibile
per tutti i più diffusi sistemi operativi.

### Utilizzare RStudio per semplificare il lavoro

Possiamo pensare ad $\R$ come al motore di un automobile e a RStudio come
al cruscotto di un automobile. Più precisamente, $\R$ è un linguaggio di
programmazione che esegue calcoli mentre RStudio è un ambiente di
sviluppo integrato (IDE) che fornisce un'interfaccia grafica aggiungendo
una serie di strumenti che facilitano la fase di sviluppo e di
esecuzione del codice. Utilizzeremo dunque $\R$ mediante RStudio. In altre
parole, 

__non aprite__

![](images/Rlogo.png){width=15%} 

__aprite invece__

![](images/RStudio-Logo-Blue-Gradient.png){width=30%}

L'ambiente di lavoro di RStudio è costituito da quattro finestre: la finestra del codice (scrivere-eseguire script), la finestra della console (riga di comando -
output), la finestra degli oggetti (elenco oggetti-cronologia dei
comandi) e la finestra dei pacchetti-dei grafici-dell'aiuto in linea.

![La console di RStudio.](images/rstudio_pics.png){#fig:rstudio_pics width=100%}

### Eseguire il codice

Mediante il menu a tendina di RStudio, scegliendo il percorso

````
File > New File > R Notebook
````
oppure
````
File > New File > R Script
````
l'utente può aprire nella finestra del codice (in alto a destra) un $\R$ Notebook o un $\R$ script dove inserire le istruzioni da eseguire.

In un $\R$ script, un blocco di codice viene eseguito selezionando un
insieme di righe di istruzioni e digitando la sequenza di tasti
`Command` + `Invio` sul Mac, oppure `Control` + `Invio` su Windows. In
un R Notebook, un blocco di codice viene eseguito schiacciando il
bottone con l'icona $\color{red}\blacktriangleright$ ("Run current
chunk") posizionata a destra rispetto al codice.

## Installare `cmdstan`

È possibile installare `cmdstan` in almento tre modi. Per informazioni dettagliate, si vedano le istruzioni [CmdStan Installation](https://mc-stan.org/docs/2_28/cmdstan-guide/cmdstan-installation.html).

Prima di installare `cmdstan`, tre raccomandazioni generali:

- usare la versione più recente del sistema operativo;
- usare la versione più recente di RStudio;
- usare la versione più recente di $\R$.

Se i tre vincoli precedenti sono soddisfatti, l'installazione di `cmdstan` dovrebbe procedere senza intoppi. Altrimenti si possono creare dei problemi di non facile soluzione.

Il modo più semplice per installare `cmdstan` è quello di installare prima [cmdstanr](https://mc-stan.org/cmdstanr/) per poi utilizzare le funzionalità di quel pacchetto per l'installazione di `cmdstan`.

Un secondo metodo (che è quello che io uso normalmente) è quello di installare dal sorgente, seguendo le istruzioni riportante su [CmdStan Installation](https://mc-stan.org/docs/2_28/cmdstan-guide/cmdstan-installation.html).

Un terzo metodo (che richiede una minima comprensione delle funzionalità della shell e di Python) richiede, avendo prima installato [Anaconda](https://www.anaconda.com/products/individual), di digitare sulla console del proprio computer (la shell) le seguenti istruzioni:

````
conda create -n stan-env -c conda-forge cmdstan
conda activate stan-env
````

Su `macos`, prima di installare `cmdstan`, è necessario installare la versione più recente di Xcode. Dopo avere installato Xcode, aprire la app. Verrà chiesto all'utente se si vogliono istallare delle componenti aggiuntive. Questo passaggio è cruciale, perché senza queste componenti aggiuntive `cmdstan` non funzionerà. Dopo avere installato le componenti aggiuntive, aprire Xcode e, in caso, accettare i termini della licenza. A quel punto si può chiudere Xcode. Ogni volta che Xcode viene aggiornato (deve sempre essere aggiornato quando un aggiornamento è disponibile), queste operazioni vanno ripetute.




