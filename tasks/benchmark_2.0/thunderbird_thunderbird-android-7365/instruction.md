# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Save authorization state when editing server settings

Editing server settings could lead to sign in via OAuth 2.0. When saving server settings we also need to persist the auth state.

## Interface

The tests use these declarations:

- `updateServerSettings` in `app.k9mail.feature.account.edit.AccountEditExternalContract.AccountServerSettingsUpdater` gains a fourth parameter `authorizationState: AuthorizationState?`
