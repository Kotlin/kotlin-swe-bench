# Implement the issue(s) in detekt/detekt:

## Issue #5514 https://github.com/detekt/detekt/issues/5514: False positive at `UnnecessaryPartOfBinaryExpression`

I created a test to demostrate the bug:

```kotlin
    @Test
    fun `Don't raise issues with pair creation`() {
        val code = """
            fun foo() {
                1 to 1
            }
        """.trimIndent()

        val findings = UnnecessaryPartOfBinaryExpression().compileAndLint(code)
        assertThat(findings).hasSize(0)
    }
```

## Your Environment
* Version of detekt used: 1.22.0-RC3
