# Implement the issue(s) in pinterest/ktlint:

## Issue: Traversion directory tree with relative patterns referring to directories outside work directory

If Ktlint CLI is started with a glob that refers to a directory that is not a child directory of the current working directory than no files in that directory will be found. The problem seems especially to occur when using Bash as it deals differently with glob expansion.

The easiest reproduction is running `ktlint ../project-directory/src/**/*.kt` in some subdirectory other than `project-directory`.
            