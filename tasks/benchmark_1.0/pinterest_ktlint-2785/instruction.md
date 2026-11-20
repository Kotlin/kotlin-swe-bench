# Implement the issue(s) in pinterest/ktlint:

## Issue #2779 https://github.com/pinterest/ktlint/issues/2779: Local variables are treated as properties

## Expected Behavior
This code should not have any lint errors.
```kotlin
package my

import io.kotest.core.spec.style.StringSpec

@Suppress("LocalVariableName")
class SampleTest :
    StringSpec({
        val _test = "test"
        println(_test)
    })

@Suppress("LocalVariableName")
fun test() {
    val _test = "test"
    println(_test)
}
```

## Observed Behavior
This code reports the following lint errors:
```
Sandbox.kt:8:13 Backing property not allowed when 'private' modifier is missing (cannot be auto-corrected)
Sandbox.kt:8:13 Backing property is only allowed when a matching property or function exists (cannot be auto-corrected)
Sandbox.kt:14:9 Backing property not allowed when 'private' modifier is missing (cannot be auto-corrected)
Sandbox.kt:14:9 Backing property is only allowed when a matching property or function exists (cannot be auto-corrected)
```

it seems that local variables are treated as properties.

## Steps to Reproduce

## Your Environment
* Version of ktlint used: 1.3.1
* Relevant parts of the `.editorconfig` settings : no settings
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): Ktlint Gradle plugin 12.1.1
* Version of Gradle used (if applicable): 8.10
* Operating System and version: Windows 11

