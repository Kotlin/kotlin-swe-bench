# Implement the issue(s) in pinterest/ktlint:

## Issue #2344 https://github.com/pinterest/ktlint/issues/2344: Throw exception in Baseline load instead of printing log message

The ktlint-intelli-plugin loads the baseline file via function `loadBaseline(path: String)`. In case that an error occurs the `BaselineLoader` only prints a log message but does not throw an exception. As a result the plugin can not catch the error and is therefore not able to provide feedback to users. It would be nice in case the `BaselineLoader` can be configured to thrown an exception -or- print the log message.
