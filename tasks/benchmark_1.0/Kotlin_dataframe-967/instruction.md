# Implement the issue(s) in Kotlin/dataframe:

## Issue #319 https://github.com/Kotlin/dataframe/issues/319: Rendering of IMG, IFrame appears to be broken

These 2 classes if presented in dataframe should be rendered in HTML to img and iframe tags. For me it didn't work. Our youtube example relies on this feature, so I went and checked if the previously working example is still intact, but the answer is no for IntelliJ project. In datalore its even worse, it breaks completely when i run cell with "load", although it doesn't even use any iframe or anything like that, only special rendering of URL. At this point i decided not to investigate Datalore issue further. 

