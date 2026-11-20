# Implement the issue(s) in square/okhttp:

## Issue #6668 https://github.com/square/okhttp/issues/6668: SSE: EventSources.processResponse throws kotlin.UninitializedPropertyAccessException: lateinit property call has not been initialized

Calling EventSources.processResponse(response, listener) always results in the following exception:

```
kotlin.UninitializedPropertyAccessException: lateinit property call has not been initialized
	at okhttp3.sse.internal.RealEventSource.processResponse(RealEventSource.kt:65)
	at okhttp3.sse.EventSources.processResponse(EventSources.kt:42)
	at okhttp3.sse.internal.EventSourcesHttpTest.processResponse(EventSourcesHttpTest.java:69)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	...
```

This is because the lateinit RealEventSource.call property is only initialized when `RealEventSource.connect` is called, which isn't called to process an already received response (meaning, it makes sense it isn't called with EventSources.processResponse).

The fix might be as easy as wrapping [the call to call.timeoutEarlyExit() in RealEventSource.processResponse](https://github.com/square/okhttp/blob/334eb0072512155e57a809b2fa18861c0d68ec9f/okhttp-sse/src/main/kotlin/okhttp3/sse/internal/RealEventSource.kt#L65) in an if statement that checks to see if it has been initialized or not.

**Unit Test that reproduces the bug**

```java
package okhttp3.sse.internal;

import mockwebserver3.MockResponse;
import mockwebserver3.MockWebServer;
import mockwebserver3.junit5.internal.MockWebServerExtension;
import okhttp3.OkHttpClient;
import okhttp3.OkHttpClientTestRule;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.sse.EventSources;
import okhttp3.testing.PlatformRule;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.extension.RegisterExtension;

import java.io.IOException;

@ExtendWith(MockWebServerExtension.class)
@Tag("Slowish")
public final class EventSourcesHttpTest {
  @RegisterExtension public final PlatformRule platform = new PlatformRule();

  private MockWebServer server;
  @RegisterExtension public final OkHttpClientTestRule clientTestRule = new OkHttpClientTestRule();

  private final EventSourceRecorder listener = new EventSourceRecorder();
  private OkHttpClient client = clientTestRule.newClient();

  @BeforeEach public void before(MockWebServer server) {
    this.server = server;
  }

  @AfterEach public void after() {
    listener.assertExhausted();
  }

  @Test public void processResponse() throws IOException {
    server.enqueue(new MockResponse().setBody(""
        + "data: hey\n"
        + "\n").setHeader("content-type", "text/event-stream"));

    Request request = new Request.Builder()
        .url(server.url("/"))
        .build();
    Response response = client.newCall(request).execute();
    EventSources.processResponse(response, listener);  // throws kotlin.UninitializedPropertyAccessException

    listener.assertOpen();
    listener.assertEvent(null, null, "hey");
    listener.assertClose();
  }
}

```
