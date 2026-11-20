# Implement the issue(s) in ankidroid/Anki-Android:

## Issue: Insert field sometimes adds fields to the wrong card type

### Checked for duplicates?

- [x] This issue is not a duplicate

### Does it also happen in the desktop version?

- [x] This bug does not occur in the latest version of Anki Desktop

### What are the steps to reproduce this bug?

1. Edit the template of a basic note type.
2. Add a card type.
3. Switch to Card 1.
4. Switch back to Card 2.
5. Try to insert fields.

Alternatively:

1. Edit the template of a basic and reversed note type.
2. Switch to Card 2 then back to Card 1.
3. Try to insert fields.

The reproduction video is available at `/task-assets/instruction/96442ba1a58d5fd5.mp4`.


### Expected behaviour

The field replacement should be inserted in the current card type's template.

### Debug info

```text
AnkiDroid Version = 2.23.0alpha4 (fb3fadbdebac9b191096a739e730d47ad9f6db09)  
Backend Version = 0.1.61-anki25.09 (25.09 539054c34dccf8b89ca7ea9c9c40ecaf172de759)  
Android Version = 13 (SDK 33)  
ProductFlavor = full  
Device Info = Xiaomi | POCO | mondrian | mondrian_global | 23013PC75G | qcom  
Webview User Agent = Mozilla/5.0 (Linux; Android 13; 23013PC75G Build/TKQ1.220905.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/140.0.7339.208 Mobile Safari/537.36  
ACRA UUID = b9d03d9a-5af9-4e67-987e-cc15799171e2  
FSRS = 5.1.0 (Enabled: true)  
Crash Reports Enabled = true
```

### (Optional) Anything else you want to share?

_No response_

### Research

- [x] I have checked the [manual](https://ankidroid.org/docs/manual.html) and the FAQ and could not find a solution to my issue
- [x] (Optional) I have confirmed the issue is not resolved in the latest alpha release ([instructions](https://docs.ankidroid.org/manual.html#betaTesting))

## Interface

The tests use these declarations:

- `val insertFieldRequestKey: String` in `com.ichi2.anki.CardTemplateEditor.CardTemplateFragment`
