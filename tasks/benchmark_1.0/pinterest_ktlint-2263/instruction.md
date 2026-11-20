# Implement the issue(s) in pinterest/ktlint:

## Issue #2260 https://github.com/pinterest/ktlint/issues/2260: Unclear function-naming with wrong line/position

## Expected Behavior
<!---Tell us what should happen. -->
<!-- If relevant, provide a link to the relevant section in the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) or [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide).  -->
I don't know what the style guide says, but surely the line numbers should at least be correct. Which in this case would be line 26 ff.

<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

## Observed Behavior
```
% ktlint --log-level=debug [...]/Cookie.kt
17:17:47.628 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered RuleSetProviderV3 with id 'standard' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'baseline' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'plain' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'checkstyle' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'json' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'format' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'html' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'plain-summary' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintServiceLoader - Discovered ReporterProviderV2 with id 'sarif' in ktlint JAR
17:17:47.740 [main] DEBUG com.pinterest.ktlint.cli.internal.ReporterAggregator - Initializing "plain" reporter with {plain=true, color=false, color_name=DARK_GRAY, format=false}
17:17:47.750 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine - Starting with linting file 'Cookie.kt'
17:17:47.945 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.EditorConfigLoader - Effective editorconfig properties for file '/Users/ta/Digitalparking/main-checkout-1/java/cloud/admin/src/main/java/core/admin/authorization/Cookie.kt':
        charset: utf-8
        insert_final_newline: true
        end_of_line: lf
        indent_style: space
        indent_size: 4
        trim_trailing_whitespace: true
        max_line_length: off
        tab_width: 4
        wildcard_import_limit: 999
        ij_java_names_count_to_use_import_on_demand: 999
        ij_java_class_count_to_use_import_on_demand: 999
        ij_kotlin_name_count_to_use_star_import: 999
        ij_kotlin_name_count_to_use_star_import_for_members: 999
        ij_kotlin_imports_layout: *, java.**, javax.**, kotlin.**, ^
        ij_kotlin_allow_trailing_comma: true
        ij_kotlin_allow_trailing_comma_on_call_site: true
17:17:47.952 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.rulefilter.RunAfterRuleFilter - Rule with id 'standard:argument-list-wrapping' should run after the rule with id 'standard:class-signature'. However, the latter rule is not loaded and is allowed to be ignored. For best results, it is advised load the rule.
17:17:47.952 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.rulefilter.RunAfterRuleFilter - Rule with id 'standard:indent' should run after the rule with id 'standard:class-signature'. However, the latter rule is not loaded and is allowed to be ignored. For best results, it is advised load the rule.
17:17:47.952 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.rulefilter.RunAfterRuleFilter - Rule with id 'standard:argument-list-wrapping' should run after the rule with id 'standard:class-signature'. However, the latter rule is not loaded and is allowed to be ignored. For best results, it is advised load the rule.
17:17:47.952 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.rulefilter.RunAfterRuleFilter - Rule with id 'standard:indent' should run after the rule with id 'standard:class-signature'. However, the latter rule is not loaded and is allowed to be ignored. For best results, it is advised load the rule.
17:17:47.953 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.rulefilter.RunAfterRuleFilter - Rule with id 'standard:indent' should run after the rule with id 'standard:class-signature'. However, the latter rule is not loaded and is allowed to be ignored. For best results, it is advised load the rule.
17:17:47.965 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.internal.RuleProviderSorter - Rules will be executed in order below:
           - internal:ktlint-suppression, 
           - standard:annotation-spacing, 
           - standard:blank-line-before-declaration, 
           - standard:chain-wrapping, 
           - standard:class-naming, 
           - standard:colon-spacing, 
           - standard:comma-spacing, 
           - standard:comment-spacing, 
           - standard:comment-wrapping, 
           - standard:context-receiver-wrapping, 
           - standard:curly-spacing, 
           - standard:discouraged-comment-location, 
           - standard:dot-spacing, 
           - standard:double-colon-spacing, 
           - standard:enum-entry-name-case, 
           - standard:enum-wrapping, 
           - standard:filename, 
           - standard:final-newline, 
           - standard:fun-keyword-spacing, 
           - standard:function-naming, 
           - standard:function-return-type-spacing, 
           - standard:function-start-of-body-spacing, 
           - standard:function-type-reference-spacing, 
           - standard:if-else-bracing, 
           - standard:import-ordering, 
           - standard:kdoc-wrapping, 
           - standard:keyword-spacing, 
           - standard:modifier-list-spacing, 
           - standard:modifier-order, 
           - standard:multiline-expression-wrapping, 
           - standard:multiline-if-else, 
           - standard:no-blank-line-before-rbrace, 
           - standard:no-blank-line-in-list, 
           - standard:no-blank-lines-in-chained-method-calls, 
           - standard:no-consecutive-blank-lines, 
           - standard:no-consecutive-comments, 
           - standard:no-empty-class-body, 
           - standard:no-empty-file, 
           - standard:no-empty-first-line-in-class-body, 
           - standard:no-empty-first-line-in-method-block, 
           - standard:no-line-break-after-else, 
           - standard:no-line-break-before-assignment, 
           - standard:no-multi-spaces, 
           - standard:no-trailing-spaces, 
           - standard:no-unit-return, 
           - standard:no-unused-imports, 
           - standard:no-wildcard-imports, 
           - standard:nullable-type-spacing, 
           - standard:op-spacing, 
           - standard:package-name, 
           - standard:parameter-list-spacing, 
           - standard:parameter-list-wrapping, 
           - standard:parameter-wrapping, 
           - standard:paren-spacing, 
           - standard:property-naming, 
           - standard:property-wrapping, 
           - standard:range-spacing, 
           - standard:spacing-around-angle-brackets, 
           - standard:spacing-between-declarations-with-annotations, 
           - standard:spacing-between-declarations-with-comments, 
           - standard:spacing-between-function-name-and-opening-parenthesis, 
           - standard:statement-wrapping, 
           - standard:string-template, 
           - standard:try-catch-finally-spacing, 
           - standard:type-argument-list-spacing, 
           - standard:type-parameter-list-spacing, 
           - standard:unary-op-spacing, 
           - standard:unnecessary-parentheses-before-trailing-lambda, 
           - standard:annotation, 
           - standard:if-else-wrapping, 
           - standard:no-single-line-block-comment, 
           - standard:wrapping, 
           - standard:argument-list-wrapping, 
           - standard:no-semi, 
           - standard:function-signature, 
           - standard:trailing-comma-on-call-site, 
           - standard:trailing-comma-on-declaration-site, 
           - standard:indent, 
           - standard:block-comment-initial-star-alignment, 
           - standard:string-template-indent, 
           - standard:max-line-length
17:17:48.047 [pool-1-thread-1] DEBUG com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine - Finished with linting file 'Cookie.kt'
/[...]/Cookie.kt:1:2: Function name should start with a lowercase letter (except factory methods) and use camel case (standard:function-naming)

Summary error count (descending) by rule:
  standard:function-naming: 1
17:17:48.048 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintCommandLine - Finished processing in 425ms / 1 file(s) scanned / 1 error(s) found
17:17:48.048 [main] DEBUG com.pinterest.ktlint.cli.internal.KtlintCommandLine - Exit ktlint with exit code: 1

```

## Steps to Reproduce
Run ktlint against a file containing the following snippet. In my case starting line 26.
```kotlin
val getAdminPortalCookie =

    fun(req: Request): String? {
        return null
    }
```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.0.0
* Operating System and version: OSX Ventura 13.5.2 (22G91)
