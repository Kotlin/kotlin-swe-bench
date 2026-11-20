# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: Today's Stats card should open the day granularity on stats

### Expected behavior
Today's Stats card should open the TRAFFIC tab with "By day" granularity or DAYS tab (when the `stats_traffic_tab` flag is off).

### Actual behavior
Today's Stats card is opening the INSIGHTS tab.

todays stats issue.webm is available at /task-assets/instruction/da155a77e7d7fbee.webm.

### Steps to reproduce the behavior
1. Log in.
2. Tap the dots button on the "Today's Stats" card.
3. Tap "View stats".

##### Tested on Pixel 9 Pro Emulator, Android 14, JPAndroid 24.4

## Interface

The tests use these declarations:

- `data class OpenStatsByDay(SiteModel) : SiteNavigationAction`, nested in `org.wordpress.android.ui.mysite.SiteNavigationAction`
