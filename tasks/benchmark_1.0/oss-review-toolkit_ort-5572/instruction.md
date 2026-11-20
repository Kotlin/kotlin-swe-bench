# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #5557 https://github.com/oss-review-toolkit/ort/issues/5557: No analyzer-result.yml is generated when there are no definition files, throws Exception "No dependency graph available to initialize DependencyGraphNavigator"

Hey,

Since https://github.com/oss-review-toolkit/ort/pull/5513 we get an exception in our pipelines when there are no definition files:
```
58 The following package managers are enabled:
59	Bundler, Cargo, CocoaPods, Composer, Conan, DotNet, GoDep, GoMod, Gradle, Maven, NPM, NuGet, PIP, Pipenv, Yarn, Yarn2
60 Analyzing project path:
61	/builds/some-project
62 No definition files found.
63 Exception in thread "main" java.lang.IllegalArgumentException: No dependency graph available to initialize DependencyGraphNavigator.
64	at org.ossreviewtoolkit.model.DependencyGraphNavigator.<init>(DependencyGraphNavigator.kt:33)
65	at org.ossreviewtoolkit.analyzer.managers.utils.PackageManagerDependencyHandler.<init>(PackageManagerDependencyHandler.kt:80)
66	at org.ossreviewtoolkit.analyzer.AnalyzerResultBuilderKt.resolvePackageManagerDependencies(AnalyzerResultBuilder.kt:126)
67	at org.ossreviewtoolkit.analyzer.AnalyzerResultBuilderKt.access$resolvePackageManagerDependencies(AnalyzerResultBuilder.kt:1)
68	at org.ossreviewtoolkit.analyzer.AnalyzerResultBuilder.build(AnalyzerResultBuilder.kt:55)
69	at org.ossreviewtoolkit.analyzer.AnalyzerState.buildResult(Analyzer.kt:250)
70	at org.ossreviewtoolkit.analyzer.Analyzer.analyzeInParallel(Analyzer.kt:169)
71	at org.ossreviewtoolkit.analyzer.Analyzer.analyze(Analyzer.kt:116)
72	at org.ossreviewtoolkit.cli.commands.AnalyzerCommand.run(AnalyzerCommand.kt:284)
73	at com.github.ajalt.clikt.parsers.Parser.parse(Parser.kt:198)
74	at com.github.ajalt.clikt.parsers.Parser.parse(Parser.kt:211)
75	at com.github.ajalt.clikt.parsers.Parser.parse(Parser.kt:18)
76	at com.github.ajalt.clikt.core.CliktCommand.parse(CliktCommand.kt:400)
77	at com.github.ajalt.clikt.core.CliktCommand.parse$default(CliktCommand.kt:397)
78	at com.github.ajalt.clikt.core.CliktCommand.main(CliktCommand.kt:415)
79	at com.github.ajalt.clikt.core.CliktCommand.main(CliktCommand.kt:440)
80	at org.ossreviewtoolkit.cli.OrtMainKt.main(OrtMain.kt:81) 
```
before the change, ort generated an analyser-result.yml file with an empty dependency graph which was fine. So, is that intended behaviour?

Cheers,
Marco




