# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: [ML 0.5/MVI.02.4] Implement LocalDeleteOperationDecider (Domain Logic)

## Description
Migrate the `LocalDeleteOperationDecider` from the legacy module (`:legacy:core`) into a new `LocalDeleteOperationDecider` interface within the feature domain api `:feature:mail:message:list:api` and a default implementation inside the `:feature:mail:message:list:internal`.

## Goal
Encapsulate the business rules that determine if a deletion should bypass the trash (e.g., when deleting from Spam/Trash or based on `DeletePolicy`) without bloating the `DeleteMessages` orchestrator.

## Acceptance Criteria
* Correctly identifies "hard delete" scenarios based on `Account` settings and `Folder` type.
* Ensure the logic is tested correctly.

## Technical Details
* Need to move both `DefaultLocalDeleteOperationDecider`(old `LocalDeleteOperationDecider`) implementation AND tests to the internal feature module
* Need to wire the `MessagingController` to retrieve the instance of the new interface `LocalDeleteOperationDecider` via DI. 

## Interface

The tests use these declarations:

- `interface net.thunderbird.feature.mail.message.list.LocalDeleteOperationDecider` with `fun isDeleteImmediately(LegacyAccountDto, Long): Boolean`
- `class net.thunderbird.feature.mail.message.list.internal.DefaultLocalDeleteOperationDecider()` implementing it
- `com.fsck.k9.controller.MessagingController`: its constructor takes the new interface where it took `com.fsck.k9.controller.LocalDeleteOperationDecider`
