# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Migrate K9.isHideTimeZone to PreferenceDataStore

The current implementation in Thunderbird Android directly accesses the static field `K9.isHideTimeZone` to determine whether the Time Zone header should be removed from outgoing emails. This approach bypasses the modern PreferenceDataStore, which is the preferred mechanism for managing application settings.

This task involves refactoring all direct references to `K9.isHideTimeZone` and replacing them with proper usage of PreferenceDataStore. This will improve consistency, testability, and alignment with the app’s current architecture for preference management.

## Interface

The tests use these declarations:

- `data class net.thunderbird.core.preference.privacy.PrivacySettings(isHideTimeZone: Boolean)`
- `privacy: PrivacySettings`, a constructor property of `net.thunderbird.core.preference.GeneralSettings`
- `net.thunderbird.core.preference.privacy.PrivacySettingsManager`, an interface with `fun setIsHideTimeZone(Boolean)`
