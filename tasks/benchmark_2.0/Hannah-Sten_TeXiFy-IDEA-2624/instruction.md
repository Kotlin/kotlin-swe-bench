# Implement the issue(s) in Hannah-Sten/TeXiFy-IDEA:

## Issue: Indentation within document environment

#### Type of JetBrains IDE (IntelliJ, PyCharm, etc.) and version
IntelliJ IDEA 2022.2 (Ultimate Edition). Build #IU-222.3345.118, built on July 26, 2022

#### Operating System
Ubuntu 20.04.4 LTS (focal)

#### TeXiFy IDEA version
0.7.21

#### What I did (steps to reproduce)
In a fresh empty tex file, I added document class and document environment.
First line was not indented but all subsequent lines get indentation.
Environments don't move back to cancel indentation without indentation are indented including `end{...}`

Please note, the `Indent document environment` is unticked.

##### Comment
I might be missing something here because I know this was first time reported in #2127 and fixed/enhanced in #2347 but this still doesn't seems to be working as I expect.

#### Minimal example to reproduce the problem

```latex
\documentclass{article}

\begin{document}
X

  X

  X
\end{document}
```

or 

```latex
\documentclass{article}

\begin{document}
\begin{align}
  \end{align}
\end{document}
```

#### Expected behavior
All new paragraph should not be indented within the `document` environment.

#### Actual behavior
Only the first line is not indented. All subsequent lines have indentation.

#### (if applicable) The full stacktrace of the exception thrown
N/A - no crash (?)

#### Attachment:

![idea-code-style](/task-assets/instruction/bc4198ab2682c597.png)
![texify-idea](/task-assets/instruction/3e720cd174dbf6ac.gif)

