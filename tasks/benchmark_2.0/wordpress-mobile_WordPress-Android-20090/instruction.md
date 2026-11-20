# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: [Reader][Bug] Discover scrolls to top when loading more posts

### Expected behavior
When scrolling down the Discover feed to load older posts, after doing a pull to refresh, the screen should not scroll back to the top.

### Actual behavior
When scrolling down the Discover feed to load older posts, **after doing a pull to refresh**, the screen scrolls back to the first item, even though it's loading items on the end of the list (older posts).


Actual behavior is available at /task-assets/instruction/84e8a7506dc87272.mp4.


### Steps to reproduce the behavior
1. Install and log into Jetpack
2. Go to the Reader
3. Go to the Discover feed
4. Swipe to refresh the Discover feed
5. Start scrolling the feed (preferably slowly so it's easy to see the issue)
6. When a progress spinner appears on the bottom and the feed jumps back to the first item
7. You can do steps 4-6 several times to see the issue happening consistently

### Initial investigation
It looks like this bug has existed for a while (since 2020 or before), as the culprit code is this one:
WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:277-279

```kotlin
                    REQUEST_MORE -> {
                        _uiState.value = state.copy(loadMoreProgressVisibility = true)
                    }
```

It only happens on the Discover Feed, and only happens on the first request for more posts after using the pull-to-refresh, because the way that the loading indicator is shown simply copies the current state (code above) modifying the `loadMoreProgressVisibility` to `true`.

The issue is that the latest UI state for the swipe-to-refresh contains a `scrollToTop` variable that is still `true` (since the last pull to refresh UI state had that set that way [here](WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:154-159) with `swipeToRefreshTriggered` being set [here](WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:507-513)). 

`WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:154-159`

```kotlin
                        _uiState.value = DiscoverUiState.ContentUiState(
                            convertCardsToUiStates(posts),
                            reloadProgressVisibility = false,
                            loadMoreProgressVisibility = false,
                            scrollToTop = swipeToRefreshTriggered
                        )
```

`WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:507-513`

```kotlin
    fun swipeToRefresh() {
        readerTracker.track(AnalyticsTracker.Stat.READER_PULL_TO_REFRESH)
        swipeToRefreshTriggered = true
        launch {
            readerDiscoverDataProvider.refreshCards()
        }
    }
```

Also, the `ViewModel` controls the state of that `scrollToTop` using a class field `swipeToRefreshTriggered`, and resets only that field, but not the actual UI state used for refreshing the screen after the pull-to-refresh content is updated [here](WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:160). So we have those 2 places controlling the same state but not being synchronized properly.

`WordPress/src/main/java/org/wordpress/android/ui/reader/discover/ReaderDiscoverViewModel.kt:160`

```kotlin
                        swipeToRefreshTriggered = false
```

### Fix suggestion
A quick idea for a fix is making sure that whenever the `_uiState` is updated using `.copy` we also set the `scrollToTop` field to the current `swipeToRefreshTriggered` View Model field.

Note this is far from ideal though, since a more proper fix would be to make sure the `_uiState` is the source of truth, also the `scrollToTop` feels more of an `Event` than an actual `State`, so maybe a solution would be making the `scrollToTop` be a separate Event LiveData/Flow that is observed by the UI and is **not** part of the UI State.

##### Tested on OnePlus 5T, Android 10, JPAndroid 24.0-rc-1
##### Tested on Emulator, Android 140, JPAndroid 21.8 (from around May 2023)

## Interface

The tests use these declarations:

- `scrollToTopEvent`, a `LiveData` of any type, in `org.wordpress.android.ui.reader.discover.ReaderDiscoverViewModel`
