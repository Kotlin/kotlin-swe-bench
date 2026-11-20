# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: App crashes when upgrading from 13.0b1 to 13.0b2 and there is no connection when fetching IMAP prefix during the migration

## Steps to reproduce

1. Install 13.0b1
2. Setup an account
3. Turn off network
4. Send a message; message is going to be placed in the outbox folder
5. Close the app
6. Install 13.0b2
7. Turn on network
8. Open the app.

## Actual

The app crashes when trying to open

## Expected

The app should open without a crash and the message should be sent correctly


## Stacktrace

```
Exception java.util.NoSuchElementException: List is empty.
  at kotlin.collections.CollectionsKt___CollectionsKt.first (_Collections.kt:221)
  at net.thunderbird.feature.navigation.drawer.dropdown.domain.usecase.GetDisplayTreeFolder.invoke (GetDisplayTreeFolder.kt:31)
  at net.thunderbird.feature.navigation.drawer.dropdown.ui.DrawerViewModel$loadFolders$4.emit (DrawerViewModel.kt:101)
  at net.thunderbird.feature.navigation.drawer.dropdown.ui.DrawerViewModel$loadFolders$4.emit (DrawerViewModel.kt:100)
  at kotlinx.coroutines.flow.FlowKt__ChannelsKt.emitAllImpl$FlowKt__ChannelsKt (Channels.kt:33)
  at kotlinx.coroutines.flow.FlowKt__ChannelsKt.access$emitAllImpl$FlowKt__ChannelsKt (Channels.kt:1)
  at kotlinx.coroutines.flow.FlowKt__ChannelsKt$emitAllImpl$1.invokeSuspend (Channels.kt)
  at kotlin.coroutines.jvm.internal.BaseContinuationImpl.resumeWith (ContinuationImpl.kt:33)
  at kotlinx.coroutines.internal.DispatchedContinuation.resumeUndispatchedWith$kotlinx_coroutines_core (DispatchedContinuation.java:237)
  at kotlinx.coroutines.DispatchedTaskKt.resume (DispatchedTask.kt:162)
  at kotlinx.coroutines.DispatchedTaskKt.resumeUnconfined (DispatchedTask.kt:175)
  at kotlinx.coroutines.DispatchedTaskKt.dispatch (DispatchedTask.kt:147)
  at kotlinx.coroutines.CancellableContinuationImpl.dispatchResume (CancellableContinuationImpl.kt:470)
  at kotlinx.coroutines.CancellableContinuationImpl.completeResume (CancellableContinuationImpl.kt:591)
  at kotlinx.coroutines.channels.BufferedChannelKt.tryResume0 (BufferedChannel.kt:2957)
  at kotlinx.coroutines.channels.BufferedChannelKt.access$tryResume0 (BufferedChannel.kt:1)
  at kotlinx.coroutines.channels.BufferedChannel$BufferedChannelIterator.tryResumeHasNext (BufferedChannel.kt:1719)
  at kotlinx.coroutines.channels.BufferedChannel.tryResumeReceiver (BufferedChannel.kt:662)
  at kotlinx.coroutines.channels.BufferedChannel.updateCellSend (BufferedChannel.kt:478)
  at kotlinx.coroutines.channels.BufferedChannel.access$onClosedReceiveCatchingOnNoWaiterSuspend (BufferedChannel.kt:33)
  at kotlinx.coroutines.channels.BufferedChannel.access$updateCellSend (BufferedChannel.kt:33)
  at kotlinx.coroutines.channels.BufferedChannel.sendImpl$default (BufferedChannel.kt:301)
  at kotlinx.coroutines.channels.BufferedChannel.send$suspendImpl (BufferedChannel.kt:110)
  at kotlinx.coroutines.channels.BufferedChannel.send (BufferedChannel.kt)
  at kotlinx.coroutines.channels.ChannelCoroutine.send (ChannelCoroutine.kt)
  at kotlinx.coroutines.flow.internal.SendingCollector.emit (SendingCollector.kt:15)
  at net.thunderbird.feature.navigation.drawer.dropdown.domain.usecase.GetDisplayFoldersForAccount$invoke$$inlined$map$2$2.emit (Emitters.kt:50)
  at kotlinx.coroutines.flow.FlowKt__ChannelsKt.emitAllImpl$FlowKt__ChannelsKt (Channels.kt:33)
  at kotlinx.coroutines.flow.FlowKt__ChannelsKt.access$emitAllImpl$FlowKt__ChannelsKt (Channels.kt:1)
  at kotlinx.coroutines.flow.FlowKt__ChannelsKt$emitAllImpl$1.invokeSuspend (Channels.kt)
  at kotlin.coroutines.jvm.internal.BaseContinuationImpl.resumeWith (ContinuationImpl.kt:33)
  at kotlinx.coroutines.DispatchedTask.run (DispatchedTask.kt:100)
  at android.os.Handler.handleCallback (Handler.java:959)
  at android.os.Handler.dispatchMessage (Handler.java:100)
  at android.os.Looper.loopOnce (Looper.java:249)
  at android.os.Looper.loop (Looper.java:337)
  at android.app.ActivityThread.main (ActivityThread.java:9515)
  at java.lang.reflect.Method.invoke
  at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run (RuntimeInit.java:636)
  at com.android.internal.os.ZygoteInit.main (ZygoteInit.java:1005)
```

