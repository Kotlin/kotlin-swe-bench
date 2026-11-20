Clikt 5.0.0 does not complain about missing argument when passing unknown option
Given this program:
```kotlin
package com.example

import com.github.ajalt.clikt.core.CliktCommand
import com.github.ajalt.clikt.core.main
import com.github.ajalt.clikt.parameters.arguments.argument

class Hello : CliktCommand() {
    val name by argument()

    override fun run() {
        echo("Hello $name!")
    }
}

fun main(args: Array<String>) = Hello().main(arrayOf("--foo"))
```

Clikt before 5.0.0 would output:

```
Usage: hello [<options>] <name>

Error: no such option --foo
Error: missing argument <name>
```

But Clikt 5.0.0 only outputs this:
```
Usage: hello [<options>] <name>

Error: no such option --foo
```

## Requirements

- If an unknown option is not defined on the command but on one of its subcommands, the error says so: `no such option --foo. hint: sub has an option --foo` for an option `--foo` of the subcommand `sub`.
