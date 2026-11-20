# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: [Reader] Fix `reader_filter_sheet_item_selected` tracked multiple times

`reader_filter_sheet_item_selected` should be tracked once when the selected filter changes, but it's being tracked multiple times.

## Interface

The tests use these declarations:

- `org.wordpress.android.ui.reader.subfilter.SubFilterViewModel`: its constructor gains, right after the `ReaderTracker` parameter, an `org.wordpress.android.datasets.wrappers.ReaderTagTableWrapper` and then an `org.wordpress.android.datasets.ReaderBlogTableWrapper`

## Requirements

- `SubFilterViewModel.onSubfilterSelected` tracks only items whose `isTrackedItem` is true
- `SubFilterViewModel.onSubFiltersListButtonClicked` also loads the subfilters
