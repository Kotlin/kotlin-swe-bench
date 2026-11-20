# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Folders are not assigned after account creation

### Checklist

- [x] I have used the search function to see if someone else has already submitted the same bug report.
- [x] I will describe the problem with as much detail as possible.

### App

Thunderbird for Android

### App version

Daily 17.x

### Where did you get the app from?

Other

### Android version

Not relevant

### Device model

Not releavant

### Steps to reproduce

1. Go to "Setting"
2. Add a new account
3. Finish the account setup

### Expected behavior

When opening the drawer all special folders (inbox, outbox, drafts, sent, spam and trash) show their corresponding icon.

### Actual behavior

Occasionally, special folders appear as standard folders with a default icon. This visual effect reflects an underlying data issue that prevents newly added accounts from working correctly, particularly when the inbox isn't configured properly. The settings menu doesn't offer a way to fix a missing inbox, effectively breaking the account.

### Logs

_No response_

## Interface

The tests use these declarations:

- `fun updateSpecialFoldersSync()` in `net.thunderbird.feature.mail.folder.api.SpecialFolderUpdater`
- `com.fsck.k9.mailstore.DefaultSpecialFolderUpdater`: its constructor is public
- `app.k9mail.legacy.mailstore.FolderRepository` becomes an interface declaring the class's current public functions plus `getPushFolders(AccountId): List<RemoteFolder>`

## Requirements

- When a special folder type has a `MANUAL` selection but its folder id is not among the account's remote folders, `updateSpecialFoldersSync` selects the folder automatically instead and the type's selection becomes `AUTOMATIC`
