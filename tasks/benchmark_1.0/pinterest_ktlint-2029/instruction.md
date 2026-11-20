# Implement the issue(s) in pinterest/ktlint:

## Issue #1974 https://github.com/pinterest/ktlint/issues/1974: Log a warning when a rule with an invalid rule id has been suppressed

## Expected Behavior
After updating to `0.49.0`, ktlint doesn't fail on the `.editorconfig` parse step. 

## Observed Behavior
Ktlint fails with exception:
```java
Exception in thread "main" java.util.concurrent.ExecutionException: java.lang.IllegalArgumentException: Rule id 'standard:max_line_length' must match '[a-z]+(-[a-z]+)*:[a-z]+(-[a-z]+)*'
	at java.base/java.util.concurrent.FutureTask.report(FutureTask.java:122)
	at java.base/java.util.concurrent.FutureTask.get(FutureTask.java:191)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.parallel(KtlintCommandLine.kt:692)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.parallel$default(KtlintCommandLine.kt:645)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.lintFiles(KtlintCommandLine.kt:422)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.run(KtlintCommandLine.kt:323)
	at com.pinterest.ktlint.Main.main(Main.kt:35)
Caused by: java.lang.IllegalArgumentException: Rule id 'standard:max_line_length' must match '[a-z]+(-[a-z]+)*:[a-z]+(-[a-z]+)*'
	at com.pinterest.ktlint.rule.engine.core.internal.IdNamingPolicy.enforceRuleIdNaming$ktlint_rule_engine_core(IdNamingPolicy.kt:17)
	at com.pinterest.ktlint.rule.engine.core.api.RuleId.constructor-impl(Rule.kt:11)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.tailToRuleIds(SuppressionLocatorBuilder.kt:210)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.createSuppressionHintFromEolComment(SuppressionLocatorBuilder.kt:121)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.createSuppressionHintFromComment(SuppressionLocatorBuilder.kt:106)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.access$createSuppressionHintFromComment(SuppressionLocatorBuilder.kt:25)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder$collect$1.invoke(SuppressionLocatorBuilder.kt:81)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder$collect$1.invoke(SuppressionLocatorBuilder.kt:78)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.collect(SuppressionLocatorBuilder.kt:98)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.collect(SuppressionLocatorBuilder.kt:101)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.collect(SuppressionLocatorBuilder.kt:101)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.collect(SuppressionLocatorBuilder.kt:101)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.collect(SuppressionLocatorBuilder.kt:101)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.collect(SuppressionLocatorBuilder.kt:78)
	at com.pinterest.ktlint.rule.engine.internal.SuppressionLocatorBuilder.buildSuppressedRegionsLocator(SuppressionLocatorBuilder.kt:57)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.rebuildSuppressionLocator(RuleExecutionContext.kt:43)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.<init>(RuleExecutionContext.kt:39)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext.<init>(RuleExecutionContext.kt)
	at com.pinterest.ktlint.rule.engine.internal.RuleExecutionContext$Companion.createRuleExecutionContext$ktlint_rule_engine(RuleExecutionContext.kt:188)
	at com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine.lint(KtLintRuleEngine.kt:94)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.lint(KtlintCommandLine.kt:542)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.process(KtlintCommandLine.kt:467)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine.access$process(KtlintCommandLine.kt:64)
	at com.pinterest.ktlint.cli.internal.KtlintCommandLine$lintFiles$3.invoke$lambda$0(KtlintCommandLine.kt:416)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
	at java.base/java.lang.Thread.run(Thread.java:829)
```

This might be related to changes made in #1825.

## Steps to Reproduce
1. Update existing project to 0.49.0.
2. Try to run Ktlint against any changes.

## Your Environment

