# Implement the issue(s) in square/okhttp:

## Issue #8834 https://github.com/square/okhttp/issues/8834: make LoggingEventListener extensible

Would you consider making [LoggingEventListener](https://github.com/square/okhttp/blob/6de88ec6217114fe209f60564a5ec96dd5c86701/okhttp-logging-interceptor/src/main/kotlin/okhttp3/logging/LoggingEventListener.kt) extensible?  I think this means making it an open class and making logWithTime protected.

My goal is to tweak the log levels a bit, so things like connectFailed/responseFailed log at warn, but the others log at some level that's determined by a config flag in my app -- either debug, or info when more verbose logging is enabled.

As things are now, it looks like I need to re-implement LoggingEventListener, even though it's so close to what I'm looking for.
