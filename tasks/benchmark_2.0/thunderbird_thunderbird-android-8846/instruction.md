# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Unread message count doesn't change unless refreshed

### Checklist

- [x] I have used the search function to see if someone else has already submitted the same bug report.
- [x] I will describe the problem with as much detail as possible.

### App

Thunderbird for Android

### App version

8.2

### Where did you get the app from?

Google Play

### Android version

14

### Device model

_No response_

### Steps to reproduce

1. Have some unread emails.
2. Check in the sidebar how many emails are unread.
3. Mark one email read.
4. Now check the number in the sidebar again.

You will find that the number didn't decrease.


### Expected behavior

When I mark emails as read, the unread message count should decrease in the side bar.

### Actual behavior

The unread count doesn't change after marking emails as read. It only charges after refreshing the inbox which is a bit annoying.

### Logs

_No response_

## Interface

The tests use these declarations:

- `app.k9mail.legacy.message.controller.MessageCountsProvider` gains `fun getMessageCountsFlow(LocalSearch): Flow<MessageCounts>`
- `com.fsck.k9.controller.DefaultMessageCountsProvider`: its constructor gains `messagingControllerRegistry: MessagingControllerRegistry` after `messageStoreManager`
- `interface app.k9mail.legacy.ui.folder.DisplayFolderRepository` with `getDisplayFoldersFlow(Account, Boolean)` and `getDisplayFoldersFlow(String)`, both returning `Flow<List<DisplayFolder>>`
- `interface app.k9mail.feature.navigation.drawer.domain.DomainContract.UnifiedFolderRepository` with `fun getDisplayUnifiedFolderFlow(DisplayUnifiedFolderType): Flow<DisplayUnifiedFolder>`, implemented by `class app.k9mail.feature.navigation.drawer.data.UnifiedFolderRepository(messageCountsProvider: MessageCountsProvider)`
- `app.k9mail.feature.navigation.drawer.domain.usecase.GetDisplayFoldersForAccount(displayFolderRepository: DisplayFolderRepository, unifiedFolderRepository: DomainContract.UnifiedFolderRepository)`
