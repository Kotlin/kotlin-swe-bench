# Implement the issue(s) in dzikoysk/reposilite:

## Issue: Cannot fetch metrics when Jetty's `StatisticsHandler` returns `NaN`

### What happened?

Unsure what exactly can cause `StatisticsHandler` to enter into this state.
However this will happen if, for example, `StatisticsHandler.getRequestTimeStdDev()` returns `NaN`, and will cause `/metrics` to return
```json
{"status":400,"message":"Cannot process this request"}
```

Will PR a fix in a few.

### Reposilite version

3.x

### Relevant log output

```shell
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.078 DEBUG | GET /metrics from [0:0:0:0:0:0:0:1]
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | prometheus-metrics-endpoint
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | java.lang.IllegalArgumentException: Duration value cannot be NaN.
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | 	at kotlin.time.DurationKt.toDuration(Duration.kt:1131)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | 	at com.reposilite.plugin.prometheus.metrics.JettyMetrics.register$lambda$6(JettyMetrics.kt:86)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | 	at io.prometheus.metrics.core.metrics.GaugeWithCallback.collect(GaugeWithCallback.java:48)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | 	at io.prometheus.metrics.core.metrics.GaugeWithCallback.collect(GaugeWithCallback.java:28)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.079 ERROR | 	at io.prometheus.metrics.model.registry.Collector.collect(Collector.java:32)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.080 ERROR | 	at io.prometheus.metrics.model.registry.PrometheusRegistry.scrape(PrometheusRegistry.java:116)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.080 ERROR | 	at io.prometheus.metrics.model.registry.PrometheusRegistry.scrape(PrometheusRegistry.java:100)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.080 ERROR | 	at com.reposilite.plugin.prometheus.PrometheusFacade.getMetrics$lambda$1(PrometheusFacade.kt:26)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.080 ERROR | 	at panda.std.Result.supplyThrowing(Result.java:133)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.080 ERROR | 	at panda.std.Result.supplyThrowing(Result.java:125)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.080 ERROR | 	at com.reposilite.plugin.prometheus.PrometheusFacade.getMetrics(PrometheusFacade.kt:23)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at com.reposilite.plugin.prometheus.PrometheusEndpoints$getMetrics$1.invoke(PrometheusEndpoints.kt:19)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at com.reposilite.plugin.prometheus.PrometheusEndpoints$getMetrics$1.invoke(PrometheusEndpoints.kt:15)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at com.reposilite.web.infrastructure.ReposiliteRoutingKt$createReposiliteDsl$dsl$1.invoke$lambda$0(ReposiliteRouting.kt:78)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.router.Endpoint.handle(Endpoint.kt:52)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.router.ParsedEndpoint.handle(ParsedEndpoint.kt:15)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.http.servlet.DefaultTasks.HTTP$lambda$9$lambda$7$lambda$6(DefaultTasks.kt:52)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.http.servlet.JavalinServlet.handleTask(JavalinServlet.kt:99)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.http.servlet.JavalinServlet.handleSync(JavalinServlet.kt:64)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.http.servlet.JavalinServlet.handle(JavalinServlet.kt:50)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at io.javalin.http.servlet.JavalinServlet.service(JavalinServlet.kt:30)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.081 ERROR | 	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:587)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at io.javalin.jetty.JavalinJettyServlet.service(JavalinJettyServlet.kt:52)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:587)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:764)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.servlet.ServletHandler.doHandle(ServletHandler.java:529)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:221)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.session.SessionHandler.doHandle(SessionHandler.java:1580)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ScopedHandler.nextHandle(ScopedHandler.java:221)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ContextHandler.doHandle(ContextHandler.java:1381)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:176)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.servlet.ServletHandler.doScope(ServletHandler.java:484)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.session.SessionHandler.doScope(SessionHandler.java:1553)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ScopedHandler.nextScope(ScopedHandler.java:174)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ContextHandler.doScope(ContextHandler.java:1303)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.ScopedHandler.handle(ScopedHandler.java:129)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.StatisticsHandler.handle(StatisticsHandler.java:173)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.handler.HandlerWrapper.handle(HandlerWrapper.java:122)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.Server.handle(Server.java:563)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.HttpChannel$RequestDispatchable.dispatch(HttpChannel.java:1598)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.HttpChannel.dispatch(HttpChannel.java:753)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.HttpChannel.handle(HttpChannel.java:501)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.server.HttpConnection.onFillable(HttpConnection.java:287)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.io.AbstractConnection$ReadCallback.succeeded(AbstractConnection.java:314)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.082 ERROR | 	at org.eclipse.jetty.io.FillInterest.fillable(FillInterest.java:100)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.io.SelectableChannelEndPoint$1.run(SelectableChannelEndPoint.java:53)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.runTask(AdaptiveExecutionStrategy.java:421)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.consumeTask(AdaptiveExecutionStrategy.java:390)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.tryProduce(AdaptiveExecutionStrategy.java:277)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.run(AdaptiveExecutionStrategy.java:199)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.ReservedThreadExecutor$ReservedThread.run(ReservedThreadExecutor.java:411)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:969)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.QueuedThreadPool$Runner.doRunJob(QueuedThreadPool.java:1194)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at org.eclipse.jetty.util.thread.QueuedThreadPool$Runner.run(QueuedThreadPool.java:1149)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR | 	at java.base/java.lang.Thread.run(Thread.java:840)
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 ERROR |
com.reposilite.journalist.slf4j.Slf4jLogger 2024-11-11 14:15:11.083 DEBUG | ERR RESULT | GET /metrics errored with ErrorResponse(status=400, message=Cannot process this request)
```

## Interface

The tests use these declarations:

- `JettyMetrics.register` and `QueuedThreadPoolMetrics.register` (`com.reposilite.plugin.prometheus.metrics`) each gain a second parameter `registry: io.prometheus.metrics.model.registry.PrometheusRegistry`
