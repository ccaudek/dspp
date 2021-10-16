--- 
title: "Psicometria"
author: "Corrado Caudek"
date: "2021-10-11"
url: https://GitHubID.github.io/Repository/
github-repo: GitHubID/Repository
description: "Bookdown template based on LaTeX memoir class"
cover-image: "images/logo.png"
# Title page...
maintitlepage:
  epigraph: |
    This document is reproducible thanks to:
    \begin{itemize}
      \item \LaTeX and its class memoir (\url{http://www.ctan.org/pkg/memoir}).
      \item R (\url{http://www.r-project.org/}) and RStudio (\url{http://www.rstudio.com/})
      \item bookdown (\url{http://bookdown.org/}) and memoiR (\url{https://ericmarcon.github.io/memoiR/})
    \end{itemize}
  credits: |
    Name of the owner of the logo
    
    \url{http://www.company.com}
    
    An explanatory sentence.
    Leave an empty line for line breaks.
# ... or a PDF cover
pdftitlepage: images/cover.pdf
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
# fontsize: 12pt
# Fonts installed by a package. LaTeX tex-gyre package must be installed for:
# mainfont: texgyretermes          # Times New Roman for the text
mainfontoptions:
  - Extension=.otf
  - UprightFont=*-regular
  - BoldFont=*-bold
  - BoldItalicFont=*-bolditalic
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
# Chapter summary text
chaptersummary: In a Nutshell
# Back Cover
backcover:
  - language: italian
    abstract: |
      English abstract, on the last page.
  
      This is a bookdown template based on LaTeX memoir class.
    keywords:
      - Keyword in English
      - As a list
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






# Introduction {-}

This document allows you to create a book in PDF format (and ePub format) at the same time as an HTML version to be published on the web.
The syntax is that of **Markdown** with some extensions.

The **bookdown** package must be installed from CRAN or GitHub:


 \scriptsize


```r
install.packages("bookdown")
# or the development version
# devtools::install_github('rstudio/bookdown')
```

 \normalsize

The book is organized in chapters. 
Each chapter is an Rmd file, whose name normally begins with its number (e.g. `01-intro.Rmd`).
All Rmd files in the project folder are actually treated as chapters, sorted by filename.
The index.Rmd file is special: it contains the document header and the first chapter.

This first chapter is placed in the foreword of the printed book: it should not be numbered (hence the `{-}` code next to the title) in the HTML version.
It must end with the LaTeX command `\mainmatter` which marks the beginning of the body of the book.

The outline levels start with `#` for chapters (only one per file), `##` for sections, etc.

Compilation in PDF format is done by XeLaTeX, which must be installed.

While writing, it is strongly advised to create only the HTML file, which is much faster than a LaTeX compilation.
Each chapter can be viewed very quickly by clicking on the _Knit_ button above the source window.
The entire book is created by clicking on the _Build Book_ button in the RStudio _Build_ window.
The button's drop-down list allows you to create all documents or limit yourself to one format.

<!-- The \mainmatter command marks the beginning of the LaTeX document body--> 
<!-- It must not be deleted-->
\mainmatter
 

<!--chapter:end:index.Rmd-->

