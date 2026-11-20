# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #8801 https://github.com/oss-review-toolkit/ort/issues/8801: Bazel: Multiple registry URLs should be supported

The user can define multiple registry URLs in the `.bazelrc` file:

```
# Internal registry for custom packages
common --registry=file://%workspace%/tools/bazelbuild/registry/
# fall back to Bazel Central Registry
common --registry=https://raw.githubusercontent.com/bazelbuild/bazel-central-registry/main/
```

Unfortunately, the currently logic in the ORT Bazel package manager implementation only considers the first registry:
https://github.com/oss-review-toolkit/ort/blob/main/plugins/package-managers/bazel/src/main/kotlin/BazelModel.kt#L37

Consequently, with the above configuration, only the local registry URL is queried and standard packages are not found:
```
08:01:27.040 [DefaultDispatcher-worker-2] WARN  org.ossreviewtoolkit.plugins.packagemanagers.bazel.Bazel - Failed to fetch metadata for Bazel module 'rules_cc': IllegalArgumentException: Failed requirement.
```

The registry URLs should be probed one after each other to query the package metadata and the error should be outputted only if no registry has the package.

@haikoschol FYI
