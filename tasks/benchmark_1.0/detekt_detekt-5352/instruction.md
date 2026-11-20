# Implement the issue(s) in detekt/detekt:

## Issue #5338 https://github.com/detekt/detekt/issues/5338: UseDataClass flags the whole class body, not just the name

## Steps to Reproduce
```
class Violation(
	val rule: String,
	val category: String?,
	val message: String
) {
	// 
}
```

## Observed Behavior
![image](https://user-images.githubusercontent.com/2906988/191985055-a2413bd1-8a51-4026-a13e-84c21a92980f.png)

## Expected Behavior
Highlight only on class name or even the class keyword of it.
![image](https://user-images.githubusercontent.com/2906988/191986095-10880595-169f-446b-9c05-ce395737cc9b.png)

## Context
Pretty much the same as https://github.com/detekt/detekt/issues/5316, but a different rule.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.21.0
