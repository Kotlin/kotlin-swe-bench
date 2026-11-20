# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #5668 https://github.com/oss-review-toolkit/ort/issues/5668: Record where curations came from

Analyzer results that contain curations should record the provider a curation originates from. Maybe just the provider's (class) name would be enough, but e.g. for `CompositePackageCurationProvider` the real underlying provider should be recorded, and e.g. for `FilePackageCurationProvider` maybe some more details like the (relative) directory path would make sense.

Recording the origin / source of a curation improves transparency and helps with debugging metadata issues.
