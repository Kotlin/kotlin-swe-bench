# Implement the issue(s) in detekt/detekt:

## Issue #7665 https://github.com/detekt/detekt/issues/7665: Stop using absolute paths in SARIF output

## Expected Behavior
Gradle task output should be relocatable. The SARIF report output should not include any absolute paths in its output.

## Current Behavior
<!--- If suggesting a change/improvement, explain the difference from the current behavior -->
We use absolute paths in SARIF report output. When this report output is cached and the project under analysis is checked out under a different path the absolute path will not be valid.

## Context
Report output should be cacheable and avoid things like absolute file paths where possible. GitHub also ignores values set in the SARIF report and uses [other methods](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning#specifying-the-root-for-source-files) to set the root path for source files:

> You can provide the source root for conversion from absolute to relative URIs in one of the following ways.
> 
> * [checkout_path](https://github.com/github/codeql-action/blob/c2c0a2908e95769d01b907f9930050ecb5cf050d/analyze/action.yml#L44-L47) input to the github/codeql-action/analyze action
> * checkout_uri parameter to the SARIF upload API endpoint. For more information, see "[REST API endpoints for code scanning](https://docs.github.com/en/rest/code-scanning/code-scanning#upload-an-analysis-as-sarif-data)."
> * [invocations[0].workingDirectory.uri](https://docs.oasis-open.org/sarif/sarif/v2.1.0/csprd01/sarif-v2.1.0-csprd01.html#_Toc9244365) property in the run object in the SARIF file

The last point above references [`workingDirectory` property](https://docs.oasis-open.org/sarif/sarif/v2.1.0/csprd01/sarif-v2.1.0-csprd01.html#_Toc10541024) which is probably more appropriate for our purposes, but also comes with the warning "Absolute path names can reveal information that might be sensitive" which we should also consider.

The SARIF spec says `uriBaseId` SHOULD be used when paths are relative, but this is not required, so we remain spec compliant and can rely on consumers doing the right thing if we rely exclusively on relative paths.

Relates to #7170
