# Implement the issue(s) in pinterest/ktlint:

## Issue #2383 https://github.com/pinterest/ktlint/issues/2383: Classes that import junit.framework are not considered a test case 

<!-- The enhancement you want to propose might have already been reported!
Please search in the [issues](https://github.com/pinterest/ktlint/issues) before creating one. -->
## Expected Behavior
<!-- Tell us what should be improved/added/changed/removed -->
<!-- If relevant, provide a link to the relevant section in the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) or [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide).  -->
With the promotion of function naming I now see errors like "Function name should start with a lowercase letter (except factory methods) and use camel case" even though this is within a test. In my test case, junit (junit.framework and org.junit) is used for tests. I found ktlint does not recognized as test file with "junit.framework" So, expected behavior would be that kind of test file recognized as test file. 


<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

## Current Behavior
<!-- Tell us current state of the API -->
The following test case is considered to have an invalid function name. According to [Function naming](https://pinterest.github.io/ktlint/1.0.1/rules/standard/#function-naming) tests are considered to have an import of org.junit, org.testng or kotlin.test, but this example doesn't have any. 

```
package some.package

import junit.framework.TestCase

class ArgumentParserTest : TestCase() {
    fun testParser_filterKeyVelye() {
    }
}
```

## Additional information
* Current version of ktlint: 1.0.1

