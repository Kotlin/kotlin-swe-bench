# Implement the issue(s) in pinterest/ktlint:

## Issue #2391 https://github.com/pinterest/ktlint/issues/2391: Error location for file must end with a new line should be the end of the file

## Expected Behavior
When ktlint reports a violation for standard:final-newline the reported error position should be the current last position in the file, because that is the position you need to be to fix the error

## Current Behavior
It currently reports the error on the first position in the file (row 1, column 1)

## Additional information
When I run ktlint I get clickable links that takes me to the point of the error where I can do something about it. For example, standard:trailing-comma-on-call-site takes me to the position where the comma would go. I can click the link and add the comma

The exception to this is standard:final-newline. I can't simply click the link and add a new line. I have to click the link, navigate to the end of the file, then add the new line.
