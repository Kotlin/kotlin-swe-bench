# Implement the issue(s) in pinterest/ktlint:

## Issue #2352 https://github.com/pinterest/ktlint/issues/2352: Naming rules should allow keywords to be wrapped between backticks

## Expected Behavior
Function name with backticks and short name should not throwing an error when formatting.


## Observed Behavior
Ktlint detect function name with backticks wrongly for example if I have method like in the following : 

```
fun `when`(): String {
    return ""
}
```
when I format the code it would throw an error like the following : 
 `[ktlint] /Users/dsetyawan/Documents/pAPI/spring-kotlin-demo/src/main/kotlin/com/example/springkotlindemo/SpringKotlinDemoApplication.kt:13:5: Function name should start with a lowercase letter (except factory methods) and use camel case (standard:function-naming)`



## Steps to Reproduce
Clone my example project : https://github.com/dimasadryantos/spring-kotlin-demo/tree/master
Run : `mvn clean compile` or `ktlint --format `


## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 0.51.0-FINAL
* Operating System and version: Mac
* Detailed in dependencies provided in pom.xml https://github.com/dimasadryantos/spring-kotlin-demo/blob/master/pom.xml

