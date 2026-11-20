# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: 🤖 Bring the user straight to the comments reader view

Non-admin users that cannot moderate comment should skip the comment details screen and be directed straight to the comments reader view

## Interface

The tests use these declarations:

- `org.wordpress.android.ui.notifications.NotificationsListViewModel`: its constructor gains, right after the `GCMMessageHandler` parameter, an `org.wordpress.android.ui.notifications.utils.NotificationsUtilsWrapper` and then an `org.wordpress.android.fluxc.utils.AppLogWrapper`
- `fun openNote(String?, (Long, Long, Long) -> Unit, () -> Unit)` in the same class

## Requirements

- `openNote` opens the detail view when the note cannot be retrieved from `NotificationsUtilsWrapper.getNoteById`
- For a comment note that cannot be moderated, when `ReaderPostTableWrapper.getBlogPost(siteId, postId, false)` returns `null`, the post is requested with `ReaderPostActionsWrapper.requestBlogPost`: on success the reader opens with the note's site id, post id and comment id, on failure the detail view opens
