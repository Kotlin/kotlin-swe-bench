Markdown fails to render dollar sign
Attempting to render text with a dollar sign as Markdown fails with an exception.

Example:
```kotlin
Terminal().println(Markdown("Just $10"))
```

this fails with
```
java.lang.IllegalStateException: Unexpected token when parsing inlines: org.intellij.markdown.ast.LeafASTNode@4982cc36; [Markdown:DOLLAR:'$'}]
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.parseInlines(MarkdownRenderer.kt:262)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.innerInlines$lambda$11(MarkdownRenderer.kt:274)
	at kotlin.text.StringsKt__AppendableKt.appendElement(Appendable.kt:84)
	at kotlin.collections.CollectionsKt___CollectionsKt.joinTo(_Collections.kt:3493)
	at kotlin.collections.CollectionsKt___CollectionsKt.joinToString(_Collections.kt:3510)
	at kotlin.collections.CollectionsKt___CollectionsKt.joinToString$default(_Collections.kt:3509)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.innerInlines(MarkdownRenderer.kt:274)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.innerInlines$default(MarkdownRenderer.kt:272)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.parseStructure(MarkdownRenderer.kt:119)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.parseBlocks$lambda$0(MarkdownRenderer.kt:69)
	at com.github.ajalt.mordant.table.TableDslKt.verticalLayout(TableDsl.kt:375)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.parseBlocks(MarkdownRenderer.kt:57)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.parseFile(MarkdownRenderer.kt:53)
	at com.github.ajalt.mordant.markdown.MarkdownRenderer.render(MarkdownRenderer.kt:47)
	at com.github.ajalt.mordant.markdown.Markdown.document(Markdown.kt:25)
	at com.github.ajalt.mordant.markdown.Markdown.render(Markdown.kt:31)
	at com.github.ajalt.mordant.rendering.Widget$DefaultImpls.render$default(Widget.kt:7)
	at com.github.ajalt.mordant.terminal.Terminal.render(Terminal.kt:279)
	at com.github.ajalt.mordant.terminal.Terminal.println(Terminal.kt:238)
	at com.github.ajalt.mordant.terminal.Terminal.println$default(Terminal.kt:237)
```

What works are dollar signs within backticks: 
```kotlin
Terminal().println(Markdown("`this $ works`"))
```

## Requirements

- Inline math (`$...$`) renders like a code span and block math (`$$...$$`) like a code block, showing the text between the delimiters as is
