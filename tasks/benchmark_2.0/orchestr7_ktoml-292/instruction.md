Support for quoted keys and values with special symbols
`String.validateSymbols()` in `ktoml-core-jvm:0.5.0` performs an extra `trimQuotes()`, which prevents assignment to quoted keys containing special symbols.

For example, consider the following line of valid (per language docs) TOML:

```
"androidx.activity:activity-compose" = {}
```

This yields the following exception:

```
ParseException: <...>: Not able to parse the key: ["androidx.activity:activity-compose"] as it contains invalid symbols.
```

## Requirements

- This holds for keys quoted with `"` or `'`, and a quoted key may also contain `=`: `'qwe=123' = 'bar'`
- Whitespace around the dots of a dotted key is ignored: `name .   value = "banana"`
