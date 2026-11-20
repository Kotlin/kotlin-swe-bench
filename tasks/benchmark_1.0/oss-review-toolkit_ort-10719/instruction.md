# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #10673 https://github.com/oss-review-toolkit/ort/issues/10673: Package configuration license finding curation isn't working when using version ranges

When we try to use ranges to curate license findings via package config, the curations aren't applied. Using the exact version always works. We tried different formats, and couldn't make any of them work; even omitting the version yields no results.

We used the [Apache Ivy](https://ant.apache.org/ivy/history/2.5.0/settings/version-matchers.html) version formatting as per [docs](https://oss-review-toolkit.org/ort/docs/configuration/package-configurations), and tried with the formats from the [PackageConfigurationTest unit test](https://github.com/oss-review-toolkit/ort/blob/309c5a37c291ce861139493e3797d9df2d6daa8a/model/src/test/kotlin/config/PackageConfigurationTest.kt#L141), which also doesn't work.

For e.g., we used a range in the id, `id: "Maven:jakarta.annotation:jakarta.annotation-api:[2.0.0,)"`, together with `source_code_origin: ARTIFACT` without specifying the `source_artifact_url`:

```
id: "Maven:jakarta.annotation:jakarta.annotation-api:[2.0.0,)"
source_code_origin: ARTIFACT
license_finding_curations:
  - path: "**/LICENSE.md"
    start_lines: "281"
    line_count: 336
    detected_license: "GPL-2.0-only"
    reason: "INCORRECT"
    comment: "The file doesn't contain GPL-2.0-only statement, but GPL-2.0-only WITH Classpath-exception-2.0"
    concluded_license: "GPL-2.0-only WITH Classpath-exception-2.0"
```

### To Reproduce

Steps to reproduce the behavior:

1. Create a package config license curation for any reported issue, using the exact version
2. Run the evaluator
3. Run the reporter
4. Check the scan report - curation gets done
5. Put any format of version range in the ID
6. Run the evaluator
7. Run the reporter
8. Check the scan report - no curation gets done

### Expected behavior

It's expected that the curation was applied when the version range is used as well.

### Environment

* ORT version: 64.0.0
* Java version: 17
* OS: Linux on Docker

