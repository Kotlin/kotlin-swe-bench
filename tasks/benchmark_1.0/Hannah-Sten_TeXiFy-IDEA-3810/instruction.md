# Implement the issue(s) in Hannah-Sten/TeXiFy-IDEA:

## Issue #3580 https://github.com/Hannah-Sten/TeXiFy-IDEA/issues/3580: newcommand marked as error if used once in if clause and once in else clause (for the same environment)

#### Type of JetBrains IDE (IntelliJ, PyCharm, etc.) and version
PhpStorm 2024.1.3

#### Operating System 
MacOS Sonoma 14.5

#### TeXiFy IDEA version
0.9.6

#### What I did (steps to reproduce)
- create an ifthenelese environment
- in both if and else clause define the same command with \newcommand

#### Minimal example to reproduce the problem
```latex
\documentclass[12pt]{article}
\usepackage{ifthen}
\newcommand{\venue}{1}
\ifthenelse {\equal{\venue}{1}}{
    \newcommand\examLocation{Building 1}
}{
    \newcommand\examLocation{Building 2}
}
\begin{document}
    \examLocation
\end{document}
```

#### Expected behavior
No error indication, as this is valid LaTeX and typesets properly

#### Actual behavior
Both newcommand keywords are marked red, claiming its a duplicate definition. Clearly the fact that only if or else clause are executed is not recognized by the syntax chacker.

Screenshot 1:

<img width="471" alt="Screenshot 2024-06-11 at 13 50 15" src="https://github.com/Hannah-Sten/TeXiFy-IDEA/assets/670585/2f67573c-b3e6-43ed-b827-d0a532f33352">

Screenshot 2:

<img width="758" alt="Screenshot 2024-06-11 at 13 50 29" src="https://github.com/Hannah-Sten/TeXiFy-IDEA/assets/670585/773bd4e8-0702-4b21-919b-108bd488a638">

