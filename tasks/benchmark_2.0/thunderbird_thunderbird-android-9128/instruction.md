# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Update Koin to 4.0.x

The latest Koin 4.0 release (September 2024) is now available, requiring our project to be updated and migrated with necessary code changes.

## Interface

The tests use these declarations:

- `com.fsck.k9.legacyCoreModules`, `com.fsck.k9.legacyCommonAppModules` and `com.fsck.k9.legacyUiModules`: the `List<Module>` values currently named `coreModules`, `commonAppModules` and `uiModules`
