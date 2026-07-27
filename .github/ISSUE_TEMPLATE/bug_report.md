---
name: Bug report
about: Create a report to help us improve
title: ''
labels: ''
assignees: ''

---

<!--
Thanks for taking the time to file a bug!
For problems with a specific task, include the task directory name
(e.g. tasks/ankidroid_Anki-Android-18903).
-->

## Summary

<!-- A clear, concise description of what the bug is. -->

## Area

<!-- Which part of the benchmark is affected? Delete the ones that don't apply. -->

- A specific task (build / instruction / gold solution / tests)
- Scoring & reward (test.sh, expected_tests.json, junit_compare.py)
- Base image (bases/, build_bases.sh)
- Running the benchmark (Harbor CLI, agents)
- Documentation
- Other / not sure

## Affected task(s)

<!-- Task directory name(s), if the bug is task-specific. e.g. tasks/pinterest_ktlint-1234 -->

## Steps to reproduce

<!-- The exact commands you ran. Include the Harbor invocation if relevant. -->

```shell
1. scripts/build_bases.sh
2. harbor run -p tasks/pinterest_ktlint-1234 -a oracle
3. ...
```

## Expected behavior

<!-- What did you expect to happen? e.g. "Oracle agent should produce reward = 1" -->

## Actual behavior

<!-- What actually happened? Paste relevant error output or the contents of /logs/verifier/reward.txt. -->

```shell

```

## Environment

- OS:
- Docker version:
- Harbor version (`harbor --version`):
- Agent / model (if applicable):

## Additional context

<!-- Anything else that might help — logs, screenshots, links. -->
