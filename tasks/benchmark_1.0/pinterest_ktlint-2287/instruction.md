# Implement the issue(s) in pinterest/ktlint:

## Issue #2284 https://github.com/pinterest/ktlint/issues/2284: Enforce blank line before object declaration

Given code below:
```
interface I
object O
```

I would expect that rule `blank-line-before-declaration` would enforce a blank line before the object declaration:
```
interface I

object O
```
