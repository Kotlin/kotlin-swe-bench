# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #8082 https://github.com/oss-review-toolkit/ort/issues/8082: False `InvalidLicenseChoiceException` for complex expression

Expression `(MIT OR GPL-2.0-only) AND (MIT OR BSD-3-Clause OR GPL-1.0-or-later) AND (MIT OR BSD-3-Clause OR GPL-2.0-only)` doesn't allow choice of `MIT AND MIT AND MIT`, but throws the following exception:

`Caused by: org.ossreviewtoolkit.utils.spdx.InvalidLicenseChoiceException: MIT AND MIT AND MIT is not a valid choice for (MIT OR GPL-2.0-only) AND (MIT OR BSD-3-Clause OR GPL-1.0-or-later) AND (MIT OR BSD-3-Clause OR GPL-2.0-only). Valid choices are: [MIT AND BSD-3-Clause AND GPL-1.0-or-later, MIT AND BSD-3-Clause AND GPL-1.0-or-later AND GPL-2.0-only].`
