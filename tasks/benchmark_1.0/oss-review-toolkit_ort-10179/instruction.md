# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #8462 https://github.com/oss-review-toolkit/ort/issues/8462: Failing to scan repository with FossID: Cannot deserialize value of type `java.util.LinkedHashMap<java.lang.String,java.lang.String>` 

When trying to create a scan with FossID (workbench version: 2023.3.0) ORT scan step fails.
I tried different internal repositories all failing with the same pattern. Is there anything I can provide as debug more than the traceback? Is there any option to increase the debug output even further to get the details of the API calls that are made towards FossID (assuming, that there is a mismatch between what ORT gets and what is expected)?

```
16:31:44.135 [main] INFO  org.ossreviewtoolkit.plugins.scanners.fossid.FossId - Default branch is 'develop'.
16:31:44.135 [main] WARN  org.ossreviewtoolkit.plugins.scanners.fossid.FossId - No project revision has been given.
16:31:44.136 [main] INFO  org.ossreviewtoolkit.plugins.scanners.fossid.FossIdUrlProvider - URL mapping applied to <https git url>: Mapped to <ssh git url>.
16:31:44.137 [main] WARN  java.util.List - No recent scan found for project revision null. Falling back to default branch scans.
16:31:44.137 [main] WARN  java.util.List - No recent default branch scan found. Falling back to old behavior.
16:31:44.137 [main] INFO  org.ossreviewtoolkit.plugins.scanners.fossid.FossId - Found 0 scans.
16:31:44.137 [main] INFO  org.ossreviewtoolkit.plugins.scanners.fossid.FossId - No scan found for <ssh git url> and revision <revision>. Creating origin scan...
16:31:44.137 [main] INFO  org.ossreviewtoolkit.plugins.scanners.fossid.FossIdNamingProvider - Parameterizing the name with pattern '$Var1_$Var3'.
16:31:44.138 [main] INFO  org.ossreviewtoolkit.plugins.scanners.fossid.FossId - Creating scan 'jenkins_library_test'...
Exception in thread "main" com.fasterxml.jackson.databind.exc.MismatchedInputException: Cannot deserialize value of type `java.util.LinkedHashMap<java.lang.String,java.lang.String>` from Array value (token `JsonToken.START_ARRAY`)
 at [Source: REDACTED (`StreamReadFeature.INCLUDE_SOURCE_IN_LOCATION` disabled); line: 1, column: 49] (through reference chain: org.ossreviewtoolkit.clients.fossid.EntityResponseBody["data"])
        at com.fasterxml.jackson.databind.exc.MismatchedInputException.from(MismatchedInputException.java:59)
        at com.fasterxml.jackson.databind.DeserializationContext.reportInputMismatch(DeserializationContext.java:1767)
        at com.fasterxml.jackson.databind.DeserializationContext.handleUnexpectedToken(DeserializationContext.java:1541)
        at com.fasterxml.jackson.databind.deser.std.StdDeserializer._deserializeFromArray(StdDeserializer.java:222)
        at com.fasterxml.jackson.databind.deser.std.MapDeserializer.deserialize(MapDeserializer.java:457)
        at com.fasterxml.jackson.databind.deser.std.MapDeserializer.deserialize(MapDeserializer.java:32)
        at com.fasterxml.jackson.databind.deser.SettableBeanProperty.deserialize(SettableBeanProperty.java:545)
        at com.fasterxml.jackson.databind.deser.BeanDeserializer._deserializeWithErrorWrapping(BeanDeserializer.java:570)
        at com.fasterxml.jackson.databind.deser.BeanDeserializer._deserializeUsingPropertyBased(BeanDeserializer.java:440)
        at com.fasterxml.jackson.databind.deser.BeanDeserializerBase.deserializeFromObjectUsingNonDefault(BeanDeserializerBase.java:1493)
        at com.fasterxml.jackson.databind.deser.BeanDeserializer.deserializeFromObject(BeanDeserializer.java:348)
        at com.fasterxml.jackson.databind.deser.BeanDeserializer.deserialize(BeanDeserializer.java:185)
        at com.fasterxml.jackson.databind.deser.DefaultDeserializationContext.readRootValue(DefaultDeserializationContext.java:342)
        at com.fasterxml.jackson.databind.ObjectReader._bindAndClose(ObjectReader.java:2125)
        at com.fasterxml.jackson.databind.ObjectReader.readValue(ObjectReader.java:1501)
        at retrofit2.converter.jackson.JacksonResponseBodyConverter.convert(JacksonResponseBodyConverter.java:33)
        at retrofit2.converter.jackson.JacksonResponseBodyConverter.convert(JacksonResponseBodyConverter.java:23)
        at retrofit2.OkHttpCall.parseResponse(OkHttpCall.java:246)
        at retrofit2.OkHttpCall$1.onResponse(OkHttpCall.java:156)
        at okhttp3.internal.connection.RealCall$AsyncCall.run(RealCall.kt:519)
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)
        at java.base/java.lang.Thread.run(Thread.java:840)
```


