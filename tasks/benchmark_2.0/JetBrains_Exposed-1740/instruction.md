Can't create BLOB column with default value
If I try to create a table with a `blob("...").default(...)` using a Table's `ddl` output, I get invalid SQL. This is because the blob column is emitted as `BLOB DEFAULT ? NOT NULL`. BlobColumnType apparently hardcodes this question mark: Pinned file `exposed-core/src/main/kotlin/org/jetbrains/exposed/sql/ColumnType.kt`:

```kotlin
    override fun nonNullValueToString(value: Any): String = "?"
```

Here's some sample code to demonstrate this with SQLite, which is what I'm using:

```kotlin
val TExample = object : Table("example") {
    val sample = blob("sample").default(ExposedBlob("test".encodeToByteArray()))
}
val db = Database.connect("jdbc:sqlite::memory:", "org.sqlite.JDBC")
println(transaction(db) { TExample.ddl })
```

Expected output:

`[CREATE TABLE IF NOT EXISTS example (sample BLOB DEFAULT x'74657374' NOT NULL)]`

Actual output:

`[CREATE TABLE IF NOT EXISTS example (sample BLOB DEFAULT ? NOT NULL)]`

----

More information on my use-case:

- I have an existing SQLite database and need to add a binary data column to an existing table that already has data in it.
- I'm trying to use `blob()` because the `binary()` column type seems unsuitable:
    1. SQLite doesn't have fixed-length columns, but Exposed requires me to set a length here. Documentation of `binary`: « This function is only supported by Oracle and PostgeSQL dialects, for the rest please specify a length. ». I guess could set a length, which SQLite will ignore.
    2. The generated SQL has a type of `VARBINARY(32)` which isn't an actual SQLite column type. SQLite doesn't care and I think just treats it as BLOB, but it looks weird, and I have a gut feeling that it will cause trouble later.
- Because there's existing data, and I want a non-null field, I need to provide a default (for the existing rows).
- SQLite does not have an `ALTER COLUMN` statement, so in my migration script I can't just create a nullable column, fill in some defaults, and then add the `NOT NULL` constraint.

I have workarounds I can use, but they're unpleasant; currently, my best option is to create a new table with the columns I want, copy the data over, delete the old table, and rename the new one. This is an annoying and error-prone script to write.

(I'm aware that some of the difficulty here is coming from SQLite, but I'd have different and larger problems if I switched to a different RDBMS.)

----

Ideally, I'd like Exposed to print the default as a hex-encoded string in the DDL (and I suppose other places blobs are used). Would that be a feasible change?