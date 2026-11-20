# Implement the issue(s) in pinterest/ktlint:

## Issue: Imports only used in blocks which may not be formatted are reported as unused

Based on the comment: "I found a workaround as well which was to have at least one test that relied on the import and was NOT inside the formatter tags (thus meaning there was no unused import). For some reason this avoided the failure."

In ktlint `1.3.0` an import which is only used inside a block which is excluded from formatting, is reported as being an unused import. Removing the import results in code which can not be compiled.

```
import bar.Bar1
import bar.Bar2

fun foo123() {
    // @formatter:off
    // Assume that class Bar1 is defined in package. The import
    // for this class is reported as unused
    Bar1()
    // @formatter:on

    // Assume that class Bar1 is defined in package. The import
    //    // for this class is not reported as unused
    Bar2()
}
```
