# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: 🤖 Handle webview checkout result

When the domain purchase is complete in the domain management flow:
* On success the flow returns to a refreshed domain management list
* On failure an error is shown

## Interface

The tests use these declarations:

- In `org.wordpress.android.ui.domains.management.purchasedomain.PurchaseDomainViewModel`: `object UiState.ErrorInCheckout : UiState` and `object ActionEvent.OpenDomainManagement : ActionEvent`

## Requirements

- `onDomainRegistrationComplete` treats any non-null event, including a cancelled one, as a finished checkout and emits `ActionEvent.OpenDomainManagement`; only a `null` event is a failure that sets `UiState.ErrorInCheckout`
