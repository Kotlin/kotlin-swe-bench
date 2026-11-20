# Implement the issue(s) in ankidroid/Anki-Android:

## Issue #18623 https://github.com/ankidroid/Anki-Android/issues/18623: [Notes Mode] Selecting a note/card in the browser puts it in the first row

### Checked for duplicates?

- [x] This issue is not a duplicate

### Does it also happen in the desktop version?

- [x] This bug does not occur in the latest version of Anki Desktop

### What are the steps to reproduce this bug?

1. Open the browser.
2. Switch to notes mode.
3. Select a note that's not the first one.
4. The rows shift so that the selected note is at the top.
### Expected behaviour

Nothing moves.

### Debug info

```text
AnkiDroid Version = 2.21alpha22 (a668d71d90a9e54fd0691443a695f14cac155f81)  
Backend Version = 0.1.54-anki25.02.7 (25.02.7 98253c81cb3c4d203acec48d6eae6b488bf484d0)  
Android Version = 13 (SDK 33)  
ProductFlavor = full  
Device Info = Xiaomi | POCO | mondrian | mondrian_global | 23013PC75G | qcom  
Webview User Agent = Mozilla/5.0 (Linux; Android 13; 23013PC75G Build/TKQ1.220905.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/137.0.7151.90 Mobile Safari/537.36  
ACRA UUID = b9d03d9a-5af9-4e67-987e-cc15799171e2  
FSRS = 2.0.3 (Enabled: true)  
Crash Reports Enabled = true
```

### (Optional) Anything else you want to share?

**REGRESSION** in 2.21.

### Research

- [x] I have checked the [manual](https://ankidroid.org/docs/manual.html) and the [FAQ](https://github.com/ankidroid/Anki-Android/wiki/FAQ) and could not find a solution to my issue
- [x] (Optional) I have confirmed the issue is not resolved in the latest alpha release ([instructions](https://docs.ankidroid.org/manual.html#betaTesting))
