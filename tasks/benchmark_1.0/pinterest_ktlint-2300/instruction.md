# Implement the issue(s) in pinterest/ktlint:

## Issue #2297 https://github.com/pinterest/ktlint/issues/2297: NullPointerException when Ktlint runs the rule `multiline-expression-wrapping` during formatting

## Expected Behavior
The rule should at least pass without errors and tell me if there are linting issues or not

## Observed Behavior
When running the command `mvn antrun:run@ktlint-format` with this configuration in the `pom.xml` : 
```xml
<configuration>
    <target name="ktlint">
        <java taskname="ktlint" dir="${basedir}" fork="true" failonerror="true"
              classpathref="maven.plugin.classpath" classname="com.pinterest.ktlint.Main">
            <arg value="-F"/>
            <arg value="src/**/*.kt"/>
            <arg value="!src/**/test/**"/>
            <arg value="--disabled_rules=enum-entry-name-case,function-naming,no-consecutive-comments,comment-wrapping,package-name,no-empty-file,property-naming,filename"/>
        </java>
    </target>
</configuration>
```
I'm getting the error : 
```
Internal Error (rule 'standard:multiline-expression-wrapping') in DataFrameImpl.kt at position '0:0. Please create a ticket at https://github.com/pinterest/ktlint/issues and provide the source code that triggered an error.        
[INFO]    [ktlint] com.pinterest.ktlint.rule.engine.api.KtLintRuleException: Rule 'standard:multiline-expression-wrapping' throws exception in file 'DataFrameImpl.kt' at position (0:0)
...
Caused by: java.lang.NullPointerException
[INFO]    [ktlint]      at com.pinterest.ktlint.ruleset.standard.rules.MultilineExpressionWrappingRule.isElvisOperator(MultilineExpressionWrappingRule.kt:155)
...
```
(I copy-pasted the interesting parts of the stack trace but if you want the full stack-trace, please tell me)

## Steps to Reproduce
I'm linking to this issue 2 files where the exception arises at position 0:0, since i don't know where the bug comes from exactly in the files, I can't reduce the size of the code sample. Sorry for that
[KtFilesWithError.zip](https://github.com/pinterest/ktlint/files/12845064/KtFilesWithError.zip)

## My Environment
* Version of ktlint used: 
  1.0.0
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): 
  * Java version : 11.0.2
  * Maven version : 3.8.7
  * Plugin used for execution : org.apache.maven.plugins:maven-antrun-plugin:3.1.0
* Operating System and version:
  Windows 11 Professional Version 10.0.22621 Build 22621

