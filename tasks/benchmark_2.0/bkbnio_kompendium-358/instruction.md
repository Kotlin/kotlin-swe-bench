Add support for ktor Resources in addition to / instead of Locations
**Is your feature request related to a problem? Please describe.**

According to [Locations documentation](https://ktor.io/docs/locations.html), the plugin is deprecated and [Resources](https://ktor.io/docs/type-safe-routing.html) should be used instead:

> In v2.0.0, the Locations plugin is deprecated. Use the [Resources](https://ktor.io/docs/type-safe-routing.html) plugin instead.

**Describe the solution you'd like**

Replace the kompendium-locations plugin with kompendium-resources. Looking at the code, a simple copy-paste of existing plugin code with some renaming and adding support for `Resource` annotations should do the trick. (Can also just add a new plugin in addition to existing locations, but I don't see much point in keeping a plugin for deprecated ktor functionality.)

**Describe alternatives you've considered**

The workaround I'm using now is annotating the resource with both `Location` and `Resource` annotations. It seems to work, but is not a very good option.