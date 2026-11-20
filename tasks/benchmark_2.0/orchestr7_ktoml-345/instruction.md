Cannot deserialize a list of Enums
```kotlin
import com.akuleshov7.ktoml.Toml
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString

enum class Enum {
    A,
    B,
    C
}

@Serializable
data class Enums(
    val enums: List<Enum>
)

fun main() {
    val enums = Enums(listOf(Enum.A, Enum.B, Enum.C))

    val toml = Toml()
    val encoded = toml.encodeToString(enums)
    println(encoded)
    println(toml.decodeFromString<Enums>(encoded))
}
```

Gives:

```
enums = [ "A", "B", "C" ]
Exception in thread "main" java.lang.ClassCastException: class java.lang.String cannot be cast to class java.lang.Integer (java.lang.String and java.lang.Integer are in module java.base of loader 'bootstrap')
	at kotlinx.serialization.encoding.AbstractDecoder.decodeEnum(AbstractDecoder.kt:35)
	at com.akuleshov7.ktoml.decoders.TomlArrayDecoder.decodeEnum(TomlArrayDecoder.kt:91)
	at kotlinx.serialization.internal.EnumSerializer.deserialize(Enums.kt:136)
	at kotlinx.serialization.internal.EnumSerializer.deserialize(Enums.kt:102)
	at kotlinx.serialization.encoding.Decoder.decodeSerializableValue(Decoding.kt:258)
	at com.akuleshov7.ktoml.decoders.TomlAbstractDecoder.decodeSerializableValue(TomlAbstractDecoder.kt:116)
	at com.akuleshov7.ktoml.decoders.TomlArrayDecoder.decodeSerializableValue(TomlArrayDecoder.kt:97)
	at kotlinx.serialization.encoding.AbstractDecoder.decodeSerializableValue(AbstractDecoder.kt:43)
	at kotlinx.serialization.encoding.AbstractDecoder.decodeSerializableElement(AbstractDecoder.kt:70)
	at kotlinx.serialization.encoding.CompositeDecoder.decodeSerializableElement$default(Decoding.kt:539)
	at kotlinx.serialization.internal.CollectionLikeSerializer.readElement(CollectionSerializers.kt:80)
	at kotlinx.serialization.internal.AbstractCollectionSerializer.readElement$default(CollectionSerializers.kt:51)
	at kotlinx.serialization.internal.AbstractCollectionSerializer.merge(CollectionSerializers.kt:36)
	at kotlinx.serialization.internal.AbstractCollectionSerializer.deserialize(CollectionSerializers.kt:43)
	at kotlinx.serialization.encoding.Decoder.decodeSerializableValue(Decoding.kt:258)
	at com.akuleshov7.ktoml.decoders.TomlAbstractDecoder.decodeSerializableValue(TomlAbstractDecoder.kt:116)
	at kotlinx.serialization.encoding.AbstractDecoder.decodeSerializableValue(AbstractDecoder.kt:43)
	at kotlinx.serialization.encoding.AbstractDecoder.decodeSerializableElement(AbstractDecoder.kt:70)
	at Enums$$serializer.deserialize(Agent.kt:12)
	at Enums$$serializer.deserialize(Agent.kt:12)
	at kotlinx.serialization.encoding.Decoder.decodeSerializableValue(Decoding.kt:258)
	at com.akuleshov7.ktoml.decoders.TomlAbstractDecoder.decodeSerializableValue(TomlAbstractDecoder.kt:116)
	at com.akuleshov7.ktoml.decoders.TomlMainDecoder$Companion.decode(TomlMainDecoder.kt:298)
	at com.akuleshov7.ktoml.Toml.decode(Toml.kt:158)
	at com.akuleshov7.ktoml.Toml.decodeFromString(Toml.kt:50)
	at AgentKt.main(Agent.kt:26)
	at AgentKt.main(Agent.kt)
```