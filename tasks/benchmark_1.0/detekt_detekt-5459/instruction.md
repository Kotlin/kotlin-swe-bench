# Implement the issue(s) in detekt/detekt:

## Issue #5341 https://github.com/detekt/detekt/issues/5341: ReturnCount false positive on lambda returns

## Context
According to the (default) configuration lambda returns should be excluded (be them labeled or not). It might be also to do with nesting, not sure.

## Expected Behavior
No flagging.

## Observed Behavior
Flagged with ReturnCount = 3 (there are 4 returns: 2 in lambdas, 2 outside lambdas, 2 labeled).

## Steps to Reproduce
```kotlin
    @Test fun `function with mix of labeled returns should not count lambdas`() {
        val code = """
            fun transform(flag: Boolean, data: List<List<String>>): String {
                if (data.isEmpty()) return "empty"
                val intermediateResult = data.flatMap { list ->
                    val partial = list.flatMap inner@{ str ->
                        if (flag) {
                            return@inner emptyList()
                        }
                        str.toCharArray().toList()
                    }
                    return@flatMap partial.subList(0, partial.size / 2)
                }
                return intermediateResult.toCharArray().concatToString()
            }
        """.trimIndent()

        val findings = ReturnCount(
            TestConfig(
                mapOf(
                    // https://github.com/detekt/detekt/blob/v1.21.0/detekt-core/src/main/resources/default-detekt-config.yml#L626-L632
                    MAX to "2",
                    EXCLUDE_LABELED to "false",
                    EXCLUDE_RETURN_FROM_LAMBDA to "true",
                    EXCLUDE_GUARD_CLAUSES to "false",
                )
            )
        ).compileAndLint(code)
        assertThat(findings).isEmpty()
    }
```

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.21.0
