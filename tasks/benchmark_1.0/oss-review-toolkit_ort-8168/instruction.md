# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #8167 https://github.com/oss-review-toolkit/ort/issues/8167: SwiftPM: Support `remoteSourceControl` dependencies which specify the branch (not version)

If one analyzes a `Package.swift` file such as [2], the analyzer result will contain a `Package` entry
for that dependency with `Identifier.version="unspecified"`. 

Ort's `SwiftPM` integration runs [1] which always does a dependency resolution which involves
figuring out the resolved revision. The execution of [1] either uses an existing lockfile, or creates
a lockfile in case of its absence. 

Change the implementation to always use the "resolved revision" from the `lockfile`.

[1] `swift package show-dependencies --format json`
[2] 
```
let package = Package(
    ...
    dependencies: [
        .package(url: "git@github.com:my-org/my-project.git", branch: "my-feature"),
    ]
   ...
)
```
