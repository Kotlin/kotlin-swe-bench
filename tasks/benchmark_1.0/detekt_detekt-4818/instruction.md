# Implement the issue(s) in detekt/detekt:

## Issue #4815 https://github.com/detekt/detekt/issues/4815: False positive for unused imports

Detekt is reporting Unused Import for Kdocs references.
As you can see in this [class](https://github.com/GetStream/stream-chat-android/blob/report-detekt-issue/stream-chat-android-ui-components/src/main/kotlin/io/getstream/chat/android/ui/channel/list/ChannelListViewStyle.kt#L27) the `ChannelViewHolder` is referenced into the Kdocs comments, but Detekt doesn't parse it properly and thinks there is an unused import

It seems to be reported on #457 and fixed with #458 but it is not working for me

## Expected Behavior
Any import that is used on Kdocs shouldn't be reported as an issue

## Steps to Reproduce
- Clone [this repo](https://github.com/GetStream/stream-chat-android)
- Checkout branch `report-detekt-issue`
- Run `./gradlew detekt`

The tasks will fail, reporting unused imports, but it is already being used

## Your Environment
* Version of detekt used: io.gitlab.arturbosch.detekt:detekt-gradle-plugin:1.19.0
* Version of Gradle used (if applicable): 7.4.2
* Gradle scan link (add `--scan` option when running the gradle task): https://scans.gradle.com/s/t2ryncburuyyg
* Link to your project (if it's a public repository): https://github.com/getstream/stream-chat-android

