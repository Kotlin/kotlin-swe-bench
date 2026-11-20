# Implement the issue(s) in ankidroid/Anki-Android:

## Issue #13207 https://github.com/ankidroid/Anki-Android/issues/13207: [Bug] AnkiDroid fails to start if external storage does not exist (`getExternalFilesDir` is `null`)

> [!IMPORTANT]
> If you are seeing this on a Google Pixel device after phone data migration or upgrading to Android 16:
> * Some folder permissions on your phone are likely corrupted
> * Please +1 this upstream Google issue: https://issuetracker.google.com/issues/460912704 (+1 is on the top right corner)
> * Download and use AnkiDroid's `Parallel.A` apk from https://github.com/ankidroid/Anki-Android/releases/latest
>     * There will be bugs, this works around some of the storage corruption 
> * Wait for a fix from Google, or if desperate and can tolerate the ⚠️ **total loss of all data on the phone** ⚠️ a factory reset appears to fix the device, as long as you don't restore from a Google Pixel when setting up your phone again.

If you are not on a Pixel device, please comment on this issue so we can debug further.

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

![image](https://user-images.githubusercontent.com/782704/217049538-444a9a17-bdd2-47cf-8d10-af4a7a7ef837.png)

But here's a link to the offender in attempt to make up for it: https://github.com/ankidroid/Anki-Android/blob/bc6caf9d9e199e8f295d49c27bbb4fbfd859f183/AnkiDroid/src/main/java/com/ichi2/anki/CollectionHelper.kt#L492


I did get a toast saying "Device Storage Not Mounted" and the app quit, after uninstalling / reinstalling / granting storage permission

What if there is no external storage though? Should I be able to use AnkiDroid on only internal storage? That could be a valid device configuration ?

Storage config looks like this:

![image](https://user-images.githubusercontent.com/782704/217051806-13e4b041-0cda-4a42-bd88-3b61e82527bc.png)

There is supposed to be a 768MB sdcard in the AVD definition but it appears it is not mounted, this shows up in logs:

> StorageManagerService  system_process  W No primary storage defined yet; hacking together a stub

It is possible this configuration is simply invalid (are there any android devices that have no "external" storage?) as I am unable to run the storage system preferences app either (`Volume external_primary not found`)

But might be worth a look / some better messaging in case something like this is out in the wild.

I'll purge this AVD and try a different one

###### Debug info

Just one commit back on main at the moment - was built from this commit sha https://github.com/ankidroid/Anki-Android/commit/4cb853c1e10cd95669f810e5987c6ef7a7cf1918

###### Research
*Enter an [x] character to confirm the points below:*

- [ ] I have read the [support page](https://ankidroid.org/docs/help.html) and am reporting a bug or enhancement request specific to AnkiDroid
- [ ] I have checked the [manual](https://ankidroid.org/docs/manual.html) and the [FAQ](https://github.com/ankidroid/Anki-Android/wiki/FAQ) and could not find a solution to my issue
- [ ] I have searched for similar existing issues here and on the user forum
- [ ] (Optional) I have confirmed the issue is not resolved in the latest alpha release ([instructions](https://docs.ankidroid.org/manual.html#betaTesting))

</details>


