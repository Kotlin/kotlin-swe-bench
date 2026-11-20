# Implement the issue(s) in detekt/detekt:

## Issue #4918 https://github.com/detekt/detekt/issues/4918: False positive ExplicitCollectionElementAccessMethod on java.lang.reflect.Field.get


## Expected Behavior
No `ExplicitCollectionElementAccessMethod`. There's no `operator get` on `Field`.

## Observed Behavior
```
Prefer usage of the indexed access operator [] for map element access or insert methods. [ExplicitCollectionElementAccessMethod]
```


## Steps to Reproduce
```kotlin
fun reflect(f: Field) {
   val value = f.get(null) // access static field
   println(value)
}
```

## Context
I'm enabling all the checks there exists in Detekt. And I noticed this false positive. I think it's a false positive because we shouldn't encourage `[]` notation on reflection classes as they're not collections. Reflection is confusing enough already without throwing unnecessary syntactic sugar in the mix.

Note: to get ahead of conversations on exceptions to this rule: java.lang.reflect is in the standard library of Kotlin-JVM, and it is not Kotlin-friendly. The synthetic `get` from the public method is an accident.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.20.0
* Version of Gradle used (if applicable): 7.4.2
* Gradle scan link (add `--scan` option when running the gradle task):
* Operating System and version: Windows 10
* Link to your project (if it's a public repository): Detekt is not set up fully yet. https://github.com/TWiStErRob/net.twisterrob.sun/blob/92c3939c4f88ec0165be1bd9f4005531acfcad3e/component/paparazzi/src/main/java/net/twisterrob/sun/test/screenshots/ActivityClientSingletonHack.kt#L46-L50 is the offending file.


---

## Issue #3609 https://github.com/detekt/detekt/issues/3609: Correct ExplicitCollectionElementAccessMethod rule

## Expected Behavior of the rule
The rule picks up all usage of `get` and `set` indexed access operators, as well as calls to `put` on any class that implements `MutableMap` or `AbstractMap`.

## Context
Right now the rule only picks up usage of `get` on `Map`, `MutableMap`, `List`, `MutableList`, `AbstractList` and `AbstractMap`, and `put` on `MutableMap` and `AbstractMap`.

`set` is not detected at all.

The rule is unfortunately named in a way that it only applies to collection elements, though you can technically (though shouldn't) override the `get` and `set` operators on any class. But this is probably OK to leave as is.
