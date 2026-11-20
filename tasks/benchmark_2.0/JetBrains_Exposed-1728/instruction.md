Primary key constraint not created
Hello,
after upgrading exposed, I've found out that latest version is not generating `PRIMARY KEY` constraint for following definition:
```override val primaryKey = PrimaryKey(column)```

After digging into it, I have found out that the following version of table definition would not have Primary key defined:
```
object TestTableProp : IdTable<String>("test_table_prop") {
    val referenceNumber = varchar("reference_number", 30)
    override val id = referenceNumber.entityId()
    override val primaryKey = PrimaryKey(referenceNumber)
}
```
(results in this DDL `CREATE TABLE IF NOT EXISTS TEST_TABLE_PROP (REFERENCE_NUMBER VARCHAR(30) NOT NULL)`)

but following definition would have:
```
object TestTableId : IdTable<String>("test_table_id") {
    val referenceNumber = varchar("reference_number", 30)
    override val id = referenceNumber.entityId()
    override val primaryKey = PrimaryKey(id)
}
```
(results in this DDL: `CREATE TABLE IF NOT EXISTS TEST_TABLE_ID (REFERENCE_NUMBER VARCHAR(30) PRIMARY KEY)`)

Hint: the PrimaryKey is created from entity id, not the underlying column.

This issue first occured in version `0.33.1` (`0.32.1` was still creating PRIMARY KEY, albeit through different DDL `CREATE TABLE IF NOT EXISTS TEST_TABLE_PROP (REFERENCE_NUMBER VARCHAR(30) NOT NULL, CONSTRAINT pk_test_table_prop PRIMARY KEY (REFERENCE_NUMBER)`)

The issue is still present in current release `0.38.1`

Here you can find my repro repository with example test `PKTest`, available at `/reference-projects/exposed-primary-key-repro` at commit `ec66c5fe043d4ce20ea8355b4695999c91864d2c`:
in `build.gradle.kts` you can find different version of exposed ready to test

```
val exposedLatestVersion = "0.38.1"
val exposedWorkingVersion = "0.32.1"
val exposed1stFailingVersion = "0.33.1"
```
Thank you
Jiri
