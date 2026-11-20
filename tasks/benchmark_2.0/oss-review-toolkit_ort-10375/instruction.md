# Implement the issue(s) in oss-review-toolkit/ort:

## Issue: Provide a way to use version ranges for package-configurations

When scanning ORT as a package with ORT, one finding always shows up for this entry in `model/src/main/kotlin/config/ScannerConfiguration.kt`:

```kotlin
"LicenseRef-scancode-agpl-generic-additional-terms" to SpdxConstants.NOASSERTION,
```

This line is being detected as `AGPL-3.0-or-later` by scancode.

As this is not a license declaration, I am removing the finding with a package-configuration.
```yaml
package_configurations:
- id: "Maven:org.ossreviewtoolkit:model:51.0.0"
  source_artifact_url: "https://repo.maven.apache.org/maven2/org/ossreviewtoolkit/model/51.0.0/model-51.0.0-sources.jar"
  license_finding_curations:
  - path: "config/ScannerConfiguration.kt"
    start_lines: "64"
    line_count: 1
    detected_license: "AGPL-3.0-or-later"
    concluded_license: NONE
    reason: CODE
    comment: "..."
```

This works well, and I like that I can remove this single finding in exactly this version.

However, I have to do that weekly, because I want to update ORT as a dependency as soon as possible, and every update requires me to write a new package configuration.

The only workaround to remove this finding for good is to overwrite every detected license for `Maven:org.ossreviewtoolkit:model:`, by just setting a concluded license with a version range.
Using a concluded license has multiple unwanted side effects, which is why I don't want to use them.

What do you think about implementing a way to achieve the effect of a version range also for package-configurations?

## Requirements

- A package configuration whose `id` has a version range must not specify `vcs` or `source_artifact_url`; constructing one throws `IllegalArgumentException`.