* Version of ktlint used: 0.49.0
* Relevant parts of the `.editorconfig` settings: 
```text
root = true

[*]
indent_style = space
indent_size = 4
tab_width = 4
ij_continuation_indent_size = 4
end_of_line = lf
max_line_length = off
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
ij_visual_guides = none


[*.java]
max_line_length = 100
ij_visual_guides = 100

[*.{kt,kts}]
max_line_length = 100
ij_visual_guides = 100
ij_kotlin_imports_layout = *,^
ij_kotlin_allow_trailing_comma = true
ij_kotlin_allow_trailing_comma_on_call_site = true
ij_kotlin_align_in_columns_case_branch = false
ij_kotlin_align_multiline_binary_operation = false
ij_kotlin_align_multiline_extends_list = false
ij_kotlin_align_multiline_method_parentheses = false
ij_kotlin_align_multiline_parameters = false
ij_kotlin_align_multiline_parameters_in_calls = false
ij_kotlin_assignment_wrap = normal
ij_kotlin_blank_lines_after_class_header = 0
ij_kotlin_blank_lines_around_block_when_branches = 0
ij_kotlin_blank_lines_before_declaration_with_comment_or_annotation_on_separate_line = 1
ij_kotlin_block_comment_add_space = false
ij_kotlin_block_comment_at_first_column = true
ij_kotlin_call_parameters_new_line_after_left_paren = true
ij_kotlin_call_parameters_right_paren_on_new_line = true
ij_kotlin_call_parameters_wrap = on_every_item
ij_kotlin_catch_on_new_line = false
ij_kotlin_class_annotation_wrap = split_into_lines
ij_kotlin_code_style_defaults = KOTLIN_OFFICIAL
ij_kotlin_continuation_indent_for_chained_calls = false
ij_kotlin_continuation_indent_for_expression_bodies = false
ij_kotlin_continuation_indent_in_argument_lists = false
ij_kotlin_continuation_indent_in_elvis = false
ij_kotlin_continuation_indent_in_if_conditions = false
ij_kotlin_continuation_indent_in_parameter_lists = false
ij_kotlin_continuation_indent_in_supertype_lists = false
ij_kotlin_else_on_new_line = false
ij_kotlin_enum_constants_wrap = off
ij_kotlin_extends_list_wrap = normal
ij_kotlin_field_annotation_wrap = split_into_lines
ij_kotlin_finally_on_new_line = false
ij_kotlin_if_rparen_on_new_line = true
ij_kotlin_import_nested_classes = false
ij_kotlin_insert_whitespaces_in_simple_one_line_method = true
ij_kotlin_keep_blank_lines_before_right_brace = 0
ij_kotlin_keep_blank_lines_in_code = 1
ij_kotlin_keep_blank_lines_in_declarations = 1
ij_kotlin_keep_first_column_comment = true
ij_kotlin_keep_indents_on_empty_lines = false
ij_kotlin_keep_line_breaks = true
ij_kotlin_lbrace_on_next_line = false
ij_kotlin_line_comment_add_space = true
ij_kotlin_line_comment_at_first_column = false
ij_kotlin_method_annotation_wrap = split_into_lines
ij_kotlin_method_call_chain_wrap = normal
ij_kotlin_method_parameters_new_line_after_left_paren = true
ij_kotlin_method_parameters_right_paren_on_new_line = true
ij_kotlin_method_parameters_wrap = on_every_item
ij_kotlin_name_count_to_use_star_import = 2147483647
ij_kotlin_name_count_to_use_star_import_for_members = 2147483647
ij_kotlin_parameter_annotation_wrap = off
ij_kotlin_space_after_comma = true
ij_kotlin_space_after_extend_colon = true
ij_kotlin_space_after_type_colon = true
ij_kotlin_space_before_catch_parentheses = true
ij_kotlin_space_before_comma = false
ij_kotlin_space_before_extend_colon = true
ij_kotlin_space_before_for_parentheses = true
ij_kotlin_space_before_if_parentheses = true
ij_kotlin_space_before_lambda_arrow = true
ij_kotlin_space_before_type_colon = false
ij_kotlin_space_before_when_parentheses = true
ij_kotlin_space_before_while_parentheses = true
ij_kotlin_spaces_around_additive_operators = true
ij_kotlin_spaces_around_assignment_operators = true
ij_kotlin_spaces_around_equality_operators = true
ij_kotlin_spaces_around_function_type_arrow = true
ij_kotlin_spaces_around_logical_operators = true
ij_kotlin_spaces_around_multiplicative_operators = true
ij_kotlin_spaces_around_range = false
ij_kotlin_spaces_around_relational_operators = true
ij_kotlin_spaces_around_unary_operator = false
ij_kotlin_spaces_around_when_arrow = true
ij_kotlin_use_custom_formatting_for_modifiers = true
ij_kotlin_variable_annotation_wrap = off
ij_kotlin_while_on_new_line = false
ij_kotlin_wrap_elvis_expressions = 1
ij_kotlin_wrap_expression_body_functions = 1
ij_kotlin_wrap_first_method_in_call_chain = false

[**/src/{test/**.kt,main/**ContentStrings.kt,main/**ContentStringsLoader.kt}]
max_line_length = off
ij_visual_guides = none

[*.md]
trim_trailing_whitespace = false

[*.yml]
indent_size = 2
tab_width = 2
ij_continuation_indent_size = 2
```
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): [entrypoint.sh](https://github.com/ScaCap/action-ktlint/blob/master/entrypoint.sh) of [Ktlint GitHub Action](https://github.com/ScaCap/action-ktlint)
* Operating System and version: Ubuntu 22.04

