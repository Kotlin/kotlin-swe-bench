SimpleSchema chema added via addCustomTypeSchema ignores format field if specified.
**Describe the bug**
If I use such configuration:
```
install(Kompendium) {
    spec = Util.baseSpec
    // Tells Kompendium how to handle a specific type
    addCustomTypeSchema(Instant::class, SimpleSchema(type = "string", format = "date-time"))
  }
```

and will use `Instant` type in models - `format` setting will be ignored.

**To Reproduce**
Steps to reproduce the behavior:
1. Oepn `CustomTypePlaygroind` example in `kompendium-playground` module
2. Change install part as described above.
3. Lanuch `main()`
4. Open `/openapi.json` and you'll see for `Instant` field such definition:
```
"timestamp": {
   "type": "string"
}
```

**Expected behavior**
There should be such definition:
```
"timestamp": {
   "type": "string",
   "format": "date-time"
}
```

**Additional context**
Format may be important in some cases because it helps Swagger UI to identify how example must be generated according to it.