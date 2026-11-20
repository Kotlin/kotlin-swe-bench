# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #4357 https://github.com/oss-review-toolkit/ort/issues/4357: Pattern glob expression excludes root file when applied on .ort.yml

Using Ort master

Applying the following pattern on the below tree results in excluding all but root build.gradle, forcing to add two patterns, one explicitly for root file.
```
 **/build.gradle inside 
```

```bash
testcode
├── app
│   └── build.gradle
└── build.gradle
```

