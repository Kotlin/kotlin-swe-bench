# Implement the issue(s) in detekt/detekt:

## Issue #5553 https://github.com/detekt/detekt/issues/5553: Allow AtomicBoolean to be named with "is"


## Expected Behavior of the rule
<!-- Explain the rule or changes to existing rules you're suggesting. -->
<!-- Be as detailed as possible and also provide code samples for the code that the rules should flag. -->
I saw this was suggested in https://github.com/detekt/detekt/issues/4675 but it was decided not to make this change at that time. I thought I'd bring it up for discussion as this causes extra suppressions in code that don't really have to happen.  

`val isDaytime = AtomicBoolean(true)` 

This code will trigger the rule `NonBooleanPropertyPrefixedWithIs` - but as an `AtomicBoolean` it makes sense for this to be called "is..". 

## Context
<!--- What are you trying to accomplish with this rule/change? -->
<!--- Providing context helps us come up with a solution that is most useful in the real world. -->
<!--- Please add links to official documentation or best practices such as code style guides if available. -->
`AtomicBoolean` should be treated as a normal `Boolean` as far as naming goes. This allows it to be used without surpassing rules and without extra gymnastics to name it something that is less meaningful. 

