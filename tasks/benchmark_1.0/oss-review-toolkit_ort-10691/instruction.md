# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #10685 https://github.com/oss-review-toolkit/ort/issues/10685: Regression due to new scan results merge logic

A regression has been created by https://github.com/oss-review-toolkit/ort/pull/10502 and the related PRs.

I trigger a scan with the following command line:

```shell
ort --stacktrace -c ort.yaml scan --project-scanners FossId --package-types PROJECT --output-dir=ort -i ort/analyzer-result.yml -o ort/
```

This instructs ORT to only run the scanner FossId for the project, and to not run any scanner for packages at all.

Unfortunately the scan fails with `Cannot merge ScannerRuns with different configurations`.

This is because of the `projectResults + packageResults` done at:
https://github.com/oss-review-toolkit/ort/blob/b92be4442607b7ba9cc8cc09ee0ca76a2e291941/scanner/src/main/kotlin/Scanner.kt#L136

The `packageResults.scanners` property is empty while `projectResults.scanners` isn't.

It is empty because of this logic:

https://github.com/oss-review-toolkit/ort/blob/b92be4442607b7ba9cc8cc09ee0ca76a2e291941/scanner/src/main/kotlin/Scanner.kt#L146-L149

A quick fix is to run `--stacktrace -c ort.yaml scan -s FossId --output-dir=ort -i ort/analyzer-result.yml -o ort/` instead.

@maennchen  FYI
