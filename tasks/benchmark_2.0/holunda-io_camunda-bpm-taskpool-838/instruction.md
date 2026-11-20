Use logical OR operator to combine criteria on the same property
### Scenario

* camunda-bpm-taskpool version: any
* Camunda BPM version: any
* Description of your use case: filtering tasks an data entries allows to provide multiple properties which are combined using the logical AND operator. This implementation makes a lot of sense on different properties (more filters will reduce the number of results), but becomes useless if the "equals" compare is applied to the same properties ( in general prop=X&&prop=Y can't be fulfilled and will deliver zero results)

### Current Behaviour

All properties are combined with AND


### Wanted Behaviour

Configurable, with ability to combine predicated with OR if applied on the same property.

### Possible Workarounds

None

## Requirements

- The JPA view supports the task filter `task.priority=<integer>`; a non-integer value such as `task.priority=foo` throws `NumberFormatException` with the message `For input string: "foo"`.
