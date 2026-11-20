# Implement the issue(s) in pinterest/ktlint:

## Issue #2852 https://github.com/pinterest/ktlint/issues/2852: Add configuration option to not wrap certain annotation on separate line

Room has [@MapColumn](https://developer.android.com/reference/androidx/room/MapColumn) that can be used to specify column that should be used as map key. `AnnotationOnSeparateLine` triggers for such code, and in my opinion it's false positive, because there is only one annotation for the type, which is allowed by the rule description.

## Steps to Reproduce
```kotlin
@Query("*SQL here*")
abstract fun getEntities(): Map<@MapColumn(columnName = "Id") Long, Entity>
```

## Your Environment
* Version of ktlint used: ktlint-ruleset-standart 0.50.0 through detekt 1.23.7
* Android Gradle Plugin: 8.7.0
* Room: 2.6.1
* Version of Gradle used (if applicable): 8.10.2
* Operating System and version: macOS 15.1

