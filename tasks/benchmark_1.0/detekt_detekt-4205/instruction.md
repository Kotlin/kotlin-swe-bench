# Implement the issue(s) in detekt/detekt:

## Issue #4204 https://github.com/detekt/detekt/issues/4204: Interface methods vs ForbiddenMethodCall

It seems that `ForbiddenMethodCall` only complains about interface method usages if the thing it's called on is also _typed_ as that interface:

```yaml
style:
  ForbiddenMethodCall:
    active: true
    methods:
      - org.example.com.I.f
```

```kotlin
package org.example.com

interface I {
    fun f(): Unit
}

class C : I {
    override fun f() {}
}

fun foo() {
    var i: I = C()
    i.f() // detekt complains

    C().f() // detekt doesn't complain
}
```

I would like both usages to error, even if I don't explicitly forbid `org.example.com.C.f` as well. Listing every implementation of an interface doesn't seem practical.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.18.1
* Version of Gradle used (if applicable): 7.2

