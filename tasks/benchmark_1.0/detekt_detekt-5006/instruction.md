# Implement the issue(s) in detekt/detekt:

## Issue #4920 https://github.com/detekt/detekt/issues/4920: Potential false positives on BooleanPropertyNaming with constants

## Context
BooleanPropertyNaming considers naming of properties, while technically these `const val`s are properties, they also have a different naming convention and I have a feeling they rarely start with `IS_` prefix.

## Expected Behavior of the rule
I propose to exclude `const` from this check fully.

```kotlin
object WidgetPreferences { // Detekt: or a companion object

	/**
	 * User selection of whether to show the part of day or not.
	 *
	 * *type*: [Boolean]
	 * *description*: true=show
	 * *default*: [DEFAULT_SHOW_PART_OF_DAY]
	 */
	const val PREF_SHOW_PART_OF_DAY = "showPartOfDay"
	const val DEFAULT_SHOW_PART_OF_DAY = true // Detekt: BooleanPropertyNaming shouldn't be reported
}
```

