# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: Show menu items in Dashboard for Self hosted sites

### Expected behavior
The Menu items should be shown on the dashboard for Self hosted sites in Jetpack app

### Actual behavior
Unified dashboard with card hidden message is shown in dashboard for Self hosted sites in Jetpack app

### Steps to reproduce the behavior
- Login to the Jetpack app with a self hosted site 
- Notice that the dashboard shown is as in the screenshot 
- Notice that no cards message is shown 

##### Tested on [device], Android [version], JPAndroid / WPAndroid [version]
Pixel 4a, Android 13, trunk

## Interface

The tests use these declarations:

- `val dashboardData: List<MySiteCardAndItem>` in `org.wordpress.android.ui.mysite.MySiteViewModel.State.SiteSelected`: the dashboard cards when the app is the Jetpack app and the site uses the WP.com REST API, otherwise the site menu items

## Requirements

- The dashboard cards are built regardless of `JetpackFeatureRemovalPhaseHelper.shouldShowDashboard()`
