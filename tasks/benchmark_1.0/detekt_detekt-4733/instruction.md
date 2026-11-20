# Implement the issue(s) in detekt/detekt:

## Issue #4730 https://github.com/detekt/detekt/issues/4730: False positive on `VarCouldBeVal` in generic classes

<!-- The bug you're experiencing might have already be reported! -->
<!-- Please search in the [issues](https://github.com/detekt/detekt/issues) before creating one. -->

## Observed Behavior
`Expecting empty but was: [CodeSmell(issue=Issue(id='VarCouldBeVal', severity=Maintainability, debt=5min), entity=Entity(name=a, signature=Test.kt$A$private var a = 1, location=Location(source=2:5, text=17:34, file=Test.kt, filePath=FilePath(absolutePath=Test.kt, basePath=null, relativePath=null)), ktElement=PROPERTY), message=Variable 'a' could be val., metrics=[], references=[], severity=WARNING, id='VarCouldBeVal')]`

## Steps to Reproduce
```kt
        @Test
        fun `does not report variables that are re-assigned in generic class with receiver`() {
            val code = """
                class A<T> {
                    private var a = 1
                    
                    fun foo(): A<T> = apply {
                        a = 2
                    }
                }
            """.trimIndent()
            assertThat(subject.compileAndLintWithContext(env, code)).isEmpty()
        }
```

## Context
<!-- How has this issue affected you? What are you trying to accomplish? -->
<!-- Providing context helps us come up with a solution that is most useful in the real world -->
Interestingly, declaring the return type as generic and the fact that it's in a receiver block are important to getting the lint error to report.
```kt
class A<T> {
    private var a = 1

    // fun foo() = apply { a = 2 }         // no error
    // fun foo2(): A = apply { a = 3 }     // no error

    fun foo3(): A<T> = apply { a = 4 }  // error

    // no error
    /*
    fun foo4(): A<T> {
        a = 5
        return this
    }
    */
}
```

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.20.0
* Link to your project (if it's a public repository): https://github.com/aws/aws-toolkit-jetbrains/blob/7853ede42bb44a585b786b0ad49c81d27d24c9cc/jetbrains-core/src/software/aws/toolkits/jetbrains/ui/ResourceSelector.kt#L232-L267

