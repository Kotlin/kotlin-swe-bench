# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: 🤖 Show loading indicator when submitting the cart and error screen on failure

The domain purchase screen should show:
* a loading indicator when the the cart request is performed
* an error message if cart creation fails

## Interface

The tests use these declarations:

- In `org.wordpress.android.ui.domains.management.purchasedomain.PurchaseDomainViewModel`: `object UiState.ErrorSubmittingCart : UiState` and `fun onErrorButtonTapped()`
