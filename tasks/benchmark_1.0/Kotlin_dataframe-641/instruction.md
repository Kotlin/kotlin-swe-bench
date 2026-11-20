# Implement the issue(s) in Kotlin/dataframe:

## Issue #640 https://github.com/Kotlin/dataframe/issues/640: Jupyter integration conflicts with variable type converters from other integrations.

# Steps to reproduce
Cell 1:
```kotlin
notebook.fieldsHandlersProcessor.register(
    // replacing all byte array variables with lists
    extension = FieldHandlerFactory.createUpdateHandler<ByteArray>(TypeDetection.COMPILE_TIME) { _, prop ->
        execute("${prop.name}.toList()").name
    },
)
```

Cell 2:
```kotlin
%use dataframe
val x = ByteArray(1)
```
Cell 3:
```kotlin
x.javaClass
```
# Expected output:
`class java.util.Collections$SingletonList` (that means that the byte array was transformed into a list as we asked it to in the fieldsHandlersProcessor).
You can also get this output by commenting out `%use dataframe`, restarting the kernel and rerunning the notebook.
# Actual output:
`class [B` (the byte array stayed byte array).

