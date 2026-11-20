# Implement the issue(s) in Hannah-Sten/TeXiFy-IDEA:

## Issue #3857 https://github.com/Hannah-Sten/TeXiFy-IDEA/issues/3857: Custom code-folding region improvement

I would like to use custom folding regions (as documented [here](https://hannah-sten.github.io/TeXiFy-IDEA/editing-a-latex-file.html#custom-folding-regions)) but I'm running into an issue.

IntelliJ platform will ignore custom folding regions that don't 'nest' nicely within other folding regions. For example:

```py
# region my description
def foo():
    bar = "baz"
# endregion
    return bar
```

The `region`/`endregion` magic comments here will be ignored by PyCharm, since they overlap with the `def foo():` fold, but are not completely contained by it. 

In LaTeX files, TeXiFy-IDEA will create folds at `\section{...}` commands, which fold everything up to the next `\section{...}`.

This means IntelliJ platform will ignore all the magic comments in the following example:

```latex
\begin{document}

%! region introduction
\section{introduction}
\blindtext
%! endregion

%! region salient point
\section{salient point}
\blindtext
%! endregion

%! region references
\newpage
\nocite{*}
\printbibliography
%! endregion

\end{document}
```

and in general, any custom folding region which contains a [document sectioning command](https://www.overleaf.com/learn/latex/Sections_and_chapters#Document_sectioning) will encounter this issue!

## resolution ideas
- (not preferable) exclusively create folding regions *within* document sections, never enclosing them
- add a magic comment which marks the end of a labelled document section, e.g. 
  ```latex
  \section{foobar}\label{sec:foobar}
  \blindtext
  %! endsection sec:foobar
  % and similar for other sectioning commands, e.g.
  ...
  %! endparagraph par:foobar
  ```
  the idea being that the sectioning command's fold would only fold up to the `endsection` magic comment, and no further
- Constrict sectioning commands' folding regions to end on the line prior to any `%! endregion` whose matching `%! region ...` began prior to the relevant sectioning command
- add a configuration option which enables/disables folding at sectioning commands
- (unsure of feasibility) Assign custom folding regions a higher 'folding priority' than sectioning commands, so that IntelliJ platform will respect the custom regions and disable folding at sectioning commands when appropriate
