# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Replace Direct Calls to K9.isChangeContactNameColor with PreferenceDataStore integration

This task aims to refactor all direct usages of `K9.isChangeContactNameColor` to retrieve/modify the preference via PreferenceDataStore.

## Interface

The tests use these declarations:

- `isChangeContactNameColor: Boolean`, a constructor property of `net.thunderbird.core.preference.GeneralSettings`
- `fun setIsChangeContactNameColor(Boolean)` in `net.thunderbird.core.preference.GeneralSettingsManager`
- `com.fsck.k9.helper.MessageHelper.getRecipientDisplayNames` and both `MessageHelper.toFriendly` overloads gain `isChangeContactNameColor: Boolean` right after `isShowCorrespondentNames`
