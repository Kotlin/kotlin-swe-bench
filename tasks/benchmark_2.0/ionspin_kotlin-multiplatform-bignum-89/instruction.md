BigInteger.bitAt does not work correctly
**Describe the bug**
BigInteger.bitAt always return "false" for indices other than 0.
Example:
BigInteger(2).bitAt(1) should return "true", but returns "false".

Looks like the comparison in BigInteger63Arithmetic.bitAt could be the issue. After looking at the code I think the last line should assert that the result of the operation is _!= 0_ instead of _== 1_.
In the example above, the value is 2, for bit 2 it would be 4 (if set in _word_) and so on.

**To Reproduce**
BigInteger(2).bitAt(1) == true

**Expected behavior**
The method should work for all indices.

**Platform**
JVM
did not test with other platforms

Notice the issue with versions 0.1.4 and 0.1.5.

## Interface

The tests use these declarations:

- `fun ULong.toBigInteger(): BigInteger`, top-level in `com.ionspin.kotlin.bignum.integer`
