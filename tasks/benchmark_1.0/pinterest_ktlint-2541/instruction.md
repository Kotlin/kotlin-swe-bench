# Implement the issue(s) in pinterest/ktlint:

## Issue #2535 https://github.com/pinterest/ktlint/issues/2535: Internal Error occurred when formatting a file with multi-line KDoc comment

<!-- The bug you're experiencing might have already been reported!
Please search in the [issues](https://github.com/pinterest/ktlint/issues) before creating one. -->

## Expected Behavior
<!---Tell us what should happen. -->
<!-- If relevant, provide a link to the relevant section in the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) or [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide).  -->

<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

## Observed Behavior
<!---Tell us what happens instead of the expected behavior -->
<!--- Provide the exact command which was executed but please -->
<!--- ensure that the flag "--log-level=debug" is added to the -->
<!--- command as well. Provide the output of this command. -->

An Internal Error occurred when formatting a file with multi-line KDoc comment.

The file I tried to format: 
```
class ClassA
/**
 * some comment 
 */(paramA: String)
```

Executed command & Error logs(stacktrace):
```
$ ktlint --format ClassA.kt
/tmp/ClassA.kt:0:0: Internal Error (rule 'standard:parameter-list-wrapping') in ClassA.kt at position '0:0. Please create a ticket at https://github.com/pinterest/ktlint/issues and provide the source code that triggered an error.
com.pinterest.ktlint.rule.engine.api.KtLintRuleException: Rule 'standard:parameter-list-wrapping' throws exception in file 'ClassA.kt' at position (0:0)
   Rule maintainer: KtLint
   Issue tracker  : https://github.com/pinterest/ktlint/issues
   Repository     : https://github.com/pinterest/ktlint
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRule(RuleExecutionContext.kt:65)
	at com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine$format$3.invoke(KtLintRuleEngine.kt:146)
	at com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine$format$3.invoke(KtLintRuleEngine.kt:145)
	at com.pinterest.ktlint.rule.engine.internal.VisitorProvider$visitor$3.invoke(VisitorProvider.kt:46)
	at com.pinterest.ktlint.rule.engine.internal.VisitorProvider$visitor$3.invoke(VisitorProvider.kt:44)
	at com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine.format(KtLintRuleEngine.kt:145)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.format(KtlintCommandLine.kt:485)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.process(KtlintCommandLine.kt:471)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.access$process(KtlintCommandLine.kt:57)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine$lintFiles$3.invoke$lambda$0(KtlintCommandLine.kt:411)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:317)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1144)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:642)
	at java.base/java.lang.Thread.run(Thread.java:1583)
Caused by: java.lang.NullPointerException: Cannot invoke "org.jetbrains.kotlin.com.intellij.psi.impl.source.codeStyle.IndentHelper.getIndent(org.jetbrains.kotlin.com.intellij.psi.PsiFile, org.jetbrains.kotlin.com.intellij.lang.ASTNode)" because the return value of "org.jetbrains.kotlin.com.intellij.psi.impl.source.codeStyle.IndentHelper.getInstance()" is null
	at org.jetbrains.kotlin.com.intellij.psi.impl.source.codeStyle.CodeEditUtil.saveWhitespacesInfo(CodeEditUtil.java:108)
	at org.jetbrains.kotlin.com.intellij.psi.impl.source.codeStyle.CodeEditUtil.removeChildren(CodeEditUtil.java:120)
	at org.jetbrains.kotlin.com.intellij.psi.impl.source.codeStyle.CodeEditUtil.removeChild(CodeEditUtil.java:35)
	at org.jetbrains.kotlin.com.intellij.psi.impl.source.tree.CompositeElement.deleteChildInternal(CompositeElement.java:451)
	at org.jetbrains.kotlin.com.intellij.psi.impl.source.tree.LeafPsiElement.delete(LeafPsiElement.java:182)
	at com.pinterest.ktlint.ruleset.standard.rules.ParameterListWrappingRule.wrapParameterInList(ParameterListWrappingRule.kt:241)
	at com.pinterest.ktlint.ruleset.standard.rules.ParameterListWrappingRule.wrapParameterList(ParameterListWrappingRule.kt:192)
	at com.pinterest.ktlint.ruleset.standard.rules.ParameterListWrappingRule.beforeVisitChildNodes(ParameterListWrappingRule.kt:79)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$1.invoke(RuleExecutionContext.kt:125)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$1.invoke(RuleExecutionContext.kt:124)
	at com.pinterest.ktlint.rule.engine.internal.SuppressHandler.handle(SuppressHandler.kt:28)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:124)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:93)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.access$executeRuleOnNodeRecursively(RuleExecutionContext.kt:30)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$2$1.invoke(RuleExecutionContext.kt:132)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$2$1.invoke(RuleExecutionContext.kt:131)
	at com.pinterest.ktlint.rule.engine.internal.SuppressHandler.handle(SuppressHandler.kt:28)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:131)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:93)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.access$executeRuleOnNodeRecursively(RuleExecutionContext.kt:30)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$2$1.invoke(RuleExecutionContext.kt:132)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$2$1.invoke(RuleExecutionContext.kt:131)
	at com.pinterest.ktlint.rule.engine.internal.SuppressHandler.handle(SuppressHandler.kt:28)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:131)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:93)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.access$executeRuleOnNodeRecursively(RuleExecutionContext.kt:30)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$2$1.invoke(RuleExecutionContext.kt:132)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$executeRuleOnNodeRecursively$2$1.invoke(RuleExecutionContext.kt:131)
	at com.pinterest.ktlint.rule.engine.internal.SuppressHandler.handle(SuppressHandler.kt:28)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:131)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRuleOnNodeRecursively(RuleExecutionContext.kt:93)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.executeRule(RuleExecutionContext.kt:62)
	... 13 more
 ()

Summary error count (descending) by rule:
  An internal error occurred in the Ktlint Rule Engine: 1

```
## Steps to Reproduce
<!--- Provide a code example, or an unambiguous set of steps to -->
<!--- reproduce this bug. Minimize the example to the bare -->
<!--- minimum required to reproduce the bug. Small, well written -->
<!--- example are proven to be resolved quicker. -->

1. Create this file.
```kotlin
class ClassA
/**
 * some comment
 */(paramA: String)
```
2. Execute `format` command.
```
$ ktlint --format ClassA.kt
```

### Additional information

If there is a space between the slash '/' at the end of the multi-line comment and the parentheses '(' at the beginning of the property definition, no internal error will occur and the format will succeed. The execution result will be as follows.

The file to format( a space between '/' and '(' ): 
```kotlin
class ClassA
/**
 * some comment
 */ (paramA: String)
```

Result:
```kotlin
class ClassA
/**
 * some comment
 */
(paramA: String)
```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.1.1
* Relevant parts of the `.editorconfig` settings:
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): command line
* Version of Gradle used (if applicable):
* Operating System and version: 

