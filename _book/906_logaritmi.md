# Funzioni esponenziale e logaritmica {#funs-exp-log}



## Funzione esponenziale

::: {.definition}
La funzione esponenziale con base $a$ è
\begin{equation}
f(x) = a^x
\end{equation}
\noindent
dove $a > 0$, $a \neq 1$ e $x$ è qualsiasi numero reale.
::: 

La base $a = 1$ è esclusa perché produce $f(x) = 1^x = 1$, la quale è una costante, non una funzione esponenziale.

Per esempio, un grafico della funzione esponenziale di base 2 si trova con


```r
exp_base2 = function(x){2^x}
tibble(x = c(-5, 5)) %>% 
ggplot(aes(x = x)) + 
  stat_function(fun = exp_base2)
```



\begin{center}\includegraphics{906_logaritmi_files/figure-latex/unnamed-chunk-1-1} \end{center}
Se usiamo la base 4 troviamo


```r
exp_base4 = function(x){4^x}
tibble(x = c(-5, 5)) %>% 
ggplot(aes(x = x)) + 
  stat_function(fun = exp_base4)
```



\begin{center}\includegraphics{906_logaritmi_files/figure-latex/unnamed-chunk-2-1} \end{center}
Oppure


```r
exp_base4 = function(x){4^-{x}}
tibble(x = c(-5, 5)) %>% 
ggplot(aes(x = x)) + 
  stat_function(fun = exp_base4)
```



\begin{center}\includegraphics{906_logaritmi_files/figure-latex/unnamed-chunk-3-1} \end{center}

In molte applicazioni la scelta più conveniente per la base è il numero irrazionale $e = 2.718281828\dots. Questo numero è chiamato la base naturale.  La funzione $f(x) = e^x$ è chiamata funzione esponenziale naturale.

Per esempio, abbiamo


```r
exp_base_e= function(x){exp(x)}
tibble(x = c(-2, 1.5)) %>% 
ggplot(aes(x = x)) + 
  stat_function(fun = exp_base_e)
```



\begin{center}\includegraphics{906_logaritmi_files/figure-latex/unnamed-chunk-4-1} \end{center}


## Funzione logaritmica

La funzione logaritmica è la funzione inversa della funzione espenziale. 

::: {.definition}
Siano $a > 0$, $a \neq 1$. Per $x > 0$
\begin{equation}
y = \log_a x \quad \text{se e solo se } x = a^y.
\end{equation}
\noindent
La funzione data da
\begin{equation}
f(x) = \log_a x
\end{equation}
\noindent
è chiamata funzione logaritmica.
::: 

Le seguenti equazioni sono dunque equivalenti:

\begin{equation}
y = \log_a x \qquad x = a^y.
\end{equation}

La prima equazione è in forma logaritmica e la seconda è in forma esponenziale. Ad esempio, l'equazione logaritmica $2 = \log_3 9$ può essere riscritta in forma esponenziale come $9 = 3^2$. 

Quando valutiamo i logaritmi, dobbiamo ricordare che un logaritmo è un esponente. Ciò significa che $\log_a x$ è l'esponente a cui deve essere elevato $a$ per ottenere $x$.
