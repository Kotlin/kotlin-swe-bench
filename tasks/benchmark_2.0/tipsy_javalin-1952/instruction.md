writeJsonStream doesn't correctly compress response stream
**Actual behavior (the bug)**
Sending a request to a handler which writes it's response using `writeJsonStream` fails when requesting compressed output.
Specifically sending a request with `curl --compressed` which sets `Accept-Encoding: deflate, gzip` fails with `curl: (61) Error while processing content unencoding: incorrect header check`.
Javalin responds with `Content-Type: gzip` but I believe sends uncompressed bytes which causes cURL to error out with the above error message.

**Expected behavior**
The server should handle `curl --compressed` for streaming endpoints without additional configuration.

**To Reproduce**
Create a handler that uses `ctx.writeJsonStream` that consumes a relatively large stream.
Send a request to said handler with `curl --compressed`.

**Additional context**
Using a custom compression strategy and setting `minSizeForCompression = 0` works around the issue.

## Interface

The tests use these declarations:

- `var defaultMinSizeForCompression: Int` in `io.javalin.compression.CompressionStrategy`
- `var minSizeForCompression: Int` in `io.javalin.http.Context`
