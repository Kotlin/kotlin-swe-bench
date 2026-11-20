# Implement the issue(s) in ankidroid/Anki-Android:

## Issue #19652 https://github.com/ankidroid/Anki-Android/issues/19652: [BUG]: startup crash - getExternalFilesDir unexpectedly returned null. Media state: removed

2.23.0beta3

* `getExternalFilesDir` is null
* Collection path is set
* `CollectionHelper.initializeAnkiDroidDirectory` throws `StorageAccessException`

https://ankidroid.org/acra/app/1/bug/362178/report/968c2402-f20d-4984-b5b5-3781a4feb340

```
java.lang.RuntimeException: Unable to create application com.ichi2.anki.AnkiDroidApp: y9.b: getExternalFilesDir unexpectedly returned null. Media state: removed
	at android.app.ActivityThread.handleBindApplication(ActivityThread.java:8635)
	at android.app.ActivityThread.-$$Nest$mhandleBindApplication(Unknown Source)
	at android.app.ActivityThread$H.handleMessage(ActivityThread.java:2792)
	at android.os.Handler.dispatchMessage(Handler.java:115)
	at android.os.Looper.loopOnce(Looper.java:298)
	at android.os.Looper.loop(Looper.java:408)
	at android.app.ActivityThread.main(ActivityThread.java:9952)
	at java.lang.reflect.Method.invoke(Native Method)
	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:613)
	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:1074)
Caused by: y9.b: getExternalFilesDir unexpectedly returned null. Media state: removed
	at com.ichi2.anki.exception.SystemStorageException$Companion.build(SystemStorageException.kt:52)
	at com.ichi2.anki.CollectionHelper.getAppSpecificExternalAnkiDroidDirectory(CollectionHelper.kt:231)
	at com.ichi2.anki.CollectionHelper.getDefaultAnkiDroidDirectory(CollectionHelper.kt:186)
	at com.ichi2.anki.AnkiDroidApp.onCreate(AnkiDroidApp.kt:218)
	at android.app.Instrumentation.callApplicationOnCreate(Instrumentation.java:1401)
	at android.app.ActivityThread.handleBindApplication(ActivityThread.java:8627)
	... 9 more
```

* Related: https://github.com/ankidroid/Anki-Android/issues/13207
