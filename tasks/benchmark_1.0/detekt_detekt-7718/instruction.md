# Implement the issue(s) in detekt/detekt:

## Issue #7683 https://github.com/detekt/detekt/issues/7683: Populate partialFingerprints for results in SARIF reports

## Expected Behavior
`partialFingerprints` is populated for results in SARIF reports.

## Current Behavior
No fingerprint is generated.

## Context
SARIF report should provide all data that's "required" by GitHub.

This attribute is useful:
* [to avoid seeing duplicate alerts](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning#including-data-for-fingerprint-generation)
* [to accurately identify which results are the same across commits and branches](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning#result-object)
