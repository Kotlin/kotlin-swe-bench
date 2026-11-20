# Implement the issue(s) in Hannah-Sten/TeXiFy-IDEA:

## Issue #3122 https://github.com/Hannah-Sten/TeXiFy-IDEA/issues/3122: reference after punctuation

#### Type of JetBrains IDE (IntelliJ, PyCharm, etc.) and version
IntelliJ IDEA 2023.1.3 (Ultimate Edition)
Build #IU-231.9161.38, built on June 20, 2023


#### Operating System 
Windows 11 Pro
22H2


#### TeXiFy IDEA version
0.7.30


#### What I did (steps to reproduce)
Use a reference command (\cite, \ref,...) after a punctiuation, e.g. at the beginning of a sentence yields a "Reference without a non-breaking space" warning.
Regardless of whether this is good linguistic style, I think the warning is wrong in these places.


#### Minimal example to reproduce the problem
![grafik](https://github.com/Hannah-Sten/TeXiFy-IDEA/assets/24541714/7a58902d-2dd4-4ff9-908a-6f8e869ee2e3)


#### Expected behavior
No "Reference without a non-breaking space" warning after punctuation.


