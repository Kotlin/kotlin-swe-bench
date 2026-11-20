SchemaClassScanner doesn't scan directive arguments
## Description

Custom scalars and input objects used in directives are not scanned, and subsequently their type cannot be determined when building directives in `SchemaParser`

### Expected behavior

```graphql
scalar CustomScalar
directive @something(arg: CustomScalar) on FIELD_DEFINITION

type Query {
    allProducts: [Product]
}

type Product {
    name: String @something(arg: "1")
}
```

Should parse successfully 

### Actual behavior

> graphql.kickstart.tools.SchemaError: Expected type 'CustomScalar' to be a GraphQLInputType, but it wasn't!  Was a type only permitted for object types incorrectly used as an input type, or vice-versa?