# Implement the issue(s) in ankidroid/Anki-Android:

## Issue #8188 https://github.com/ankidroid/Anki-Android/issues/8188: [Bug] Actual card type must be respected during copy

###### Reproduction Steps

1. Edit a 'Basic with answer input' type card
2. Copy this card to a new one
3. Now edit a Close type card
4. Copy this card to a new one


###### Expected Result
Card type is respected, so new card also has Close type


###### Actual Result
Card type is stuck and the latest copy type from step 2 is used (Basic in this case)
So after copying and editing several cards you can find all of them have wrong type
I'm sure that in 99.9% of cases user wants to copy both content and type, not just content
![anki](https://user-images.githubusercontent.com/10187203/111176658-94b17080-85ba-11eb-8cb1-1a0ccad508ff.gif)

###### Debug info
AnkiDroid Version = 2.14.6

Android Version = 10

ACRA UUID = 5ff72660-fb1e-445c-9a4a-cd46e651b63a

Scheduler = std2

Crash Reports Enabled = true

###### Research
*Enter an [x] character to confirm the points below:*

- [x] I have read the [support page](https://ankidroid.org/docs/help.html) and am reporting a bug or enhancement request specific to AnkiDroid
- [x] I have checked the [manual](https://ankidroid.org/docs/manual.html) and the [FAQ](https://github.com/ankidroid/Anki-Android/wiki/FAQ) and could not find a solution to my issue
- [x] I have searched for similar existing issues here and on the user forum
- [ ] (Optional) I have confirmed the issue is not resolved in the latest alpha release ([instructions](https://docs.ankidroid.org/manual.html#betaTesting))


