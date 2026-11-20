# Implement the issue(s) in pinterest/ktlint:

## Issue #1940 https://github.com/pinterest/ktlint/issues/1940: Wrap binary expression before wrapping arguments of function call 

Given code below with `max-line-length` set to `140`:
```
fun foo() {
    if ((hasName(name) || absenceIsNull(descriptor, index)) && (!json.configuration.coerceInputValues || !coerceInputValue(descriptor, index, name)))
        return index
}
```

IntelliJ formats this as:
```
fun foo() {
    if ((hasName(name) || absenceIsNull(
            descriptor,
            index
        )) && (!json.configuration.coerceInputValues || !coerceInputValue(descriptor, index, name))
    )
        return index
}
```

Ktlint `0.48.2` formats it as:
```
fun foo() {
    if ((hasName(name) || absenceIsNull(descriptor, index)) && (!json.configuration.coerceInputValues || !coerceInputValue(
            descriptor,
            index,
            name
        ))) {
        return index
    }
}
```

Both are not optimal. First the binary expression should be split per part of the expression. It should ideally result in:
```
fun foo() {
    if ((hasName(name) || absenceIsNull(descriptor, index)) &&
        (!json.configuration.coerceInputValues || !coerceInputValue(descriptor, index, name))
    ) {
        return index
    }
}
```

