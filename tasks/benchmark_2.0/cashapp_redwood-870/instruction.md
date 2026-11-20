Content.preload()
For LazyColumn it’ll be a performance win to run asynchronous guest code eagerly, before the target `TreehouseView` is attached. One possible way to implement this is a `preload()` function on `Content`:


```
public interface Content {
  /**
   * Prepare the content for an upcoming call to [bind]. This may yield
   * lower latency for lazy layouts.
   * 
   * To avoid resource leaks every call to [preload] must be followed by
   * a call to [unbind], whether or not there is a call to [bind].
   */
  public fun preload(view: TreehouseView)

  ...
}
```

The `preload` function doesn’t _really_ need the `TreehouseView` yet, but accepting it keeps the `hostConfiguration` quite simple. Otherwise we’d need to accept a `HostConfiguration` and fuse it to the `StateFlow<HostConfiguration>` that follows.

## Interface

The tests use these declarations:

- `app.cash.redwood.treehouse.SequentialStateFlow<T>(StateFlow<T>) : StateFlow<T>` with `val stateFlowValue: MutableStateFlow<StateFlow<T>>`
