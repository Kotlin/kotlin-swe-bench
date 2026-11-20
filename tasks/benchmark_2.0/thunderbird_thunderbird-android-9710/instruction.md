# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Subfolders are still shown as Folder.Subfolder

### Checklist

- [x] I have used the search function to see if someone else has already submitted the same bug report.
- [x] I will describe the problem with as much detail as possible.

### App

Thunderbird for Android

### App version

11.1

### Where did you get the app from?

Google Play

### Android version

16

### Device model

Pixel 6a

### Steps to reproduce

Open the folder drawer

### Expected behavior

Show nested subfolders. 

### Actual behavior

Subfolders are still shown as "Folder.Subfolder", though since #630 the subfolders should be shown nested. Server is dovecot 2.4.1 with . as delimiter, Thunderbird on Linux shows the subfolders just fine.

<img width="1080" height="2400" alt="Image" src="/task-assets/instruction/c66266cfd9585a79.png" />

### Logs

k9mail-logs.txt is available at /task-assets/instruction/7e98f390f618842d.txt.

## Interface

The tests use these declarations:

- `typealias net.thunderbird.feature.mail.folder.api.FolderPathDelimiter = String` and `const val net.thunderbird.feature.mail.folder.api.FOLDER_DEFAULT_PATH_DELIMITER`
- `const val FOLDER_PATH_DELIMITER_KEY: String` in the companion object of `net.thunderbird.feature.account.storage.legacy.LegacyAccountStorageHandler`
- `class com.fsck.k9.preferences.upgrader.AccountSettingsUpgraderTo106(serverSettingsDtoSerializer: ServerSettingsDtoSerializer)` with `fun upgrade(MutableMap<String, Any?>)`
- `net.thunderbird.core.android.account.LegacyAccount` gains `var folderPathDelimiter: FolderPathDelimiter`; the `net.thunderbird.core.android.account.LegacyAccountWrapper` constructor gains `folderPathDelimiter: FolderPathDelimiter` after `shouldMigrateToOAuth`
- The constructors of `app.k9mail.legacy.ui.folder.DisplayFolder` and `net.thunderbird.feature.navigation.drawer.dropdown.domain.entity.MailDisplayFolder` gain `pathDelimiter: FolderPathDelimiter` after `starredMessageCount`
- `net.thunderbird.feature.navigation.drawer.dropdown.domain.usecase.GetDisplayTreeFolder(logger: net.thunderbird.core.logging.Logger)`
- The `feature:navigation:drawer:dropdown` tests use `net.thunderbird.core.logging.testing.TestLogger`

## Requirements

- `AccountSettingsUpgraderTo106.upgrade` sets `FOLDER_PATH_DELIMITER_KEY` to the incoming server settings' `pathPrefix`, or to `FOLDER_DEFAULT_PATH_DELIMITER` if there is none
