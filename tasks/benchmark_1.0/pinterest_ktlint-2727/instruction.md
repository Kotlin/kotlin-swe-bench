# Implement the issue(s) in pinterest/ktlint:

## Issue #2726 https://github.com/pinterest/ktlint/issues/2726: Format was not able to resolve all violations which (theoretically) can be autocorrected

In case a file only contains lint violations which are suppressed using the baseline, then ktlint `1.3.0` keeps reporting that format was not able to resolve all violations which (theoretically) can be autocorrected.

Assume that the file `Foo.kt` contains code below:
```
val foo = foo(
    "foo"
)
```
and `.editorconfig`:
```
root = true

[*.{kt,kts}]
ktlint_code_style = ktlint_official
ktlint_standard = enabled
ktlint_experimental = enabled
```

Run command `rm baseline.xml && ktlint **/Foo.kt --baseline=baseline.xml` to delete the existing `baseline.xml` and recreate a new `baseline.xml` file. The created `baseline.xml` file looks like:
```
<?xml version="1.0" encoding="utf-8"?>
<baseline version="1.0">
    <file name="src/main/kotlin/Foo.kt">
        <error line="1" column="11" source="standard:multiline-expression-wrapping" />
        <error line="2" column="10" source="standard:trailing-comma-on-call-site" />
    </file>
</baseline>
```

Running ` ktlint-dev **/Foo.kt --baseline=baseline.xml -F --relative` results in:
```
11:00:10.368 [pool-1-thread-1] WARN com.pinterest.ktlint.rule.engine.internal.CodeFormatter -- Format was not able to resolve all violations which (theoretically) can be autocorrected in file /###/src/main/kotlin/Foo.kt in 3 consecutive runs of format.
```
