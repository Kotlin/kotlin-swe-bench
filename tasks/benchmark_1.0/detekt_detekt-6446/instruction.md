# Implement the issue(s) in detekt/detekt:

## Issue #6445 https://github.com/detekt/detekt/issues/6445: False negative `IgnoredReturnValue` with scope functions

## Steps to Reproduce
```kotlin
fun test(db: Database, sql: String) {
    db.insert(sql) // Detected

    with(db) {
        insert(sql) // Should be detected
    }

    db.let {
        it.insert(sql) // Should be detected
    }

    db.run {
        insert(sql) // Should be detected
    }
}

annotation class CheckResult

class Database {
    @CheckResult
    fun insert(query: String): Insert = TODO()
}

class Insert {
    fun execute(): Int = TODO()
}
```

## Your Environment
* Version of detekt used: 1.23.1

