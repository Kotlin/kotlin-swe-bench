Warning log "Column is marked as not null, has default db value, but returns null" on left join
When running this Pinned file `exposed-tests/src/test/kotlin/org/jetbrains/exposed/sql/tests/shared/dml/JoinTests.kt`:

```kotlin
    @Test fun testNoWarningsOnLeftJoinRegression() {
```
, the warning log appears:

```
> Task :exposed-tests:h2_v2Test

org.jetbrains.exposed.sql.tests.shared.dml.JoinTests > testNoWarningsOnLeftJoinRegression STANDARD_OUT
    15:59:45,849  WARN Test worker Exposed:get:28 - Column JOINTABLE."dataCol" is marked as not null, has default db value, but returns null. Possible have to re-read it from DB.
    15:59:46,192  WARN Test worker Exposed:get:28 - Column JOINTABLE."dataCol" is marked as not null, has default db value, but returns null. Possible have to re-read it from DB.
    15:59:46,201  WARN Test worker Exposed:get:28 - Column jointable."dataCol" is marked as not null, has default db value, but returns null. Possible have to re-read it from DB.
    15:59:46,210  WARN Test worker Exposed:get:28 - Column jointable."dataCol" is marked as not null, has default db value, but returns null. Possible have to re-read it from DB.
    15:59:46,219  WARN Test worker Exposed:get:28 - Column jointable."dataCol" is marked as not null, has default db value, but returns null. Possible have to re-read it from DB.
    15:59:46,226  WARN Test worker Exposed:get:28 - Column JOINTABLE."dataCol" is marked as not null, has default db value, but returns null. Possible have to re-read it from DB.

org.jetbrains.exposed.sql.tests.shared.dml.JoinTests > testNoWarningsOnLeftJoinRegression PASSED
```

We saw this regression when upgrading exposed from 0.32.1 to 0.41.1.

As a workaround, we filtered out logs from exposed in our applications.