DictionaryResolverType should not use cached types as SchemaTransformation can modify schema objects.
## Description

The DictionaryResolverType was returning GraphQL Schema Objects from a cache, however if the shema is transformed by SchemaTransformer, these GraphQL Schema Objects can change.

As such we should resolve the GraphQLObjectType from the schema object rather than a local cache.

### Expected behavior

The DictionaryResolverType should return the same GraphQLObjectType instance as referenced in the schema.

### Actual behavior

The DictionaryResolverType returns a different instance GraphQLObjectType than the schema if it was transformed.

### Steps to reproduce the bug



```kotlin
    @Test
    fun `transformed schema should execute query`() {
        val transformedSchema = SchemaTransformer().transform(schema, Transformer())
        val transformedGql: GraphQL = GraphQL.newGraphQL(transformedSchema)
                .queryExecutionStrategy(AsyncExecutionStrategy())
                .build()

        val data = assertNoGraphQlErrors(transformedGql) {
            """
            {
                otherUnionItems {
                    ... on Item {
                        itemId: id
                    }
                    ... on ThirdItem {
                       thirdItemId: id
                    }
                }
            }
            """
        }

        assertEquals(data["otherUnionItems"], listOf(
                mapOf("itemId" to 0),
                mapOf("itemId" to 1),
                mapOf("thirdItemId" to 100)
        ))
    }
```