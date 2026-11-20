# Implement the issue(s) in pinterest/ktlint:

## Issue #1071 https://github.com/pinterest/ktlint/issues/1071: Prompt users to try auto-correct

## Expected Behavior
When there are detected issues that are auto correctible, prompt the users to try `-F`.
I got questions from multiple devs who are new to Kotlin. They didn't know this option exists and always seem to not understand specific rule violations. For example, we came to [this stackoverflow question](https://stackoverflow.com/questions/729692/why-should-text-files-end-with-a-newline) when trying to understand how to fix FinalNewLine.

## Current Behavior
The current cli only reports those detected issues.

## Additional information
* Current version of ktlint: 0.40.0

