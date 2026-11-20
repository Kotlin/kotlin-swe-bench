# Implement the issue(s) in Hannah-Sten/TeXiFy-IDEA:

## Issue #2857 https://github.com/Hannah-Sten/TeXiFy-IDEA/issues/2857: "Convert to LaTeX alternative" command unexpectedly rearranged text and caused a NullPointerException

### Type of JetBrains IDE (IntelliJ, PyCharm, etc.) and version
PyCharm 2022.3.1 (build PY-223.8214.51)

### Operating System 
Windows 11 10.0 (amd64)

### TeXiFy IDEA version
0.7.25.1

### Description
I used the command to convert primitive \bf to \textbf.
It produced a NullPointerException with the below stack trace and had the side effect of moving the line of text following the original \bf text into the new \textbf. The original \bf text is now enclosed in curly braces immediately after the new \textbf.
I've included the relevant snippets of the source file before and after the "Convert to LaTeX alternative" command was used below.
I understand that the Tex commands used in this source file are rather archaic. I'm creating a new document based on an old document's source file to ensure the new document's style is consistent.

Before:
```latex
\begin{center}
{\Large \bf{Instructions for formatting (S)PC list}}
\end{center}

The format of the text file should be as follows. \\
```

After:
```latex
\begin{center}
{\Large \textbf{The format of the text file should be as follows.}{Instructions for formatting (S)PC list}}
\end{center}

 \\
```

### Stacktrace
```
java.lang.NullPointerException
	at nl.hannahsten.texifyidea.inspections.latex.codematurity.LatexPrimitiveStyleInspection$InspectionFix.applyFix(LatexPrimitiveStyleInspection.kt:90)
	at nl.hannahsten.texifyidea.inspections.latex.codematurity.LatexPrimitiveStyleInspection$InspectionFix.applyFix(LatexPrimitiveStyleInspection.kt:62)
	at com.intellij.codeInspection.LocalQuickFix.generatePreview(LocalQuickFix.java:99)
	at com.intellij.codeInspection.ex.QuickFixWrapper.generatePreview(QuickFixWrapper.java:135)
	at com.intellij.codeInsight.intention.impl.IntentionActionWithTextCaching$MyIntentionAction.generatePreview(IntentionActionWithTextCaching.java:241)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.invokePreview$lambda$3$lambda$2(IntentionPreviewComputable.kt:146)
	at com.intellij.psi.impl.source.PostprocessReformattingAspect.lambda$postponeFormattingInside$2(PostprocessReformattingAspect.java:140)
	at com.intellij.psi.impl.source.PostprocessReformattingAspect.postponeFormattingInside(PostprocessReformattingAspect.java:148)
	at com.intellij.psi.impl.source.PostprocessReformattingAspect.postponeFormattingInside(PostprocessReformattingAspect.java:139)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.invokePreview$lambda$3(IntentionPreviewComputable.kt:146)
	at com.intellij.codeInsight.intention.preview.IntentionPreviewUtils.previewSession(IntentionPreviewUtils.java:94)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.invokePreview(IntentionPreviewComputable.kt:144)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.generatePreview(IntentionPreviewComputable.kt:103)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.tryCreateDiffContent$lambda$1(IntentionPreviewComputable.kt:61)
	at com.intellij.model.SideEffectGuard.computeWithAllowedSideEffects(SideEffectGuard.java:25)
	at com.intellij.model.SideEffectGuard.computeWithoutSideEffects(SideEffectGuard.java:18)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.tryCreateDiffContent(IntentionPreviewComputable.kt:61)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.call(IntentionPreviewComputable.kt:39)
	at com.intellij.codeInsight.intention.impl.preview.IntentionPreviewComputable.call(IntentionPreviewComputable.kt:34)
	at com.intellij.openapi.application.impl.NonBlockingReadActionImpl$OTelMonitor.callWrapped(NonBlockingReadActionImpl.java:746)
	at com.intellij.openapi.application.impl.NonBlockingReadActionImpl$OTelMonitor$MonitoredComputation.call(NonBlockingReadActionImpl.java:778)
	at com.intellij.openapi.application.impl.NonBlockingReadActionImpl$Submission.insideReadAction(NonBlockingReadActionImpl.java:573)
	at com.intellij.openapi.application.impl.NonBlockingReadActionImpl$Submission.lambda$attemptComputation$3(NonBlockingReadActionImpl.java:537)
	at com.intellij.openapi.application.impl.ApplicationImpl.tryRunReadAction(ApplicationImpl.java:1086)
	at com.intellij.openapi.progress.util.ProgressIndicatorUtils.lambda$runInReadActionWithWriteActionPriority$0(ProgressIndicatorUtils.java:71)
	at com.intellij.openapi.progress.util.ProgressIndicatorUtilService.runActionAndCancelBeforeWrite(ProgressIndicatorUtilService.java:63)
	at com.intellij.openapi.progress.util.ProgressIndicatorUtils.runActionAndCancelBeforeWrite(ProgressIndicatorUtils.java:128)
	at com.intellij.openapi.progress.util.ProgressIndicatorUtils.lambda$runWithWriteActionPriority$1(ProgressIndicatorUtils.java:109)
	at com.intellij.openapi.progress.ProgressManager.lambda$runProcess$0(ProgressManager.java:68)
	at com.intellij.openapi.progress.impl.CoreProgressManager.lambda$runProcess$2(CoreProgressManager.java:188)
	at com.intellij.openapi.progress.impl.CoreProgressManager.lambda$executeProcessUnderProgress$13(CoreProgressManager.java:589)
	at com.intellij.openapi.progress.impl.CoreProgressManager.registerIndicatorAndRun(CoreProgressManager.java:664)
	at com.intellij.openapi.progress.impl.CoreProgressManager.computeUnderProgress(CoreProgressManager.java:620)
	at com.intellij.openapi.progress.impl.CoreProgressManager.executeProcessUnderProgress(CoreProgressManager.java:588)
	at com.intellij.openapi.progress.impl.ProgressManagerImpl.executeProcessUnderProgress(ProgressManagerImpl.java:60)
	at com.intellij.openapi.progress.impl.CoreProgressManager.runProcess(CoreProgressManager.java:175)
	at com.intellij.openapi.progress.ProgressManager.runProcess(ProgressManager.java:68)
	at com.intellij.openapi.progress.util.ProgressIndicatorUtils.runWithWriteActionPriority(ProgressIndicatorUtils.java:106)
	at com.intellij.openapi.progress.util.ProgressIndicatorUtils.runInReadActionWithWriteActionPriority(ProgressIndicatorUtils.java:71)
	at com.intellij.openapi.application.impl.NonBlockingReadActionImpl$Submission.attemptComputation(NonBlockingReadActionImpl.java:537)
	at com.intellij.openapi.application.impl.NonBlockingReadActionImpl$Submission.lambda$transferToBgThread$1(NonBlockingReadActionImpl.java:444)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)
	at java.base/java.util.concurrent.Executors$PrivilegedThreadFactory$1$1.run(Executors.java:702)
	at java.base/java.util.concurrent.Executors$PrivilegedThreadFactory$1$1.run(Executors.java:699)
	at java.base/java.security.AccessController.doPrivileged(AccessController.java:399)
	at java.base/java.util.concurrent.Executors$PrivilegedThreadFactory$1.run(Executors.java:699)
	at java.base/java.lang.Thread.run(Thread.java:833)

```
