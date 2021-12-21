--- 
title: "Psicometria"
author: "Corrado Caudek"
date: "2021-12-21"
url: https://github.com/ccaudek/dspp/
github-repo: ccaudek/dspp
description: "This is dspp, aka Data science per psicologi."
# cover-image: "images/logo.png"
# Title page...
maintitlepage:
  epigraph: |
    Questo documento è stato realizzato con:
    \begin{itemize}
      \item \LaTeX\; e la classe memoir (\url{http://www.ctan.org/pkg/memoir});
      \item $\R$ (\url{http://www.r-project.org/}) e RStudio (\url{http://www.rstudio.com/});
      \item bookdown (\url{http://bookdown.org/}) e memoiR (\url{https://ericmarcon.github.io/memoiR/}).
    \end{itemize}
  credits: |

    Nel blog della mia pagina personale sono forniti alcuni approfondimenti degli argomenti qui trattati.
    
     \url{https://ccaudek.github.io/caudeklab/}
    
# ... or a PDF cover
# pdftitlepage: images/cover.pdf
# Language
lang: it
otherlangs: [en-US]
# LaTeX
documentclass: memoir
classoption:
  - extrafontsizes
  - onecolumn
  - openright
# Paper, font
papersize: A4
fontsize: 10pt
# Fonts installed by a package. LaTeX tex-gyre package must be installed for:
# mainfont: texgyretermes          # Times New Roman for the text
mainfontoptions:
  - Extension=.otf
  - UprightFont=*-regular
  - BoldFont=*-bold
  - BoldItalicFont=*-bolditalic
monofont: "Operator Mono SSm Lig Book"
monofontoptions: "Scale=0.75"
# mathfont: texgyretermes-math.otf # Times New Roman for equations
# memoir Style
MemoirChapStyle: daleif1           # or companion with large margins
MemoirPageStyle: Ruled             # or companion with large margins
# Margins
largemargins: false                # or true for large margins
smallmargin: 1.5in                 # outer margin (small).
largemargin: 3in                   # outer margin (large)
marginnote:  1.8in                 # note width in large margin
spinemargin: 1.5in                 # spine margin. Reduce to 1.2 with large margins.
uppermargin: 1.5in                 # upper margin
lowermargin: 1in                   # lower margin
# Table of contents
toc-depth: 2
# Section numbering
secnum-depth: section
# List of tables / Figures
lot: false
lof: true
# Bibliography
bibliography: refs.bib
biblatexoptions:
  - backend=biber
  - style=authoryear-ibid  # or verbose-inote with large margins
# - pageref=true           # uncomment for verbose-inotes style
  - isbn=false
  - backref=true
  - giveninits=true
  - uniquename=init
  - maxcitenames=2
  - maxbibnames=150
  - sorting=nyt
  - sortcites=false
  - style=apa
# Chapter summary text
chaptersummary: In breve
# Back Cover
backcover:
  - language: italian
    abstract: |
      This document contains the material of the lessons of Psicometria B000286 (2021/2022) aimed at students of the first year of the Degree Course in Psychological Sciences and Techniques of the University of Florence, Italy.
    keywords:
      - Data science
      - Bayesian statistics
    abstractlabel: Abstract
    keywordlabel: Keywords
backcoverfontsize: normalsize
# Figure cropping may be set to no if ghostscript is not installed
fig_crop: true
# Do not modify
site: bookdown::bookdown_site
always_allow_html: true
graphics: true
link-citations: true
colorlinks: true
---

<!-- HTML code necessary for key messages --> 
<img src="images/trombone.png" alt="image" hidden/>







::: {.welcome}

 \scriptsize



 \normalsize

\chapter*{}

\vfill


 \scriptsize



 \normalsize


 \scriptsize

Copyright $\copyright$ 2022.

 \normalsize

Data della versione presente: Dicembre 21, 2021.
:::


# Prefazione

__Data Science per psicologi__ contiene il materiale delle lezioni dell'insegnamento di _Psicometria B000286_ (A.A. 2021/2022) rivolto agli studenti del primo anno del Corso di Laurea in Scienze e Tecniche Psicologiche dell'Università degli Studi di Firenze.

L'insegnamento di Psicometria si propone di fornire agli studenti un'introduzione all'analisi dei dati in psicologia.
<!-- Voglio subito chiarire che questo insegnamento non sarà basato sull'abilità di ricordare le cose, ma sul saper risolvere problemi. In altre parole, per superare l'esame sarà necessario avere sviluppato la capacità di "sapere fare", ovvero la capacità di risolvere i problemi di analisi dei dati che verranno discussi a lezione e che sono presentati nelle dispense.  -->
Le conoscenze/competenze che verranno sviluppate in questo insegnamento sono quelle della _Data science_, ovvero le conoscenze/competenze che si pongono all'intersezione tra statistica (ovvero, richiedono la capacità di comprendere teoremi statistici) e informatica (ovvero, richiedono la capacità di sapere utilizzare un software).


## La psicologia e la Data Science {-}

> *It’s worth noting, before getting started, that this material is hard. If you find yourself confused at any point, you are normal. Any sense of confusion you feel is just your brain correctly calibrating to the subject matter. Over time, confusion is replaced by comprehension [...]*\begin{flushright}--- Richard McElreath\end{flushright}

Sembra sensato spendere due parole su un tema che è importante per gli studenti: quello indicato dal titolo di questo Capitolo. È ovvio che agli studenti di psicologia la statistica non piace. Se piacesse, forse studierebbero Data Science e non psicologia; ma non lo fanno. Di conseguenza, gli studenti di psicologia si chiedono: ``perché dobbiamo perdere tanto tempo a studiare queste cose quando in realtà quello che ci interessa è tutt'altro?'' Questa è una bella domanda.

C'è una ragione molto semplice che dovrebbe farci capire perché la Data Science è così importante per la psicologia. Infatti, a ben pensarci, la psicologia è una disciplina intrinsecamente statistica, se per statistica intendiamo quella disciplina che studia la variazione delle caratteristiche degli individui nella popolazione.  La psicologia studia _gli individui_ ed è proprio la variabilità  inter- e intra-individuale ciò che vogliamo descrivere e, in certi casi, predire. In questo senso, la psicologia è molto diversa dall'ingegneria, per esempio. Le proprietà di un determinato ponte sotto certe condizioni, ad esempio, sono molto simili a quelle di un altro ponte, sotto le medesime condizioni. Quindi, per un ingegnere la statistica è poco importante: le proprietà dei materiali sono unicamente dipendenti dalla loro composizione e restano costanti. Ma lo stesso non può dirsi degli individui: ogni individuo è unico e cambia nel tempo. E le variazioni tra gli individui, e di un individuo nel tempo, sono l'oggetto di studio proprio della psicologia: è dunque chiaro che i problemi che la psicologia si pone sono molto diversi da quelli affrontati, per esempio, dagli ingegneri. Questa è la ragione per cui abbiamo tanto bisogno della _data science_ in psicologia: perché la _data science_ ci consente di descrivere la variazione e il cambiamento. E queste sono appunto le caratteristiche di base dei fenomeni psicologici.

Sono sicuro che, leggendo queste righe, a molti studenti sarà venuta in mente la seguente domanda: perché non chiediamo a qualche esperto di fare il "lavoro sporco" (ovvero le analisi statistiche) per noi, mentre noi (gli psicologi) ci occupiamo solo di ciò che ci interessa, ovvero dei problemi psicologici slegati dai dettagli "tecnici" della _data science_?
La risposta a questa domanda è che non è possibile progettare uno studio psicologico sensato senza avere almeno una comprensione rudimentale della _data science_. Le tematiche della _data science_ non possono essere ignorate né dai ricercatori in psicologia né da coloro che svolgono la professione di psicologo al di fuori dell'Università. Infatti, anche i professionisti al di fuori dall'università non possono fare a meno di leggere la letteratura psicologica più recente: il continuo aggiornamento delle conoscenze è infatti richiesto dalla deontologia della professione. Ma per potere fare questo è necessario conoscere un bel po' di _data science_! Basta aprire a caso una rivista specialistica di psicologia per rendersi conto di quanto ciò sia vero: gli articoli che riportano i risultati delle ricerche psicologiche sono zeppi di analisi statistiche e di modelli formali. E la comprensione della letteratura psicologica rappresenta un requisito minimo nel bagaglio professionale dello psicologo.

Le considerazioni precedenti cercano di chiarire il seguente punto: la _data science_ non è qualcosa da studiare a malincuore, in un singolo insegnamento universitario, per poi poterla tranquillamente dimenticare. Nel bene e nel male, gli psicologi usano gli strumenti della _data science_ in tantissimi ambiti della loro attività professionale: in particolare quando costruiscono, somministrano e interpretano i test psicometrici. È dunque chiaro che possedere delle solide basi di _data science_ è un tassello imprescindibile del bagaglio professionale dello psicologo. In questo insegnamento verrano trattati i temi base della _data science_ e verrà adottato un punto di vista bayesiano, che corrisponde all'approccio più recente e sempre più diffuso in psicologia.
<!-- Il mio obiettivo è quello di esporre lo studente a un'ampia gamma di domande teoriche inerenti la _data science_, considerando nel contempo una varietà di domande di ricerca su dati reali, nella speranza che ciò favorisca un approccio mentale ben fondato all'analisi dei dati psicologici. -->


## Come studiare {-}

> *I know quite certainly that I myself have no special talent. Curiosity, obsession and dogged endurance, combined with self-criticism, have brought me to my ideas.* \begin{flushright}--- Albert Einstein\end{flushright}

Il giusto metodo di studio per prepararsi all'esame di Psicometria è quello di seguire attivamente le lezioni, assimilare i concetti via via che essi vengono presentati e verificare in autonomia le procedure presentate a lezione. Incoraggio gli studenti a farmi domande per chiarire ciò che non è stato capito appieno. Incoraggio gli studenti a utilizzare i forum attivi su Moodle e, soprattutto, a svolgere gli esercizi proposti su Moodle. I problemi forniti su Moodle rappresentano il livello di difficoltà richiesto per superare l'esame e consentono allo studente di comprendere se le competenze sviluppate fino a quel punto sono sufficienti rispetto alle richieste dell'esame.

La prima fase dello studio, che è sicuramente individuale, è quella in cui è necessario acquisire le conoscenze teoriche relative ai problemi che saranno presentati all'esame. La seconda fase di studio, che può essere facilitata da scambi con altri e da incontri di gruppo, porta ad acquisire la capacità di applicare le conoscenze: è necessario capire come usare un software (\R) per applicare i concetti statistici alla specifica situazione del problema che si vuole risolvere. Le due fasi non sono però separate: il saper fare molto spesso ci aiuta a capire meglio.


## Sviluppare un metodo di studio efficace {-}

> *Memorization is not learning.*\begin{flushright}--- Richard Phillips Feynman\end{flushright}

Avendo insegnato molte volte in passato un corso introduttivo di analisi dei dati ho notato nel corso degli anni che gli studenti con l'atteggiamento mentale che descriverò qui sotto generalmente ottengono ottimi risultati. Alcuni studenti sviluppano naturalmente questo approccio allo studio, ma altri hanno bisogno di fare uno sforzo per maturarlo. Fornisco qui sotto una breve descrizione del ``metodo di studio'' che, nella mia esperienza, è il più efficace per affrontare le richieste di questo insegnamento [@burger20125].

- Dedicate un tempo sufficiente al materiale di base, apparentemente facile; assicuratevi di averlo capito bene. Cercate le lacune nella vostra comprensione. Leggere presentazioni diverse dello stesso materiale (in libri o articoli diversi) può fornire nuove intuizioni.

<!-- - Alcuni degli argomenti trattati richiedono delle conoscenze pregresse, soprattutto di tipo matematico. Tali conoscenze sono state aggiunte delle appendici di queste dispense. La lettura di tale materiale è consigliata a tutti, sia a chi sta studiando gli argomenti proposti per la prima volta, sia a chi deve ripassare per colmare eventuali lacune pregresse.  -->

- Gli errori che facciamo sono i nostri migliori maestri. Istintivamente cerchiamo di dimenticare subito i nostri errori. Ma il miglior modo di imparare è apprendere dagli errori che commettiamo. In questo senso, una soluzione corretta è meno utile di una soluzione sbagliata. Quando commettiamo un errore questo ci fornisce un'informazione importante: ci fa capire qual è il materiale di studio sul quale dobbiamo ritornare e che dobbiamo capire meglio.

- C'è ovviamente un aspetto "psicologico" nello studio. Quando un esercizio o problema ci sembra incomprensibile, la cosa migliore da fare è dire: "mi arrendo", "non ho idea di cosa fare!". Questo ci rilassa: ci siamo già arresi, quindi non abbiamo niente da perdere, non dobbiamo più preoccuparci. Ma non dobbiamo fermarci qui. Le cose "migliori" che faccio (se ci sono) le faccio quando non ho voglia di lavorare. Alle volte, quando c'è qualcosa che non so fare e non ho idea di come affontare, mi dico: "oggi non ho proprio voglia di fare fatica", non ho voglia di mettermi nello stato mentale per cui "in 10 minuti devo risolvere il problema perché dopo devo fare altre cose". Però ho voglia di _divertirmi_ con quel problema e allora mi dedico a qualche aspetto "marginale" del problema, che so come affrontare, oppure considero l'aspetto più difficile del problema, quello che non so come risolvere, ma invece di cercare di risolverlo, guardo come altre persone hanno affrontato problemi simili, opppure lo stesso problema in un altro contesto. Non mi pongo l'obiettivo "risolvi il problema in 10 minuti", ma invece quello di farmi un'idea "generale" del problema, o quello di capire un caso più specifico e più semplice del problema. Senza nessuna pressione.  Infatti, in quel momento ho deciso di non lavorare (ovvero, di non fare fatica). Va benissimo se "parto per la tangente", ovvero se mi metto a leggere del materiale che sembra avere poco a che fare con il problema centrale (le nostre intuizioni e la nostra curiosità solitamente ci indirizzano sulla strada giusta). Quando faccio così, molto spesso trovo la soluzione del problema che mi ero posto e, paradossalmente, la trovo in un tempo minore di quello che, in precedenza, avevo dedicato a "lavorare" al problema. Allora perché non faccio sempre così? C'è ovviamente l'aspetto dei "10 minuti" che non è sempre facile da dimenticare. Sotto pressione, possiamo solo agire in maniera automatica, ovvero possiamo solo applicare qualcosa che già sappiamo fare. Ma se dobbiamo imparare qualcosa di nuovo, la pressione è un impedimento.

- È utile farsi da soli delle domande sugli argomenti trattati, senza limitarsi a cercare di risolvere gli esercizi che vengono assegnati. Quando studio qualcosa mi viene in mente: "se questo è vero, allora deve succedere quest'altra cosa". Allora verifico se questo è vero, di solito con una simulazione. Se i risultati della simulazione sono quelli che mi aspetto, allora vuol dire che ho capito. Se i risultati sono diversi da quelli che mi aspettavo, allora mi rendo conto di non avere capito e ritorno indietro a studiare con più attenzione la teoria che pensavo di avere capito -- e ovviamente mi rendo conto che c'era un aspetto che avevo frainteso. Questo tipo di verifica è qualcosa che dobbiamo fare da soli, in prima persona: nessun altro può fare questo al posto nostro.

- Non aspettatevi di capire tutto la prima volta che incontrate un argomento nuovo.^[Ricordatevi inoltre che gli individui tendono a sottostimare la propria capacità di apprendere [@horn2021underestimating].] È utile farsi una nota mentalmente delle lacune nella vostra comprensione e tornare su di esse in seguito per carcare di colmarle. L'atteggiamento naturale, quando non capiamo i dettagli di qualcosa, è quello di pensare: "non importa, ho capito in maniera approssimativa questo punto, non devo preoccuparmi del resto".  Ma in realtà non è vero: se la nostra comprensione è superficiale, quando il problema verrà presentato in una nuova forma, non riusciremo a risolverlo. Per cui i dubbi che ci vengono quando studiamo qualcosa sono il nostro alleato più prezioso: ci dicono esattamente quali sono gli aspetti che dobbiamo approfondire per potere migliorare la nostra preparazione.

- È utile sviluppare una visione d'insieme degli argomenti trattati, capire l'obiettivo generale che si vuole raggiungere e avere chiaro il contributo che i vari pezzi di informazione forniscono al raggiungimento di tale obiettivo. Questa organizzazione mentale del materiale di studio facilita la comprensione. È estremamente utile creare degli schemi di ciò che si sta studiando. Non aspettate che sia io a fornirvi un riepilogo di ciò che dovete imparare: sviluppate da soli tali schemi e tali riassunti.

- Tutti noi dobbiamo imparare l'arte di trovare le informazioni, non solo nel caso di questo insegnamento. Quando vi trovate di fronte a qualcosa che non capite, o ottenete un  oscuro messaggio di errore da un software, ricordatevi: "Google is your friend".

\bigskip
Corrado Caudek

\bigskip
Febbraio 2022


<!-- The \mainmatter command marks the beginning of the LaTeX document body--> 
<!-- It must not be deleted-->
\mainmatter
 
