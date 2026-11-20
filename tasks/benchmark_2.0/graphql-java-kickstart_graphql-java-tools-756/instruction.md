Subscription data fetcher return type should be checked
When you add a subscription resolver:

```java
public class ImportantEventSubscription implements GraphQLSubscriptionResolver {

    public String importantEvent(String id, DataFetchingEnvironment environment) {

        return "hi";
    }

}
```

```graphql
extend type Subscription {
  importantEvent(id: String!): String
}
```

The schema is parsed and built by `graphql-java-tools` without errors but then it fails on subscribe with:

```
graphql.AssertException: You data fetcher must return a Publisher of events when using graphql subscriptions
	at graphql.Assert.assertTrue(Assert.java:76) ~[graphql-java-13.0.jar:na]
	at graphql.execution.SubscriptionExecutionStrategy.lambda$createSourceEventStream$2(SubscriptionExecutionStrategy.java:74) ~[graphql-java-13.0.jar:na]
	at java.util.concurrent.CompletableFuture.uniApply(CompletableFuture.java:602) ~[na:1.8.0_152-ea]
	at java.util.concurrent.CompletableFuture.uniApplyStage(CompletableFuture.java:614) ~[na:1.8.0_152-ea]
	at java.util.concurrent.CompletableFuture.thenApply(CompletableFuture.java:1983) ~[na:1.8.0_152-ea]
	at graphql.execution.SubscriptionExecutionStrategy.createSourceEventStream(SubscriptionExecutionStrategy.java:71) ~[graphql-java-13.0.jar:na]
	at graphql.execution.SubscriptionExecutionStrategy.execute(SubscriptionExecutionStrategy.java:37) ~[graphql-java-13.0.jar:na]
	at graphql.execution.Execution.executeOperation(Execution.java:161) ~[graphql-java-13.0.jar:na]
	at graphql.execution.Execution.execute(Execution.java:102) ~[graphql-java-13.0.jar:na]
	at graphql.GraphQL.execute(GraphQL.java:605) ~[graphql-java-13.0.jar:na]
	at graphql.GraphQL.parseValidateAndExecute(GraphQL.java:538) ~[graphql-java-13.0.jar:na]
```

I think we could be checking that subscription data fetchers return `Publisher` during the schema validation step.