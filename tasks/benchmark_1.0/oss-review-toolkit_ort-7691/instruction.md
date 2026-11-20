# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #7679 https://github.com/oss-review-toolkit/ort/issues/7679: Poetry: analyse fails if dev group dependency isn't present

ORT fails to analyse a python project using poetry package manager that don't defines dev dependency group.

```
20:30:13.172 [DefaultDispatcher-worker-1] ERROR java.lang.Object - Poetry failed to resolve dependencies for path 'poetry.lock': IOException: Running 'poetry export --without-hashes --format=requirements.txt --only=dev' in '/project' failed with exit code 1:

Group(s) not found: dev (via --only)
```

Slack [thread](https://ort-talk.slack.com/archives/C9NNJ54B1/p1696974335286449)
