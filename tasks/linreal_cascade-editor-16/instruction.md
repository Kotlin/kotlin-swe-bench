# Implement free indentation and ancestry-based ordered-list prefixes in CascadeEditor

> Provenance note: The source change was merged with an empty body. This task
> description was reconstructed after merge from the committed behavior,
> tests, and documentation. The source history has not been altered.

## Problem

CascadeEditor currently treats indentation as a strict outline: supported
blocks cannot start a document or an outline segment at a non-zero level,
adjacent blocks cannot skip levels, and indentation is limited to levels 0–3.
This causes valid indentation to be normalized away during editing,
serialization, structural actions, and drag-and-drop.

Numbered-list prefix style also depends directly on absolute indentation depth.
That produces incorrect markers when numbered items are nested beneath
non-numbered blocks or indentation levels are skipped.

## Expected behavior

- Supported text and list blocks accept indentation levels 0–5.
- A supported block may begin a document or a new outline segment at any valid
  level, and adjacent supported blocks may skip levels.
- Blocks that do not support indentation remain at level 0 and act as outline
  boundaries.
- Indent/outdent, deletion, type conversion, state replacement, JSON loading,
  history replay, and drag-and-drop preserve valid free indentation.
- Dragging keeps the complete payload within levels 0–5 and does not
  accidentally adopt the following non-dragged block as a descendant.
- A numbered item without a numbered-list ancestor uses decimal markers.
- A numbered item nested under a decimal numbered list uses lowercase
  alphabetic markers; the next numbered-list nesting level uses lowercase
  Roman numerals.
- Additional numbered-list nesting cycles through decimal, lowercase
  alphabetic, and lowercase Roman styles.
- Supported non-numbered blocks between a numbered item and its numbered-list
  ancestor do not advance or reset marker style.
- Unsupported outline boundaries reset numbered-list ancestry.
- The stored list number remains decimal; marker style is presentation-only.

Existing editor behavior outside these contracts must remain green.
