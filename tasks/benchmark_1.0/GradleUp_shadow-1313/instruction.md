# Implement the issue(s) in GradleUp/shadow:

## Issue #884 https://github.com/GradleUp/shadow/issues/884: [Question] How to avoid string in classes being relocated

### Shadow Version
8.1.1
### Gradle Version
8.2
### Expected Behavior
Won't relocate string constant in class
### Actual Behavior
There is a constant in a Kotlin class from kotlin reflect. And I'm trying to relocate `kotlin` to `kotlin1910`. 
But the constant is remapping to `kotlin1910_builtins` which lead to `IllegalStateException: Resource not found in classpath: kotlin1910/kotlin1910.kotlin1910_builtins`
And ya, another constant that passing as `fqName` here is remapped, too.
If I using `relocate("kotlin/", "kotlin1910/")`. Then, the `kotlin/kotlin.kotlin_builtins` won't be `kotlin1910/kotlin.kotlin_builtins`
```kt
    const val BUILTINS_FILE_EXTENSION = "kotlin_builtins"

    fun getBuiltInsFilePath(fqName: FqName): String =
        fqName.asString().replace('.', '/') + "/" + getBuiltInsFileName(
            fqName
        )

    fun getBuiltInsFileName(fqName: FqName): String =
        shortName(fqName) + "." + BUILTINS_FILE_EXTENSION
```
### Gradle Build Script(s)
https://gist.github.com/SettingDust/344a40317d923c450d7cd9d321ccd472
```kts
    shadowJar {
        configurations = listOf(project.configurations.shadow.get())
        archiveClassifier = ""

        relocate("kotlin", "kotlin1910") {
            exclude("kotlinx/**")
            exclude("kotlin_builtins")
//            exclude("kotlin/reflect/jvm/internal/impl/serialization/deserialization/builtins/BuiltInSerializerProtocol")
            // @see https://youtrack.jetbrains.com/issue/KT-25709
//            exclude("*.kotlin_metadata")
//            exclude("*.kotlin_module")
//            exclude("*.kotlin_builtins")
        }
        relocate("kotlin1910_builtins", "kotlin_builtins")
        relocate("kotlinx.coroutines", "kotlinx.coroutines164")
        relocate("kotlinx.datetime", "kotlinx.datetime040")
        relocate("kotlinx.serialization", "kotlinx.serialization${kotlinxSerializationVersion.replace(".", "")}")

        relocate("org.jetbrains.exposed", "org.jetbrains.exposed${exposedVersion.replace(".", "")}")

        relocate("org.slf4j", "org.slf4j1725")

        relocate("net.kyori.adventure", "net.kyori.adventure${adventureVersion.replace(".", "")}")
        relocate("net.kyori.examination", "net.kyori.examination130")

        relocate("cloud.commandframework", "cloud.commandframework${cloudVersion.replace(".", "")}")

        relocate("dev.triumphteam.gui", "dev.triumphteam.gui312")

        relocate("io.leangen.geantyref", "io.leangen.geantyref1313")

        relocate("com.electronwill.nightconfig", "com.electronwill.nightconfig367")
        relocate("com.typesafe.config", "com.typesafe.config142")

        dependencies {
            exclude(dependency("org.jetbrains:annotations"))
            exclude(dependency("org.intellij.lang:annotations"))
            exclude(dependency("com.google.code.gson:gson"))
            exclude(dependency("org.yaml:snakeyaml"))
        }

        mergeServiceFiles()
    }
```
### Content of Shadow JAR (`jar tf <jar file>` - post link to GIST if too long)

