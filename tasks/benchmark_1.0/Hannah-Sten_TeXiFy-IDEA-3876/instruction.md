# Implement the issue(s) in Hannah-Sten/TeXiFy-IDEA:

## Issue #3847 https://github.com/Hannah-Sten/TeXiFy-IDEA/issues/3847: TeXiFy not able to determine correct file/lineno from error log

#### Type of JetBrains IDE (IntelliJ, PyCharm, etc.) and version
PyCharm 2024.1.4 (Professional Edition)
Build #PY-241.18034.82, built on June 24, 2024

#### Operating System 
MacOS

#### TeXiFy IDEA version
0.9.7

#### What I did (steps to reproduce)

1. compiled a latex file that had an undefined command,

2. clicked on the error message in the "Log Messages" subsection of the console output.

#### Minimal example to reproduce the problem

```latex
\documentclass{article}

\setlength{\textheight}{3in}   % commenting this line out makes the problem go away

\newcommand{\filler}{
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
}
\begin{document}

    \filler

    \filler

    \filler

    \filler

    \filler

    \asd

\end{document}
```

#### Expected behavior

Pycharm should move the cursor to the line with the error.

#### Actual behavior

Pycharm doesn't move the cursor to the line with the error.

I'm assuming that the problem is with the parsing of the log.  I'm guessing the line

`[1{/usr/local/texlive/2024/texmf-var/fonts/map/pdftex/updmap/pdftex.map}]`

is somehow causing TeXiFy to lose track of the file that the error message is in.  More specifically, when the log contains the following lines preceding the error, it doesn't work:

```
(./0_main.tex
LaTeX2e <2024-11-01> patch level 1
L3 programming layer <2024-12-25>
(/usr/local/texlive/2024/texmf-dist/tex/latex/base/article.cls
Document Class: article 2024/06/29 v1.4n Standard LaTeX document class
(/usr/local/texlive/2024/texmf-dist/tex/latex/base/size10.clo))
(/usr/local/texlive/2024/texmf-dist/tex/latex/l3backend/l3backend-pdftex.def)
(/Users/neal/Desktop/mwe/out/0_main.aux)
[1{/usr/local/texlive/2024/texmf-var/fonts/map/pdftex/updmap/pdftex.map}]
./0_main.tex:23: Undefined control sequence.
l.23     \asd
```

When the log contains these lines (which happens for me if all text fits on a page), it does work:

```
(./0_main.tex
LaTeX2e <2024-11-01> patch level 1
L3 programming layer <2024-12-25>
(/usr/local/texlive/2024/texmf-dist/tex/latex/base/article.cls
Document Class: article 2024/06/29 v1.4n Standard LaTeX document class
(/usr/local/texlive/2024/texmf-dist/tex/latex/base/size10.clo))
(/usr/local/texlive/2024/texmf-dist/tex/latex/l3backend/l3backend-pdftex.def)
(/Users/neal/Desktop/mwe/out/0_main.aux)
./0_main.tex:23: Undefined control sequence.
l.23     \asd

```

#### (if applicable) The full stacktrace of the exception thrown
```

```

<!-- If you see a minor issue related to commands or environments metadata, e.g. which commands are cite or verbatim commands, you are encouraged to try to add the missing information yourself, see https://hannah-sten.github.io/TeXiFy-IDEA/contributing-to-the-source-code.html -->
