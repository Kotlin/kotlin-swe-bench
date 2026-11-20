# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: [Reader] Update only tags that changed instead of the whole list in "Your Tags" feed

Currently we're updating the whole "Your Tags" list when the subscribed status of one tag changes. We should only update the subscribed/unsubscribed tag item instead.

## Interface

The tests use these declarations:

- `fun mapInitialTagFeedItem(tag: ReaderTag, onTagChipClick: (ReaderTag) -> Unit, onMoreFromTagClick: (ReaderTag) -> Unit, onItemEnteredView: (ReaderTagsFeedViewModel.TagFeedItem) -> Unit): ReaderTagsFeedViewModel.TagFeedItem` in `org.wordpress.android.ui.reader.viewmodels.tagsfeed.ReaderTagsFeedUiStateMapper`
