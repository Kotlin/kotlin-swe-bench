# Implement the issue(s) in thunderbird/thunderbird-android:

## Issue: Valid e-mail recipient specification rejected (special characters)

### Checklist

- [X] I have used the search function to see if someone else has already submitted the same bug report.
- [X] I will describe the problem with as much detail as possible.

### App version

6.600

### Where did you get the app from?

F-Droid

### Android version

11

### Device model

QX1050 (FX Technology Pro1x)

### Steps to reproduce

1) Either copy e-mail address together with the sender name containing accented characters from a received e-mail (using the new functionality for displaying sender details) and paste it into the recipient address of a newly composed message, or type such an address anew - as an example, use something like: `"Tomáš Marný" <tomas@example.com>` (starting with the quote mark and finishing with the greater than sign).

2) Press "Tab" key, or change to a different field.

3) An exclamation mark appears next to the provided address. Clicking on the exclamation mark results in displaying "Special characters are not supported at the moment" (actually, I see a localized version of this message, thus the real English version of this message may be slightly different).

The point is - the recipient specification written this way is perfectly valid (even copied by K9 from a received message), but K9 refuses it.

### Expected behavior

No exclamation mark is displayed, provided address is used for the "To" header of the composed message and sent to the address between the "less than" and "greater than" signs after user sends the message.

### Actual behavior

The recipient specification is refused as described above.

### Logs

k9mail-logs_230421.txt is available at /task-assets/instruction/bdcb27b26901b5be.txt.

## Interface

The tests use these declarations:

- `com.fsck.k9.view.UserInputEmailAddressParser()` with `fun parse(String): List<Address>`
- `com.fsck.k9.view.NonAsciiEmailAddressException`, an exception
