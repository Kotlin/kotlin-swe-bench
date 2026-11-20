# Implement the issue(s) in ankidroid/Anki-Android:

## Issue #19968 https://github.com/ankidroid/Anki-Android/issues/19968: Note type search is case sensitive and can't be deleted quickly

### Checked for duplicates?

- [x] This issue is not a duplicate

### Does it also happen in the desktop version?

- [x] This bug does not occur in the latest version of Anki Desktop

### What are the steps to reproduce this bug?

1. Got to manage note types.
2. Search for "basic".
3. Try deleting the search text by long pressing the delete button on the keyboard.

It won't show the Basic note type due to case sensitivity. Also, only one character will be deleted at a time.

https://github.com/user-attachments/assets/a95b1af9-994a-4d43-9507-8b64cf194dc3

### Expected behaviour

Case insensitive + quickly delete the characters when long pressing the delete key.

### Debug info

```text
AnkiDroid Version = 2.23.1 (3f3133b496b531383e9a6494f5a7704634935308)  
Backend Version = 0.1.62-anki25.09.2 (25.09.2 3890e12c9e48c028c3f12aa58cb64bd9f8895e30)  
Android Version = 13 (SDK 33)  
ProductFlavor = full  
Device Info = Xiaomi | POCO | mondrian | mondrian_global | 23013PC75G | qcom  
Webview User Agent = Mozilla/5.0 (Linux; Android 13; 23013PC75G Build/TKQ1.220905.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.115 Mobile Safari/537.36  
ACRA UUID = 4afc3b3f-e93f-4a66-bc71-2b9476ef9eb0  
FSRS = 5.1.0 (Enabled: true)  
Crash Reports Enabled = true
```

### (Optional) Anything else you want to share?

Two tiny bugs hopefully fit in a single issue.

### Research

- [x] I have checked the [manual](https://ankidroid.org/docs/manual.html) and the [FAQ](https://github.com/ankidroid/Anki-Android/wiki/FAQ) and could not find a solution to my issue
- [x] (Optional) I have confirmed the issue is not resolved in the latest alpha release ([instructions](https://docs.ankidroid.org/manual.html#betaTesting))
