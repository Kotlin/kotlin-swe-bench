# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #6873 https://github.com/oss-review-toolkit/ort/issues/6873: Only one package configuration per file is applied

I have a file in the package configuration directory which contained two configurations, i.e.
```
---
id: "Maven:dom4j:dom4j:1.6.1"
source_artifact_url: "https://repo.maven.apache.org/maven2/dom4j/dom4j/1.6.1/dom4j-1.6.1-sources.jar"
...
---
id: "Maven:dom4j:dom4j:1.6.1"
source_artifact_url: "<INTERNAL_ARTIFACTORY>/dom4j-1.6.1-sources.jar"
...
```
and the second one was ignored.

I would expect all configurations to be applied, or at least to be made aware that one has been ignored.
