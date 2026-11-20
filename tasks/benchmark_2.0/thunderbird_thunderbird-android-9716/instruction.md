# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: 12.0b7 crash. Upon [gmail] folder selection

### Checklist

- [x] I have used the search function to see if someone else has already submitted the same bug report.
- [x] I will describe the problem with as much detail as possible.

### App

Thunderbird for Android

### App version

12.0b7

### Where did you get the app from?

Other

### Android version

Android 15

### Device model

Oneplus 10 Pro

### Steps to reproduce

App downloaded from github.

1. Close app and remove from androids running app list.
2. Open app again.
3. Switch from Unified to gmail account.
4. Observe standard gmail folders are all correctly displayed at the same level beneath each other.
5. Drop back to android launcher (TBA running in background)
6. I wait about 30 minutes.
7. Open the app and view the gmail folder list.
7. Observe abnormal presence of [gmail] expandable folder.
8. Select this [gmail] folder.
9. App crashes

### Expected behavior

The normal behaviour is where the standard gmail folders (Inbox, outbox, all mail, draft, etc) are all displayed beneath each other at the top level.

Expected behavior is available at /task-assets/instruction/bdd0588bbcd7a244.jpg.

### Actual behavior

I open the app after approx 30 minutes running in the background. I observe the app has changed the normal folder view and now displays an expandable [gmail] folder. Selecting this folder crashes the app.

I'm not sure sure what is triggering the view to change as it does so without user interaction. Perhaps background sync.

Actual behavior is available at /task-assets/instruction/3a9bd36b2332dd69.jpg.

### Logs

k9mail-logs.txt is available at /task-assets/instruction/2c6bf5b50d4d3c4e.txt.

## Interface

The tests use these declarations:

- `accountId` of `net.thunderbird.feature.navigation.drawer.dropdown.domain.entity.MailDisplayFolder` becomes `String?`
