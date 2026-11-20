# Implement the issue(s) in detekt/detekt:

## Issue #4749 https://github.com/detekt/detekt/issues/4749: UnnecessaryAbstractClass is not targeting class name

## Expected Behavior of the rule

UnnecessaryAbstractClass should target the name of the class

## Context
I just updated Detekt 1.19.0 to 1.20.0 and got this failure:
https://github.com/TWiStErRob/net.twisterrob.cinema/security/code-scanning/227

as you can see it's showing the `/**` as the "violation", but the real code is:
```
	/**
	 * Internal dependencies in this route group.
	 */
	@Module
	abstract class BackendModule {
```
it should be targeting this part:
```
	abstract class BackendModule {
                       -------------
```

![image](https://user-images.githubusercontent.com/2906988/164910247-930c8fdf-1dcd-40ad-9ae9-bd8268548bb9.png)
