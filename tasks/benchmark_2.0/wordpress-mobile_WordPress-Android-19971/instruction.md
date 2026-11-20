# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: [Prompts][Bug] The `dailyprompt-<id>` tag is not being added to Prompt responses during Bloganuary

### Expected behavior
The `dailyprompt-<id>` tag is always added to Blogging Prompt response posts made in the app, together with `dailyprompt` and Bloganuary-specific tags.

### Actual behavior
The `dailyprompt-<id>` tag is not being added during Bloganuary and instead the `bloganuary-YYYY-DD` tag is being added twice.

### Steps to reproduce the behavior
Make sure to have a site that supports prompts.

1. Install and log into Jetpack
2. Go to `My Site` dashboard
3. Tap `Answer` in the Prompts card or got to the Prompts card menu -> "View more prompts" -> Tap on any prompt
4. On the Editor, hit publish
5. **Verify** the tags don't show the `dailyprompt-<id>` tag during the month of January.

### Investigation
This issue is happening because we are parsing the `answered_link` URL to get the tag from there and consider that the "daily prompt id" tag, but that link was changed for Bloganuary entries, so we end up getting the `bloganuary-YYYY-DD` tag from that URL and using it, while also adding the same tag again from code for bloganuary.

WordPress/src/main/java/org/wordpress/android/ui/posts/EditorBloggingPromptsViewModel.kt:58

```kotlin
        add(bloggingPromptsPostTagProvider.promptIdTag(prompt.answeredLink))
```

### Possible fix
Build the `dailyprompt-<id>` tag in code, by using the ID from the Blogging Prompt object instead of parsing it from `answered_link`.

We can also make sure to keep using the `answered_link` tag for the search results that we display when tapping "View all responses" button of the Blogging Prompt card.

##### Tested on OnePlus 5T, Android 10, JPAndroid 24.0-rc-1 (also `trunk` and `feature/reader-ia`)

## Interface

The tests use these declarations:

- In `org.wordpress.android.ui.bloggingprompts.BloggingPromptsPostTagProvider`: `promptIdTag(Int): String` and `promptSearchReaderTag(String): ReaderTag`

## Requirements

- `promptIdTag` returns `dailyprompt-<id>` for a positive id and the generic `dailyprompt` tag for an id of `0`
