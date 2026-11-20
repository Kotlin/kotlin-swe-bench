[Feature request]: Send standard client headers on all requests
### General Info

- [x] I installed the latest version of Supabase Kt
- [x] I checked for similar feature requests

### Feature request

For improving our internal usage reports, we need to send some client headers in all requests performed by the library.

Please include following headers:

- `x-supabase-client-platform`: which platform of operating system on which the client is running `"Android"`, `"Chrome OS"`, `"Chromium OS"`, `"iOS"`, `"Linux"`, `"macOS"`, `"Windows"`
- `x-supabase-client-platform-version`: version of the platform/operating system which the client is running `11.0.0` 

If value cannot be defined for some reason, send none.

Reference Swift PR merge commit: `ad031c7e14c4881b76ac1e24ef2738c8c1cf621e`.

### Usecase

_No response_

## Interface

The tests use these declarations:

- `io.github.jan.supabase.OSInformation(name: String, version: String)` with properties `name` and `version`
- `fun getOSInformation(): OSInformation?`, top-level in `io.github.jan.supabase`
- `var osInformation: OSInformation?` in `io.github.jan.supabase.SupabaseClientBuilder`
