# Implement the issue(s) in detekt/detekt:

## Issue #7622 https://github.com/detekt/detekt/issues/7622: Empty XML tags in baseline files

<!-- The bug you're experiencing might have already be reported! -->
<!-- Please search in the [issues](https://github.com/detekt/detekt/issues) before creating one. -->

## Expected Behavior
An empty XML tag should be self-closing, e.g. `<ManuallySuppressedIssues />`.

## Observed Behavior
In the generated baseline XML files, an XML tag with no body is simply left empty, e.g. `<ManuallySuppressedIssues></ManuallySuppressedIssues>`.

## Steps to Reproduce
<!-- Provide a link to a live example, or an unambiguous set of steps to -->
<!-- reproduce this bug. Include code to reproduce, if relevant -->
If you create any Kotlin module with a Detekt issue (e.g. a magic number) and run `./gradlew detektBaseline` on it, it'll generate the baseline file. You can see the empty-body `ManuallySuppressedIssues` tag for yourself. If there are no Detekt issues, the same will be true for the `CurrentIssues` tag.

Live examples in my repo: [One](https://github.com/JordanLongstaff/ArtemisAgent/blob/main/IAN/udp/detekt-baseline.xml) and [Two](https://github.com/JordanLongstaff/ArtemisAgent/blob/main/IAN/util/detekt-baseline.xml)

## Context
<!-- How has this issue affected you? What are you trying to accomplish? -->
<!-- Providing context helps us come up with a solution that is most useful in the real world -->
I am programming in Android Studio, which complains about the empty tags. These complaints show up as warnings in the Code Analysis view. If I replace the tags with self-closing tags, the warnings disappear; however, Detekt will still re-generate empty tags to replace them if the `detektBaseline` task is run again.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.23.7
* Version of Gradle used (if applicable): 8.6.0
* Gradle scan link (add `--scan` option when running the gradle task): N/A
* Operating System and version: N/A
* Link to your project (if it's a public repository): [here](https://github.com/JordanLongstaff/ArtemisAgent)

