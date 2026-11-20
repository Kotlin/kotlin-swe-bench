# Kotlin Benchmark 2.0

A benchmark for evaluating coding agents on real Kotlin software-engineering tasks. It covers tasks across Android, server-side Kotlin, and Kotlin Multiplatform projects. This 2.0 iteration includes harder tasks that require multi-step debugging and changes across multiple files. 
A snapshot of the previous version (Benchmark 1.0) is preserved on the [`kotlinai/benchmark-1.0`](https://github.com/Kotlin/kotlin-swe-bench/tree/kotlinai/benchmark-1.0) branch.

## What the benchmark measures
An agent receives a repository at a fixed base revision and a natural-language task description, and produces a patch. A verifier then runs tests against that patch. A task is resolved when the tests pass, and the primary metric is the resolution rate across tasks. The benchmark evaluates a complete agent setup, _i.e.,_ model, agent harness, reasoning effort, and time limit, not just a model.

## Dataset
The dataset consists of 100 tasks. 70 tasks are mined from the open-source repositories, 30 - from closed-source internal JetBrains projects. The closed-source tasks are not published.

| Repository | License | Open tasks |
|---|---|---:|
| [thunderbird/thunderbird-android](https://github.com/thunderbird/thunderbird-android) | Apache-2.0 | 12 |
| [wordpress-mobile/WordPress-Android](https://github.com/wordpress-mobile/WordPress-Android) | GPL-2.0 | 12 |
| [ankidroid/Anki-Android](https://github.com/ankidroid/Anki-Android) | GPL-3.0 | 6 |
| [bkbnio/kompendium](https://github.com/bkbnio/kompendium) | MIT | 3 |
| [detekt/detekt](https://github.com/detekt/detekt) | Apache-2.0 | 3 |
| [graphql-java-kickstart/graphql-java-tools](https://github.com/graphql-java-kickstart/graphql-java-tools) | MIT | 3 |
| [JetBrains/Exposed](https://github.com/JetBrains/Exposed) | Apache-2.0 | 3 |
| [partiql/partiql-lang-kotlin](https://github.com/partiql/partiql-lang-kotlin) | Apache-2.0 | 3 |
| [tipsy/javalin](https://github.com/tipsy/javalin) | Apache-2.0 | 3 |
| [dzikoysk/reposilite](https://github.com/dzikoysk/reposilite) | Apache-2.0 | 2 |
| [Hannah-Sten/TeXiFy-IDEA](https://github.com/Hannah-Sten/TeXiFy-IDEA) | MIT | 2 |
| [holunda-io/camunda-bpm-taskpool](https://github.com/holunda-io/camunda-bpm-taskpool) | Apache-2.0 | 2 |
| [Kotlin/dataframe](https://github.com/Kotlin/dataframe) | Apache-2.0 | 2 |
| [orchestr7/ktoml](https://github.com/orchestr7/ktoml) | MIT | 2 |
| [pinterest/ktlint](https://github.com/pinterest/ktlint) | MIT | 2 |
| [ajalt/clikt](https://github.com/ajalt/clikt) | Apache-2.0 | 1 |
| [ajalt/mordant](https://github.com/ajalt/mordant) | Apache-2.0 | 1 |
| [andregasser/bigbone](https://github.com/andregasser/bigbone) | MIT | 1 |
| [arkivanov/Decompose](https://github.com/arkivanov/Decompose) | Apache-2.0 | 1 |
| [badoo/Reaktive](https://github.com/badoo/Reaktive) | Apache-2.0 | 1 |
| [cashapp/redwood](https://github.com/cashapp/redwood) | Apache-2.0 | 1 |
| [ionspin/kotlin-multiplatform-bignum](https://github.com/ionspin/kotlin-multiplatform-bignum) | Apache-2.0 | 1 |
| [oss-review-toolkit/ort](https://github.com/oss-review-toolkit/ort) | Apache-2.0 | 1 |
| [societe-generale/github-crawler](https://github.com/societe-generale/github-crawler) | Apache-2.0 | 1 |
| [supabase-community/supabase-kt](https://github.com/supabase-community/supabase-kt) | MIT | 1 |
| **Total** | | **70** |

## How tasks are evaluated

A task contains an instruction, an environment, a reference solution, and a verifier. Each evaluated open task captures a base revision, a reference solution patch, a test patch, and a natural-language task description. Task metadata identifies the source repository and code change; an issue link is included where available.
For the open-source tasks, the verifier runs in a separate environment. It reconstructs the agent's changes from the collected patch, applies the test patch, runs the configured tests, and collects fresh JUnit reports. The reports are compared with `expected_tests.json`; a passing reward is recorded only when the expected test outcomes are satisfied.

The test comparison includes transitions such as:
- **Fail to pass:** a test that failed before the fix passes afterward.
- **Pass to pass:** an existing passing test continues to pass.
- **Skipped or new to pass:** a relevant skipped or newly introduced test passes.

The open-task verifier initializes the reward to `0`. If it cannot restore the agent's changes, it removes the reward and exits with an error. A non-zero test-command exit does not by itself determine the reward; the verifier evaluates the collected reports.
Task results include a reward of `1` for resolved and `0` for not resolved. Infrastructure failures and missing rewards should be reported separately from verified failures. Closed tasks use task-specific test scripts and a different verifier layout.

The published results were produced with an internal Harbor-based harness on Kubernetes (three runs per configuration, 30-minute per-task limit, no agent network, web search disabled), which reconstructs the agent's changes in a separate clean environment before verifying. The published bundle is the exact evaluated material.

## Task layout

The evaluated open tasks use the Harbor task format. An open task in the evaluation bundle has the following layout:
```text
tasks/<owner>_<repository>-<number>/
├── task.toml
├── instruction.md
├── environment/
│   ├── Dockerfile
│   └── seal_git_history.sh
├── solution/
│   ├── fix.patch
│   └── solve.sh
└── tests/
    ├── test.patch
    ├── test.sh
    ├── expected_tests.json
    ├── kotlin_logs_collector.sh
    └── junit_compare.py
```

Some tasks also ship `environment/debug/` (from-source image recipes), `environment/task-assets/` (instruction images), and extra verifier support files under `tests/`.

`task.toml` records task configuration and source provenance, including the repository and code-change URLs. Issue URLs are included where available. The environment uses a prebuilt task image and seals Git history; the solution directory contains the reference patch used by the oracle, and the test directory contains the verifier.

In the evaluated open-task configurations, the agent operates in `no-network` mode, while the verifier and environment phases use `public` network mode. The task's `task.toml` file specifies the configured timeouts, resources, and network policy. Consequently, the harness setup also disables the web search tool and includes a brief instruction indicating that network access is disabled, thereby preventing repeated request errors during task resolution. These measures are intended to prevent reward hacking by the agents.

## License
See LICENSE. Tasks are derived from open-source repositories; each upstream project retains its own license. The SPDX identifier of the source project's license is recorded in the `license` field under `[metadata.source]` in every task's `task.toml` (see the table above for the per-repository breakdown).
