[v1] ABS function does not handle overflow for integer types
## Description
- Tracking issue for this previous code TODO -- Pinned file `partiql-spi/src/main/kotlin/org/partiql/spi/function/builtins/FnAbs.kt`:

```kotlin
// TODO: When negate a negative value, we need to consider overflow
internal val Fn_ABS__INT8__INT8 = Function.static(
    name = "abs",
    parameters = arrayOf(Parameter("value", PType.tinyint())),
    returns = PType.tinyint(),
) { args ->
    @Suppress("DEPRECATION")
    val value = args[0].byte
    if (value < 0) Datum.tinyint(value.times(-1).toByte()) else Datum.tinyint(value)
}

internal val Fn_ABS__INT16__INT16 = Function.static(
    name = "abs",
    returns = PType.smallint(),
    parameters = arrayOf(Parameter("value", PType.smallint())),
) { args ->
    val value = args[0].short
    if (value < 0) Datum.smallint(value.times(-1).toShort()) else Datum.smallint(value)
}

internal val Fn_ABS__INT32__INT32 = Function.static(
    name = "abs",
    returns = PType.integer(),
    parameters = arrayOf(Parameter("value", PType.integer())),
) { args ->
    val value = args[0].int
    Datum.integer(value.absoluteValue)
}

internal val Fn_ABS__INT64__INT64 = Function.static(
    name = "abs",
    returns = PType.bigint(),
    parameters = arrayOf(Parameter("value", PType.bigint())),
) { args ->
    val value = args[0].long
    Datum.bigint(value.absoluteValue)
}
```
- Per SQL1999 section 6.17:
```
9) If <absolute value expression> is specified, then let N be the value of the immediately contained
<numeric value expression>.
Case:
a) If N is the null value, then the result is the null value.
b) If N >= 0, then the result is N.
c) Otherwise, the result is -1 * N. If -1 * N is not representable by the result data type, then
an exception condition is raised: data exception — numeric value out of range
```
If an overflow occurs, we should throw a data exception error.

## To Reproduce
Steps to reproduce the behavior:
In the CLI run
```
ABS(CAST(-32768 AS SMALLINT))
```
^ outputs -32768

Similarly 
```
ABS(CAST(-2147483648 AS INT4))
```
^ outputs -2147483648

## Expected Behavior
- Expect a data exception error to be given
- Add tests for this behavior in conformance tests

## Additional Context
- Java version: 11
- PartiQL version: 1.0.0-rc4-SNAPSHOT
- Add any other context about the problem here.

## Requirements

- `TINYINT` is a supported type name in queries, e.g. `CAST(-128 AS TINYINT)`, so that `ABS` and arithmetic overflow on `TINYINT` values raise a data exception like the wider integer types
