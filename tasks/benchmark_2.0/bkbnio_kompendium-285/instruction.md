Unable to use Generic Collection holder response (e.g. Page)
If the response type is defined as
```kotlin
data class Page<T>(
  val content: List<T>,
  val totalElements: Long,
  val totalPages: Int,
  val numberOfElements: Int,
  val number: Int,
  val size: Int
)
```
then Kompendium throws an exception
```
java.lang.ClassCastException: class kotlin.reflect.jvm.internal.KTypeParameterImpl cannot be cast to class kotlin.reflect.KClass (kotlin.reflect.jvm.internal.KTypeParameterImpl and kotlin.reflect.KClass are in unnamed module of loader 'app')
	at io.bkbn.kompendium.core.handler.CollectionHandler.handle(CollectionHandler.kt:27)
	at io.bkbn.kompendium.core.Kontent$generateKTypeKontent$2.invoke(Kontent.kt:91)
	at io.bkbn.kompendium.core.util.Helpers.logged(Helpers.kt:26)
	at io.bkbn.kompendium.core.Kontent.generateKTypeKontent(Kontent.kt:76)
	at io.bkbn.kompendium.core.handler.ObjectHandler.updateCache(ObjectHandler.kt:161)
	at io.bkbn.kompendium.core.handler.ObjectHandler.handleDefault(ObjectHandler.kt:98)
	at io.bkbn.kompendium.core.handler.ObjectHandler.generateFieldMap(ObjectHandler.kt:76)
	at io.bkbn.kompendium.core.handler.ObjectHandler.handle(ObjectHandler.kt:55)
	at io.bkbn.kompendium.core.Kontent$generateKTypeKontent$2.invoke(Kontent.kt:94)
	at io.bkbn.kompendium.core.util.Helpers.logged(Helpers.kt:26)
	at io.bkbn.kompendium.core.Kontent.generateKTypeKontent(Kontent.kt:76)
	at io.bkbn.kompendium.core.Kontent.generateKontent(Kontent.kt:53)
	at io.bkbn.kompendium.core.KompendiumPreFlight.addToCache(KompendiumPreFlight.kt:38)
```

Unfortunately I can't help you now. Will appreciate if you can fix it.

Thanks, 
Gennadi