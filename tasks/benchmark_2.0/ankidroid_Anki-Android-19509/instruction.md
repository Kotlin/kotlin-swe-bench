# Implement the issue(s) in ankidroid/Anki-Android:

## Issue: [Bug] AnkiDroid fails to start if external storage does not exist (`getExternalFilesDir` is `null`)

----

<details>

<summary>Original Bug Report</summary>

###### Reproduction Steps

1. fire up a windows machine (windows 11 VM, Android 12 emulator, verified that `/sdcard/AnkiDroid` did not exist - that is, it is a clean install)
2. `gradlew.bat installPlayDebug`
3. attempt to start the app after install


###### Expected Result

App starts up

###### Actual Result

NullPointerException, the wicked `!!` strikes again...

Sincere apologies for the screenshot of the stacktrace, it's on a VM where I can't copy/paste the text for "reasons"

image is available at /task-assets/instruction/bacf2705396c0188.png.

The offending code was:

```kotlin
private fun getAppSpecificExternalAnkiDroidDirectory(context: Context): String {
    return context.getExternalFilesDir(null)!!.absolutePath
}
```


I did get a toast saying "Device Storage Not Mounted" and the app quit, after uninstalling / reinstalling / granting storage permission

What if there is no external storage though? Should I be able to use AnkiDroid on only internal storage? That could be a valid device configuration ?

Storage config looks like this:

image is available at /task-assets/instruction/c5232a8c00757969.png.

There is supposed to be a 768MB sdcard in the AVD definition but it appears it is not mounted, this shows up in logs:

> StorageManagerService  system_process  W No primary storage defined yet; hacking together a stub

It is possible this configuration is simply invalid (are there any android devices that have no "external" storage?) as I am unable to run the storage system preferences app either (`Volume external_primary not found`)

But might be worth a look / some better messaging in case something like this is out in the wild.

I'll purge this AVD and try a different one

###### Debug info

Just one commit back on main at the moment; it was built from commit `4cb853c1e10cd95669f810e5987c6ef7a7cf1918`.

###### Research
*Enter an [x] character to confirm the points below:*

- [ ] I have read the [support page](https://ankidroid.org/docs/help.html) and am reporting a bug or enhancement request specific to AnkiDroid
- [ ] I have checked the [manual](https://ankidroid.org/docs/manual.html) and the FAQ and could not find a solution to my issue
- [ ] I have searched for similar existing issues here and on the user forum
- [ ] (Optional) I have confirmed the issue is not resolved in the latest alpha release ([instructions](https://docs.ankidroid.org/manual.html#betaTesting))

</details>

## Requirements

- When `getExternalFilesDir` returns `null`, AnkiDroid does not fall back to another storage location: `DeckPicker` shows an `AlertDialog` whose message contains `getExternalFilesDir unexpectedly returned null`, and skips the introduction screen even if it has not been shown yet.
