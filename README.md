# Kotlin SWE-bench

A Kotlin software-engineering benchmark for evaluating coding agents.

The benchmark is built on the [Multi-SWE-bench](https://github.com/multi-swe-bench) methodology, extended
with Kotlin support. It is packaged in the **Harbor task format** — every task is a self-contained
directory with its own reproducible Docker environment, instruction, gold solution, and test verifier.

## Dataset

106 tasks across nine open-source Kotlin repositories:

| Repository | License | Tasks |
| :--- | :--- | ---: |
| [pinterest/ktlint](https://github.com/pinterest/ktlint) | MIT | 43 |
| [detekt/detekt](https://github.com/detekt/detekt) | Apache-2.0 | 28 |
| [oss-review-toolkit/ort](https://github.com/oss-review-toolkit/ort) | Apache-2.0 | 12 |
| [Hannah-Sten/TeXiFy-IDEA](https://github.com/Hannah-Sten/TeXiFy-IDEA) | MIT | 8 |
| [ankidroid/Anki-Android](https://github.com/ankidroid/Anki-Android) | GPL-3.0 | 6 |
| [Kotlin/dataframe](https://github.com/Kotlin/dataframe) | Apache-2.0 | 5 |
| [square/okhttp](https://github.com/square/okhttp) | Apache-2.0 | 2 |
| [GradleUp/shadow](https://github.com/GradleUp/shadow) | Apache-2.0 | 1 |
| [linreal/cascade-editor](https://github.com/linreal/cascade-editor) | MIT | 1 |
| **Total** | | **106** |

For every task the dataset captures:

- the **base commit** (repository state before the change),
- the human-written **gold solution** patch,
- the **regression tests** that define the expected behavior,
- the natural-language **issue description**.

## Task structure (Harbor format)

Each task lives under `tasks/<owner>_<repo>-<pr_number>/` and is fully self-contained:

```
tasks/ankidroid_Anki-Android-18903/
├── task.toml                     # Task metadata + run config (timeouts, resources, network policy)
├── instruction.md               # The issue/PR description handed to the agent
├── environment/                 # Docker build context for the task image
│   ├── Dockerfile               #   FROM a shared local base (kotlin-bench/<repo>:<base-tag>);
│   │                            #   runs prepare.sh + agent tooling, then seals Git history
│   ├── prepare.sh               #   checks out the base commit, warms the build cache
│   ├── check_git_changes.sh     #   asserts a clean working tree
│   ├── seal_git_history.sh      #   leaves only the base commit reachable (removes the upstream fix)
│   └── exclude-flaky-tests.*    #   (some tasks) Gradle init script that skips flaky tests
├── solution/
│   ├── fix.patch                # The gold (reference) solution
│   └── solve.sh                 # Applies fix.patch — the "oracle" run
└── tests/
    ├── test.patch               # Adds/updates the hidden regression tests
    ├── test.sh                  # Applies test.patch, runs the suite, writes the reward
    ├── expected_tests.json      # Expected test transitions (f2p / p2p / s2p / n2p)
    ├── kotlin_logs_collector.sh # Collects JUnit XML from Gradle build output
    └── junit_compare.py         # Parses JUnit XML and computes the reward
```

### `task.toml`

```toml
[metadata.source]      # provenance: repo, PR/issue URLs, upstream SPDX license, base info
[verifier]             # verification timeout;      network_mode = "public"
[agent]                # agent solving timeout;     network_mode = "allowlist" + allowed_hosts
[environment]          # build timeout, cpus, memory_mb; network_mode = "public"
```

`[metadata.source]` records a `license` marker holding the SPDX identifier of the
upstream repository the task is derived from (e.g. `license = "Apache-2.0"`), so each
task carries the provenance of its source project's license.

**Network policy.** Tasks no longer set `allow_internet`. Instead the agent runs under
`network_mode = "allowlist"` with a fixed `allowed_hosts` list (Maven Central, the Gradle
plugin/services hosts, Google Maven, JetBrains, and documentation mirrors) so builds can still
resolve dependencies, while `github.com` and the open web stay unreachable — an agent cannot
download the published upstream fix. The verifier and environment phases use `network_mode =
"public"` so dependency resolution during build/verification is unrestricted. This policy is
honored by the Harbor runner; confirm your runner version applies `allowed_hosts` before relying
on it (see **Security hardening** below).

### Scoring

`tests/test.sh` runs inside the task container after the agent's patch is applied. It is
**fail-closed**: it writes reward `0` to `/logs/verifier/reward.txt` before doing anything, and a
reward of `1` is only ever produced by `junit_compare.py` validating freshly generated reports.
Concretely it:

1. writes the default reward `0` and clears any previous verifier logs,
2. applies `test.patch` to inject the regression tests — **aborting with reward `0` if it does not apply**,
3. deletes any stale `*/build/test-results/*/TEST*.xml` so only this run's reports can count,
4. runs the Gradle test suite (a non-zero Gradle exit does **not** by itself change the reward),
5. collects JUnit XML via `kotlin_logs_collector.sh`, and
6. compares the results against `expected_tests.json` with `junit_compare.py`, which writes the
   final reward (`1` = resolved, `0` = not resolved).

There is **no exit-code fallback**: a build that crashes or produces no reports scores `0`, never
`1`. Behavior is preserved for legitimate solutions — a run whose fresh reports show every expected
test passing still scores `1` even if Gradle exited non-zero.

Tests are classified by their status transition between the unpatched and patched runs:

- **f2p** — fail → pass (the bug being fixed)
- **p2p** — pass → pass (no regressions in already-passing tests)
- **s2p** / **n2p** — skip/new → pass

A task passes only when every expected test lands in its correct category.

## Base images

Task images are not self-contained from JDK up — they build `FROM` a shared base image that
bundles the JDK, any SDKs, and a clone of the upstream repo. A repository can have **several**
base variants on different JDKs (e.g. `kotlin-bench/pinterest_ktlint:base` on JDK 21 and
`kotlin-bench/pinterest_ktlint:base-JDK-17` on JDK 17); the variants differ in more than the JDK
line, so each has its own recipe. Base images need to be built once
before running any task:

```bash
scripts/build_bases.sh            # build every base listed in bases/manifest (skips existing)
scripts/build_bases.sh --rebuild  # force a rebuild
```

Each base recipe lives in `bases/<repo>/Dockerfile.<base-tag>` and is built as
`kotlin-bench/<repo>:<base-tag>`; `bases/manifest` lists all of them. Each task's
`environment/Dockerfile` selects the variant it needs via its `FROM` line.

## Security hardening

The tasks are hardened so that agents cannot earn undeserved rewards. Three controls live in the
task files, and one must be enforced by the runner:

- **Fail-closed verifier** — `tests/test.sh` defaults the reward to `0` and only ever raises it
  when `junit_compare.py` validates fresh JUnit XML (see **Scoring**). There is no exit-code
  fallback, stale reports are deleted before the run, and a hidden `test.patch` that fails to
  apply stops the run at `0`.
- **Restricted network** — `task.toml` uses a `network_mode = "allowlist"` policy that blocks
  GitHub and the open web while allowing build/dependency hosts (see **`task.toml`**).
- **Sealed Git history** — `environment/seal_git_history.sh` runs during the image build (after
  cache warming) and leaves only the pinned base commit reachable; later commits — including the
  published upstream fix — and all remotes, tags, and reflogs are removed, so the fix cannot be
  checked out or re-fetched.
- **Disable agent web search (runner-level)** — a built-in web-search tool runs *outside* the
  container's network controls, so it must be turned off in the agent/runner configuration. For
  the Harbor Codex adapter, add `"web_search": "disabled"` to the agent's `kwargs`; for Codex CLI
  use `web_search = "disabled"`. Use the equivalent setting for other agents and confirm from the
  available tools that web search is off.

The three task-file controls are applied uniformly to all 106 tasks by
`scripts/harden_tasks.py` (idempotent; run `scripts/harden_tasks.py --check` to verify).

**Before evaluating:** the Git seal runs in the task image layer, so **rebuild the base and task
images from the hardened tasks** (`scripts/build_bases.sh --rebuild`) — images built before
hardening still contain the full history. Then run the sanity sweep across all 106 tasks and
confirm each Oracle run scores `1` and each unchanged checkout scores `0`, and spot-check from
inside a container that `github.com` is unreachable while a Maven/Gradle host is reachable.

## Running the benchmark

Tasks are run with the [Harbor](https://www.harborframework.com) CLI, which builds each task's
container from `environment/`, runs the agent against `instruction.md`, then executes
`tests/test.sh`. Install it with `uv tool install harbor`. See `harbor run --help` for available agents and flags.

```bash
# Build the shared base images once (see "Base images" above)
scripts/build_bases.sh

# Sanity-check a task with the Oracle agent (applies the gold patch; reward should be 1)
harbor run -p tasks/ankidroid_Anki-Android-18903 -a oracle

# Evaluate an agent on a single task
harbor run -p tasks/ankidroid_Anki-Android-18903 -a "<agent>" -m "<model>"

# Run the full suite (a dataset is just a directory of tasks)
harbor run -p tasks -a "<agent>" -m "<model>"
```

## License

See [LICENSE](LICENSE). Tasks are derived from open-source repositories; each upstream project
retains its own license. The SPDX identifier of the source project's license is recorded in the
`license` field under `[metadata.source]` in every task's `task.toml` (see the table above for the
per-repository breakdown).
