# Implement the issue(s) in detekt/detekt:

## Issue #6442 https://github.com/detekt/detekt/issues/6442: Specific code causes false positive of UnconditionalJumpStatementInLoop

The following statement causes a false positive `UnconditionalJumpStatementInLoop: This loop contains an unconditional jump expression which essentially renders it useless as it will exit the loop during the first iteration.`:

```kotlin
inline fun <reified T> BlockingQueue<T>.pollEach(action: (T) -> Unit) {
    while (true) poll()?.let { action(it) } ?: break
}
```

Adding braces to the while statement appears to make it disappear. IntelliJ has a suggestion to remove these braces which restores the code above:

![image](https://github.com/detekt/detekt/assets/80681087/a8a13562-88ed-46ff-9044-7f65ee149f77)

As far as I know both variants are semantically equivalent and only differ in syntax.
The code polls the queue until poll returns null which then breaks out of the while loop:

```
java.util.Queue<E>
E poll()
Retrieves and removes the head of this queue, or returns null if this queue is empty.
Returns:
the head of this queue, or null if this queue is empty
 ```


## Expected Behavior
I expected it to not report said finding.

## Observed Behavior
It reported the code mentioned above as having `UnconditionalJumpStatementInLoop`

## Steps to Reproduce
Analyze following code:
```kotlin
inline fun <reified T> BlockingQueue<T>.pollEach(action: (T) -> Unit) {
    while (true) poll()?.let { action(it) } ?: break
}
```
making sure you have following configuration:
```
potential-bugs:
  active: true
  UnconditionalJumpStatementInLoop:
    active: true
```


## Context
It's a false positive that does not require fixing.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.23.1
* Version of Gradle used (if applicable): 8.1.1
* Gradle scan link (add `--scan` option when running the gradle task): –
* Operating System and version: Arch Linux (rolling)
* Link to your project (if it's a public repository): –

