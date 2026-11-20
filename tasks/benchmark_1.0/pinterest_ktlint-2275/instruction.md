# Implement the issue(s) in pinterest/ktlint:

## Issue #2259 https://github.com/pinterest/ktlint/issues/2259: standard:function-naming on composables

Ktlint 1.0.0 warns that composable functions should be named lower case.

Composable functions should be named CamelCase and not lowerCase.

## Steps to reproduce

```kotlin
package yazio.debug.components

import androidx.compose.material.Text
import androidx.compose.runtime.Composable

@Composable
fun Composey() {
    Text("Hey")
}
```

1. create a file called `Composey.kt`
2. Download ktlint
3. call ./ktlint Composey.kt
4. Output: 
```
Composey.kt:7:5: Function name should start with a lowercase letter (except factory methods) and use camel case (standard:function-naming)

Summary error count (descending) by rule:
  standard:function-naming: 1
```
