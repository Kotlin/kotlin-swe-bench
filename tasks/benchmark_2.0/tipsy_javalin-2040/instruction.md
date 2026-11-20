Standardize Jetty Configuration for Consistency
**Issue Description:**
In the current codebase, the Jetty configuration exhibits inconsistency between Kotlin and Java. This results in differing configuration formats, where Kotlin uses `jetty.serverConsumers =`, while Java should use `jetty.serverConsumers()`. To ensure uniformity, the configuration in Kotlin and Java should be standardized.

**Proposed Solution:**
Harmonize Jetty configuration in Kotlin and Java.

**Action Items:**
1. User "zugazagoitia" will create a pull request (PR) to implement the necessary changes for consistent Jetty configuration.
2. Update the visibility of these configuration properties to make them private.

**Acceptance Criteria:**
- Jetty configuration in Kotlin and Java code follows the same format.
- Configuration properties are updated to have the appropriate visibility (private).

## Interface

The tests use these declarations:

- `io.javalin.config.PrivateConfig.jetty`: a `@JvmField` property whose type has `@JvmField var server: org.eclipse.jetty.server.Server?`
