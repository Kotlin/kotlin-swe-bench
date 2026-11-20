# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Rewrite AutocryptHeaderParser and AutocryptGossipHeaderParser in Kotlin

Currently, `AutocryptHeaderParser` and `AutocryptGossipHeaderParser` are implemented in Java. For better Kotlin interoperability and idiomatic code, both classes should be converted to Kotlin with the following improvements:

1. Convert both classes from Java to Kotlin.
2. Keep each parser a singleton.
3. Use idiomatic Kotlin features:
  - `when `expressions for validation
  - `mapNotNull `instead of manual loops
  - Null safety (?., ?:, etc.)
  - Avoid redundant operations (e.g., Base64 decoding)
4. Logging should be consistent using a dedicated TAG constant.
5. `parseAllAutocryptHeaders`/`parseAllAutocryptGossipHeaders `should accept `Collection<String>` for flexibility.
6. Preserve existing functionality and validation rules.
7. Add` @VisibleForTesting` annotations to parsing functions where applicable. 

## Interface

The tests use these declarations:

- `com.fsck.k9.autocrypt.AutocryptHeaderParser` and `com.fsck.k9.autocrypt.AutocryptGossipHeaderParser` are `object`s
