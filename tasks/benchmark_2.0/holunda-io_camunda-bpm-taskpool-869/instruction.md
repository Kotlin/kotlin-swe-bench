Filters on payload attributes cause multiple join of the same table
### Steps to reproduce

* camunda-bpm-taskpool version: any
* Camunda BPM version: any
* JDK version:  any
* Operating system: any
* Steps: (what exactly are you doing with the above reproducer?)
  * Create a TaskQuery for a JPA View that has multiple filters for payload attributes


### Expected behaviour
In order to filter based on payload attributes one join between the `plf_task` and `plf_task_payload_attributes` tables has to be performed. On this join result all the filter criteria for payload attributes can be evaluated.

### Actual behaviour
Each filter criterion is transformed into a specification by itself
```
internal fun Criterion.PayloadEntryCriterion.toTaskSpecification(): Specification<TaskEntity> {
  return when (this.operator) {
    EQUALS -> hasTaskPayloadAttribute(this.name, this.value)
    else -> throw IllegalArgumentException("JPA View currently supports only equals as operator for filtering of payload attributes.")
  }
}
```

and for each of these criteria a join is performed
```
    fun hasTaskPayloadAttribute(name: String, value: String): Specification<TaskEntity> =
      Specification { task, query, builder ->
        query.distinct(true)
        val join = task.join<TaskEntity, Set<PayloadAttribute>>(TaskEntity::payloadAttributes.name)
        val pathEquals = builder.equal(
          join.get<String>(PayloadAttribute::path.name),
          name
        )
        val valueEquals = builder.equal(
          join.get<String>(PayloadAttribute::value.name),
          value
        )
        builder.and(pathEquals, valueEquals)
      }
```

This results in the following pattern in the generated SQL
```
 select
        taskentity0_.task_id as task_id1_10_,
        taskentity0_.assignee_id as assignee2_10_,
        taskentity0_.business_key as business3_10_,
        taskentity0_.date_created as date_cre4_10_,
        taskentity0_.description as descript5_10_,
        taskentity0_.date_due as date_due6_10_,
        taskentity0_.date_follow_up as date_fol7_10_,
        taskentity0_.form_key as form_key8_10_,
        taskentity0_.name as name9_10_,
        taskentity0_.owner_id as owner_i10_10_,
        taskentity0_.payload as payload11_10_,
        taskentity0_.priority as priorit12_10_,
        taskentity0_.application_name as applica13_10_,
        taskentity0_.source_def_id as source_14_10_,
        taskentity0_.source_def_key as source_15_10_,
        taskentity0_.source_execution_id as source_16_10_,
        taskentity0_.source_instance_id as source_17_10_,
        taskentity0_.source_name as source_18_10_,
        taskentity0_.source_type as source_19_10_,
        taskentity0_.source_tenant_id as source_20_10_,
        taskentity0_.task_def_key as task_de21_10_ 
    from
        plf_task taskentity0_ 
    inner join
        plf_task_payload_attributes payloadatt1_ 
            on taskentity0_.task_id=payloadatt1_.task_id 
    inner join
        plf_task_payload_attributes payloadatt2_ 
            on taskentity0_.task_id=payloadatt2_.task_id 
    where
        (
            payloadatt1_.path=? 
            and payloadatt1_.value=? 
            or payloadatt2_.path=? 
            and payloadatt2_.value=?
        ) 
        and (
            ? in (
                select
                    authorized3_.authorized_principal 
                from
                    plf_task_authorizations authorized3_ 
                where
                    taskentity0_.task_id=authorized3_.task_id
            ) 
            or ? in (
                select
                    authorized4_.authorized_principal 
                from
                    plf_task_authorizations authorized4_ 
                where
                    taskentity0_.task_id=authorized4_.task_id
            ) 
            or taskentity0_.assignee_id=?
        ) 
    order by
        taskentity0_.date_created desc limit ?
```

In the above example two filter criteria on the task payload were given, which results in consecutive joins of the task and payload table.
`(plf_task join plf_task_payload_attributes) join plf_task_payload_attributes)`

This means that the resulting joined table grows exponentially with the number of filters, even though only one single join of these tables would be necessary.

One way to eliminate this would be to build the specification from the whole list of criteria on the payload and only joining once there. The question is how the signature for that method would look like. Because we wouldn't really want to determine the composition logic in the method so we would have to find a way to represent the composition in the parameters to make the conversion to the JPA specification more generic.

## Interface

The tests use these declarations:

- `io.holunda.polyflow.view.jpa.data.DataEntryRepository.hasDataEntryPayloadAttribute` and `io.holunda.polyflow.view.jpa.task.TaskRepository.hasTaskPayloadAttribute`: the second parameter becomes `List<String>`
